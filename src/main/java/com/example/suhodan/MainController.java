package com.example.suhodan;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {
	
	@GetMapping("/")
	public String home() {
		return "index";
	}
	
    @GetMapping("/mypage/phone/")
    public String phone() {
        return "test1234";
    }
}
