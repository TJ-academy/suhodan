package com.example.suhodan.shop;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/shop/*")
public class ShopController {
	@Autowired
	ShopDAO shopDao;
	
	@GetMapping("list.do")
	public ModelAndView list(ModelAndView mav, 
			@RequestParam(name="page", defaultValue = "1") int page, 
			@RequestParam(name = "category", required = false) String category,
			@RequestParam(name = "keyword", required = false) String keyword,
			@RequestParam(name = "sort", defaultValue = "new") String sort) {
		int perPage = 8;
	    int start = (page - 1) * perPage + 1;
	    int end = page * perPage;
	    
	    List<ShopDTO> list = shopDao.list(start, end, category, keyword, sort);
	    int totalCount = shopDao.getShopCount(category, keyword);
	    int totalPage = (int) Math.ceil((double) totalCount / perPage);
	    
		mav.setViewName("/shop/shop_list");
		mav.addObject("list", list);
		mav.addObject("currentPage", page);
	    mav.addObject("totalPage", totalPage);
	    mav.addObject("totalCount", totalCount);
	    mav.addObject("category", category);
		mav.addObject("keyword", keyword);
		mav.addObject("sort", sort);
		return mav;
	}
	
	@GetMapping("detail/{goods_id}")
	public ModelAndView detail(@PathVariable("goods_id") int goods_id, 
			ModelAndView mav) {
		mav.setViewName("/shop/shop_detail");
		mav.addObject("dto", shopDao.detail(goods_id));
		return mav;

	}
}