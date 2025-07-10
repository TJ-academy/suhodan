package com.example.suhodan.member.mypage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpSession;

@Controller
public class MypageController {
	@Autowired 
	MypageDAO mypageDAO;
	
	//나의 수호수
	@GetMapping("/mypage/mytree")
	public String mytree(HttpSession session, Model model) {
		String user_id = (String) session.getAttribute("user_id");
		
		List<MypageDTO> blist = mypageDAO.getUserBadge(user_id);
		model.addAttribute("blist", blist);
		return "member/mypage/mytree";
	}
}