package com.example.suhodan.member.mypage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.suhodan.donation.DonationDetailDAO;
import com.example.suhodan.donation.DonationDetailDTO;
import com.example.suhodan.donation.DonationHistoryDAO;
import com.example.suhodan.donation.DonationHistoryDTO;

import jakarta.servlet.http.HttpSession;

@Controller
public class MypageController {
	@Autowired 
	MypageDAO mypageDAO;
	@Autowired
	DonationHistoryDAO mydonationDAO;
	@Autowired
	DonationDetailDAO donationDetailDAO;
	
	//나의 수호수
	@GetMapping("/mypage/mytree")
	public String mytree(HttpSession session, Model model, 
			@RequestParam(name="page", defaultValue = "1") int page) {
		String user_id = (String) session.getAttribute("user_id");
		
		// 페이징 설정
	    int maxbadge = 9;   //한 페이지에 보여지는 최대 개수
	    int startRow = (page - 1) * maxbadge + 1;
	    int endRow = page * maxbadge;
	    
		List<MypageDTO> paged = mypageDAO.getUserBadgesPaged(user_id, startRow, endRow);
		/* List<MypageDTO> blist = mypageDAO.getUserBadge(user_id); */
		int totalBadges = mypageDAO.getUserBadgeCount(user_id);
		int totalPage = (int) Math.ceil((double) totalBadges / maxbadge);
		
		/* model.addAttribute("blist", blist); */
		model.addAttribute("blist", paged);
		model.addAttribute("currentPage", page);
	    model.addAttribute("totalPage", totalPage);
		return "member/mypage/mytree";
	}
	
	//명패함
	@GetMapping("/mypage/mybadges")
	public String mybadges(HttpSession session, Model model, 
			@RequestParam(name="page", defaultValue = "1") int page) {
		String user_id = (String) session.getAttribute("user_id");
		
		// 페이징 설정
	    int maxbadge = 9;   //한 페이지에 보여지는 최대 개수
	    int startRow = (page - 1) * maxbadge + 1;
	    int endRow = page * maxbadge;
	    
	    List<MypageDTO> paged = mypageDAO.getUserBadgesPaged(user_id, startRow, endRow);
		List<MypageDTO> blist = mypageDAO.getUserBadge(user_id);
	    int totalBadges = mypageDAO.getUserBadgeCount(user_id);
	    int totalPage = (int) Math.ceil((double) totalBadges / maxbadge);
	    
	    model.addAttribute("paged", paged);
		model.addAttribute("blist", blist);
		model.addAttribute("currentPage", page);
	    model.addAttribute("totalPage", totalPage);
		return "member/mypage/mybadges";
	}
	
	@GetMapping("/mypage/mybadges/{badge_id}")
	public ModelAndView mbdetail(@PathVariable(name = "badge_id") int badge_id, 
			ModelAndView mav,
			HttpSession session) {
		String user_id = (String) session.getAttribute("user_id");
		mav.setViewName("/member/mypage/mybadges_detail");
		mav.addObject("dto", mypageDAO.badgeDetail(user_id, badge_id));
		return mav;
	}
	
	// 기부내역 페이징 처리
	@GetMapping("/mypage/mydonation")
	public String mydonation(
	        @RequestParam(value = "page", defaultValue = "1") int page,  // 페이지 번호 받기, 기본 1
	        HttpSession session, Model model) {

	    String donor_id = (String) session.getAttribute("user_id");
	    List<DonationHistoryDTO> fullList = mydonationDAO.list(donor_id);

	    int pageSize = 3;  // 한 페이지에 보여줄 카드 개수
	    int totalCount = fullList.size();
	    int totalPage = (int) Math.ceil((double) totalCount / pageSize);

	    // 페이지 번호 범위 체크
	    if(page < 1) page = 1;
	    if(page > totalPage) page = totalPage;

	    int startIndex = (page - 1) * pageSize;
	    int endIndex = Math.min(startIndex + pageSize, totalCount);

	    List<DonationHistoryDTO> pageList = fullList.subList(startIndex, endIndex);

	    model.addAttribute("dlist", pageList);
	    model.addAttribute("currentPage", page);
	    model.addAttribute("totalPage", totalPage);

	    return "member/mypage/mydonation_history";
	}
	
	//기부내역
	/*
	@GetMapping("/mypage/mydonation")
	public String mydonation(HttpSession session, Model model) {
		String donor_id = (String) session.getAttribute("user_id");
		List<DonationHistoryDTO> dlist = mydonationDAO.list(donor_id);
		model.addAttribute("dlist", dlist);
		return "member/mypage/mydonation_history";
	}
	*/
	
	@GetMapping("/mypage/mydonation/{content_id}")
	public String donationDetail(
	        @PathVariable("content_id") int contentId,
	        @RequestParam(value = "page", defaultValue = "1") int page,  // 페이지 번호 받기, 기본 1
	        HttpSession session, Model model) {

	    String donorId = (String) session.getAttribute("user_id");
	    List<DonationDetailDTO> fullList = donationDetailDAO.getDetail(contentId, donorId);

	    int pageSize = 1;  // 한 페이지에 보여줄 카드 개수
	    int totalCount = fullList.size();
	    int totalPage = (int) Math.ceil((double) totalCount / pageSize);

	    // 페이지 번호 범위 체크
	    if(page < 1) page = 1;
	    if(page > totalPage) page = totalPage;

	    int startIndex = (page - 1) * pageSize;
	    int endIndex = Math.min(startIndex + pageSize, totalCount);

	    List<DonationDetailDTO> pageList = fullList.subList(startIndex, endIndex);

	    model.addAttribute("detailList", pageList);
	    model.addAttribute("currentPage", page);
	    model.addAttribute("totalPage", totalPage);

	    return "member/mypage/mydonation_detail";
	}
	
}