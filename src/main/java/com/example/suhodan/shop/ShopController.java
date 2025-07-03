package com.example.suhodan.shop;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/shop/*")
public class ShopController {
	@Autowired
	ShopDAO shopDao;
	
	@GetMapping("list.do")
	public ModelAndView list(ModelAndView mav) {
		mav.setViewName("/shop/shop_list");
		mav.addObject("list", shopDao.list());
		return mav;
	}
	
	@GetMapping("detail/{reward_id}")
	public ModelAndView detail(@PathVariable("reward_id") int reward_id, 
			ModelAndView mav) {
		mav.setViewName("/shop/shop_detail");
		mav.addObject("dto", shopDao.detail(reward_id));
		return mav;

	}
}