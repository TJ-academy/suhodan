package com.example.suhodan.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.example.suhodan.member.MemberDAO;

@Controller
@RequestMapping("/admin/*")
public class AdminController {
	@Autowired
	MemberDAO memberDao;
	
	@GetMapping("member_list.do")
	public ModelAndView member_list(ModelAndView mav) {
		mav.setViewName("/admin/member_list");
		mav.addObject("list", memberDao.list());
		return mav;
	}
}
