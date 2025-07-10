package com.example.suhodan.donation;

import java.io.File;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
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

import com.example.suhodan.util.PageInfo;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/donation/*")
public class DonationConController {
	@Autowired
	DonationConDAO donationConDao;
	
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

	        result.put("result", "success");
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

	
}
