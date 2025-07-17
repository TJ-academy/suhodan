package com.example.suhodan.donation;

import java.io.File;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.suhodan.mail.HtmlEmailService;
import com.example.suhodan.reward.RewardDAO;
import com.example.suhodan.reward.RewardDTO;
import com.example.suhodan.userbadge.UserBadgeDAO;
import com.example.suhodan.util.PageInfo;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/donation/*")
public class DonationConController {
	@Autowired
	DonationConDAO donationConDao;
	@Autowired
	UserBadgeDAO userBadgeDao;
	@Autowired
	RewardDAO rewardDao;
	@Autowired
	HtmlEmailService htmlEmailService;
	
	@GetMapping("write.do")
	public String write() {
		return "donation/donationCon_write";
	}
	
	@RequestMapping("insert.do")
	public String insert(DonationConDTO dto, HttpServletRequest request) {
		String filename = "-";
		if(!dto.getFile1().isEmpty()) {
			filename = dto.getFile1().getOriginalFilename();
			try {
				ServletContext application = request.getSession().getServletContext();
				String path = application.getRealPath("/resources/donation_img/");
				new File(path).mkdir();
				dto.getFile1().transferTo(new File(path + filename));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		dto.setFilename(filename);
		donationConDao.insert(dto);
		return "redirect:/donation/list.do";
	}
	
	@GetMapping("list.do")
	public ModelAndView list(
	    @RequestParam(value = "curPage", required = false, defaultValue = "1") int curPage,
	    ModelAndView mav
	) {
		//---------<페이지네이션>
	    int pageSize = 8; // 한 페이지에 보여줄 개수
	    int totalCount = donationConDao.getCount(); // 전체 글 수 (DAO에 메서드 추가 필요)
	    // 페이지 계산 유틸
	    PageInfo pageInfo = new PageInfo(totalCount, curPage, pageSize);
	    // 범위만큼 데이터 조회 (DAO에 start/end 넘기는 메서드 필요)
	    Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("start", pageInfo.getStartIndex());
	    paramMap.put("end", pageInfo.getEndIndex());
	    List<DonationConDTO> list = donationConDao.listPaging(paramMap);
		//---------<D-DAY 계산>
	    for (DonationConDTO dto : list) {
	        if (dto.getEnd_date() != null) {
	            LocalDate end = dto.getEnd_date().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
	            long dDay = ChronoUnit.DAYS.between(LocalDate.now(), end);
	            dto.setDday(dDay);
	        } else {
	            //dto.setdday(0); // 또는 적절한 기본값
	        	dto.setDday(0);
	        }
	        System.out.println("dDay: " + dto.getDday());
	    }
	    //---------<View 및 데이터 전달>
	    mav.setViewName("/donation/con_list");
	    mav.addObject("list", list);
	    System.out.println("list:"+list.get(0));
	    mav.addObject("map", Map.of("page_info", pageInfo)); // JSP에서 ${map.page_info.xxx}로 사용
	    return mav;
	}
	
	@GetMapping("edit/{content_id}")
	public ModelAndView edit(@PathVariable(name = "content_id") int content_id, ModelAndView mav) {
		mav.setViewName("/donation/con_edit");
		mav.addObject("dto", donationConDao.detail(content_id));
		return mav;
	}
	
	@PostMapping("update.do")
	public String update(DonationConDTO dto, HttpServletRequest request) {
		String filename = "-";
		if(!dto.getFile1().isEmpty()) {
			filename = dto.getFile1().getOriginalFilename();
			try {
				ServletContext application = request.getSession().getServletContext();
				String path = application.getRealPath("/resources/donation_img/");
				new File(path).mkdir();
				dto.getFile1().transferTo(new File(path + filename));
			} catch (Exception e) {
				e.printStackTrace();
			}
			dto.setFilename(filename);
		} else {
			DonationConDTO dto2 = donationConDao.detail(dto.getContent_id());
			dto.setFilename(dto2.getFilename());
		}
		donationConDao.update(dto);
		return "redirect:/donation/list.do";
	}
	
	@PostMapping("delete.do")
	public String delete(@RequestParam(name = "content_id") int content_id, HttpServletRequest request) {
		String filename = donationConDao.file_info(content_id);
		if(filename != null && !filename.equals("-")) {
			ServletContext application = request.getSession().getServletContext();
			String path = application.getRealPath("/resources/donation_img/");
			File f = new File(path + filename);
			if(f.exists())
				f.delete();
		}
		donationConDao.delete(content_id);
		return "redirect:/donation/list.do";
	}
	
	@GetMapping("detail/{content_id}")
	public ModelAndView detail(@PathVariable(name="content_id") int content_id, ModelAndView mav) {
		mav.setViewName("/donation/donation_detail");
		mav.addObject("dto", donationConDao.detail(content_id));
		return mav;
	}
	
	//후원하기
	@GetMapping("pay.do")
	public ModelAndView pay(@RequestParam("content_id") int content_id, ModelAndView mav) {
		//캠페인 상세 정보 조회
		DonationConDTO dto = donationConDao.detail(content_id);
		
		mav.setViewName("/donation/donation_pay");
		mav.addObject("dto", dto); //캠페인 정보 전달
		return mav;
	}
	
	// 결제처리
	@PostMapping("payment/verify.do")
	@ResponseBody
	public Map<String, Object> verifyPayment(@RequestBody Map<String, Object> payload, HttpSession session) {
	    Map<String, Object> result = new HashMap<>();
	    try {
	        // 세션에서 로그인한 사용자 ID 가져오기
	        String userId = (String) session.getAttribute("user_id");
	        if (userId == null) {
	            result.put("result", "unauthorized");
	            return result; // 로그인 안된 경우 처리
	        }

	        DonationTransactionDTO tx = new DonationTransactionDTO();
	        tx.setContent_id((int) payload.get("content_id"));
	        tx.setAmount(Integer.parseInt(payload.get("amount").toString()));
	        tx.setDonor_id(userId); // 로그인된 사용자 ID 사용
	        tx.setDonation_date(new java.sql.Date(System.currentTimeMillis()));
	        tx.setPayment_method((String) payload.get("payment_method"));
	        tx.setStatus((String) payload.get("status"));
	        tx.setMerchant_uid((String) payload.get("merchant_uid"));
	        tx.setImp_uid((String) payload.get("imp_uid"));

	        donationConDao.insertTransaction(tx); // DAO 메서드 호출

	        // 뱃지 발급 (5만원 이상 결제 시)
	        String badgeMessage = null;
	        String location = null;
	        if (tx.getAmount() >= 50000) {
	            userBadgeDao.insertBadgeForQualifiedUsers();
	            location = userBadgeDao.getBadgeLocationForUser(userId);  // 지역 이름 가져오기
	            badgeMessage = location + " 뱃지가 발급되었습니다."; // 지역 뱃지 발급 메시지
	        }
	        
	     // 이메일 전송 (선택한 경우)
	        boolean sendEmail = (boolean) payload.get("send_email");
	        if (sendEmail) {
	            String buyerEmail = (String) payload.get("buyer_email");
	            String subject = "기부 내역";
	            
	         // 기부금액 포맷 (3자리마다 컴마 추가)
	            String formattedAmount = String.format("%,d", tx.getAmount());
	            
	            String htmlBody = "<h2>기부 내역</h2>"
	                    + "<p>안녕하세요, " + userId + " 님!</p>"
	                    + "<p>기부금액 : " + formattedAmount + "원</p>"
	                    + "<p>당신의 따뜻한 마음에 진심으로 감사드립니다.</p>"
	                    + "<p>당신의 후원은 작은 마을의 내일을 지키는 큰 힘이 될 것입니다.</p>"
	                    + "<p>기부금은 해당 지역사회 발전에 소중히 사용될 예정입니다.</p>"
	                    + "<p>당신의 따뜻한 손길이 이곳에서 많은 사람들에게 희망을 전달할 것입니다.</p>"
	                    + "<p>후원해 주셔서 감사합니다. 함께 나누는 세상이 더 아름답습니다!</p>"
	                    + "<p>감사합니다.</p>"
	                    + "<p><strong>우리의 작은 변화가 큰 세상을 만듭니다.</strong></p>";
	            htmlEmailService.sendHtmlMessage(buyerEmail, subject, htmlBody); // HTML 이메일 전송
	        }

	        result.put("result", "success");
	        result.put("badge", badgeMessage); // 뱃지 발급 메시지 포함
	    } catch (Exception e) {
	        e.printStackTrace();
	        result.put("result", "error");
	    }
	    return result;
	}


	@GetMapping("info/{content_id}")
	public ModelAndView info(@PathVariable(name="content_id") int content_id, ModelAndView mav) {
		mav.setViewName("/donation/donation_info");
		mav.addObject("content_id", content_id);
		return mav;
	}
	
	@GetMapping("/reward/select.do") 
	public ModelAndView selectRewardPage(@RequestParam("amount") int amount, @RequestParam("content_id") int content_id, ModelAndView mav) {
		
		int reward_a_id = donationConDao.getRewardAByContentId(content_id);
		int reward_b_id = donationConDao.getRewardBByContentId(content_id);
		int reward_c_id = donationConDao.getRewardCByContentId(content_id);
		int reward_d_id = donationConDao.getRewardDByContentId(content_id);
		
	    String reward_a_name = rewardDao.getRewardDetailsById(reward_a_id).getName();
	    String reward_a_description = rewardDao.getRewardDetailsById(reward_a_id).getDescription();
	    String reward_b_name = rewardDao.getRewardDetailsById(reward_b_id).getName();
	    String reward_b_description = rewardDao.getRewardDetailsById(reward_b_id).getDescription();
	    String reward_c_name = rewardDao.getRewardDetailsById(reward_c_id).getName();
	    String reward_c_description = rewardDao.getRewardDetailsById(reward_c_id).getDescription();
	    String reward_d_name = rewardDao.getRewardDetailsById(reward_d_id).getName();
	    String reward_d_description = rewardDao.getRewardDetailsById(reward_d_id).getDescription();
	    
	    mav.setViewName("donation/reward_select"); 
	    mav.addObject("amount", amount);
	    
	    mav.addObject("reward_a_id", reward_a_id);
	    mav.addObject("reward_b_id", reward_b_id);
	    mav.addObject("reward_c_id", reward_c_id);
	    mav.addObject("reward_d_id", reward_d_id);
	    mav.addObject("reward_a_name", reward_a_name);
	    mav.addObject("reward_b_name", reward_b_name);
	    mav.addObject("reward_c_name", reward_c_name);
	    mav.addObject("reward_d_name", reward_d_name);
	    mav.addObject("reward_a_description", reward_a_description);
	    mav.addObject("reward_b_description", reward_b_description);
	    mav.addObject("reward_c_description", reward_c_description);
	    mav.addObject("reward_d_description", reward_d_description);
	    
	    return mav;
	}
	
	@GetMapping("buy.do")
	public ModelAndView buyRewardPage(
	    @RequestParam("amount") int amount,
	    @RequestParam("tier") String tier,
	    ModelAndView mav
	) {
	    // RewardDTO는 tier에 따라 하드코딩된 값 세팅 가능
	    RewardDTO reward = new RewardDTO();
	    reward.setPrice_type("0원"); // 항상 0원

	    if ("15-30".equals(tier)) {
	        reward.setName("15,000원 이상 리워드");
	        reward.setGoods_1_name("설화 스티커 5종");
	        reward.setGoods_2_name("엽서 세트");
	    } else if ("30-50".equals(tier)) {
	        reward.setName("30,000원 이상 리워드");
	        reward.setGoods_1_name("엽서 세트");
	        reward.setGoods_2_name("안동 사과 2kg + 사과주스");
	    }
	    // 나머지 구간도 조건문으로 분기

	    mav.setViewName("donation/buy"); // buy.jsp
	    mav.addObject("reward", reward);
	    return mav;
	}



	
}
