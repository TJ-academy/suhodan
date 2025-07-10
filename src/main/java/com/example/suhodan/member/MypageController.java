package com.example.suhodan.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.example.suhodan.member.MemberDAO;
import com.example.suhodan.member.MemberDTO;

import jakarta.servlet.http.HttpSession;

@Controller
public class MypageController {

    @Autowired 
    MemberDAO memberDao;

    // 나의 수호수
    @GetMapping("/mypage/mytree")
    public String mytree() {
        return "member/mypage/mytree";
    }

}
