package com.example.suhodan.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MypageController {
	@Autowired 
	MemberDAO memberDao;
	
	//나의 수호수
	@GetMapping("/mypage/mytree")
	public String mytree() {
		return "member/mypage/mytree";
	}
}