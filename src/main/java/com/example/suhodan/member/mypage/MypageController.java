package com.example.suhodan.member.mypage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;

@Controller
public class MypageController {
	@Autowired 
	MypageDAO mypageDAO;
	
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
	
	@GetMapping("/mypage/mybadges/{userbadge_id}")
	public ModelAndView mbdetail(@PathVariable(name = "userbadge_id") int userbadge_id, 
			ModelAndView mav,
			HttpSession session) {
		String user_id = (String) session.getAttribute("user_id");
		mav.setViewName("/member/mypage/mybadges_detail");
		mav.addObject("dto", mypageDAO.badgeDetail(userbadge_id));
		return mav;
	}
	
	// 기부내역 페이징 처리
	@GetMapping("/mypage/mydonation")
	public String mydonation(
	        @RequestParam(value = "page", defaultValue = "1") int page,  // 페이지 번호 받기, 기본 1
	        HttpSession session, Model model) {

	    String donor_id = (String) session.getAttribute("user_id");
	    
	    int pageSize = 5;  // 한 페이지에 보여줄 카드 개수
	    int startIndex = (page - 1) * pageSize + 1;
	    int endIndex = page * pageSize;
	    
	    List<MypageDTO> list = mypageDAO.donationList(donor_id, startIndex, endIndex);
	    
	    int totalCount = 0;
	    
	    if(!list.isEmpty())
	    	totalCount = list.get(0).getDonation_count();
	    
	    int totalPage = (int) Math.ceil((double) totalCount / pageSize);

	    model.addAttribute("dlist", list);
	    model.addAttribute("currentPage", page);
	    model.addAttribute("totalPage", totalPage);

	    return "member/mypage/mydonation";
	}
	
	@GetMapping("/mypage/mydonation/{transaction_id}")
	public String donationDetail(
	        @PathVariable("transaction_id") int transaction_id,
	        HttpSession session, Model model) {

	    String donor_id = (String) session.getAttribute("user_id");
	    
	    model.addAttribute("dto", mypageDAO.donationDetail(transaction_id));

	    return "member/mypage/mydonation_detail";
	}
	
	@GetMapping("/mypage/myreward")
	public String myreward(HttpSession session, Model model, 
			@RequestParam(name="page", defaultValue = "1") int page) {
		String user_id = (String) session.getAttribute("user_id");
		
		// 페이징 설정
	    int maxreward = 5;   //한 페이지에 보여지는 최대 개수
	    int startRow = (page - 1) * maxreward + 1;
	    int endRow = page * maxreward;
	    
		List<MypageDTO> list = mypageDAO.rewardList(user_id, startRow, endRow);
		int reward_count = 0;
		int totalAmount = 0;
		
		if(!list.isEmpty()) {
			reward_count = list.get(0).getReward_count();
			
			for (MypageDTO row : list) {
		    	totalAmount += row.getAmount();
		    }
		}
		
		int totalPage = (int) Math.ceil((double) reward_count / maxreward);
		
		model.addAttribute("list", list);
		model.addAttribute("currentPage", page);
	    model.addAttribute("totalPage", totalPage);
	    model.addAttribute("totalAmount", totalAmount);
		return "member/mypage/myreward";
	}
	
	@GetMapping("/mypage/myreward/{transaction_id}")
	public ModelAndView mrdetail(@PathVariable(name = "transaction_id") int transaction_id, 
			ModelAndView mav,
			HttpSession session) {
		String user_id = (String) session.getAttribute("user_id");
		mav.setViewName("/member/mypage/myreward_detail");
		mav.addObject("dto", mypageDAO.rewardDetail(transaction_id));
		return mav;
	}
}