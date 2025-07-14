package com.example.suhodan.member.mypage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

import com.example.suhodan.donation.DonationHistoryDAO;
import com.example.suhodan.donation.DonationHistoryDTO;

import jakarta.servlet.http.HttpSession;

@Controller
public class MypageController {
	@Autowired 
	MypageDAO mypageDAO;
	@Autowired
	DonationHistoryDAO mydonationDAO;
	
	//나의 수호수
	@GetMapping("/mypage/mytree")
	public String mytree(HttpSession session, Model model) {
		String user_id = (String) session.getAttribute("user_id");
		
		List<MypageDTO> blist = mypageDAO.getUserBadge(user_id);
		model.addAttribute("blist", blist);
		return "member/mypage/mytree";
	}
	
	//명패함
	@GetMapping("/mypage/mybadges")
	public String mybadges(HttpSession session, Model model) {
		String user_id = (String) session.getAttribute("user_id");
		
		List<MypageDTO> blist = mypageDAO.getUserBadge(user_id);
		model.addAttribute("blist", blist);
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
	
	//기부내역
	@GetMapping("/mypage/mydonation")
	public String mydonation(HttpSession session, Model model) {
		String donor_id = (String) session.getAttribute("user_id");
		List<DonationHistoryDTO> dlist = mydonationDAO.list(donor_id);
		model.addAttribute("dlist", dlist);
		return "member/mypage/mydonation_history";
	}
}