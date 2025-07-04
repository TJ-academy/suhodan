package com.example.suhodan.shop.cart;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/shop/cart/*")
public class CartController {
	@Autowired
	CartDAO cartDao;
	
	@GetMapping("list.do")
	public ModelAndView list(HttpSession session, ModelAndView mav) {
		Map<String, Object> map = new HashMap<> ();
		String user_id = (String) session.getAttribute("user_id");
		
		if(user_id == null) {
			mav.setViewName("redirect:/login.do");
			return mav;
		}
		
		List<CartDTO> list = cartDao.list(user_id);
		int sumMoney = cartDao.sum_money(user_id);
		int fee = sumMoney >= 30000 ? 0 : 3000;
		map.put("sumMoney", sumMoney);
		map.put("fee", fee);
		map.put("sum", sumMoney + fee);
		map.put("list", list);
		map.put("count", list.size());
		mav.setViewName("shop/cart_list");
		mav.addObject("map", map);
		return mav;
	}
	
	@GetMapping("delete.do")
	public String delete(@RequestParam(name = "cart_id") int cart_id) {
		cartDao.delete(cart_id);
		return "redirect:/shop/cart/list.do";
	}
	
	@GetMapping("deleteAll.do")
	public String deleteAll(HttpSession session) {
		String user_id = (String) session.getAttribute("user_id");
		if(user_id != null) {
			cartDao.delete_all(user_id);
		}
		return "redirect:/shop/cart/list.do";
	}
	
	@PostMapping("update.do")
	public String update(CartDTO dto) {
		cartDao.modify(dto);
		return "redirect:/shop/cart/list.do";
	}

	@RequestMapping("insert.do")
	public String insert(CartDTO dto, HttpSession session) {
		String user_id = (String) session.getAttribute("user_id");
		if(user_id == null) {
			return "redirect:/login.do";
		}
		dto.setUser_id(user_id);
		CartDTO existing = cartDao.exists(user_id, dto.getReward_id());

        if (existing != null) {
            // 이미 같은 reward_id가 존재하면 amount 증가
            existing.setAmount(dto.getAmount());  // 추가할 수량
            cartDao.addAmount(existing);
        } else {
            // 새 항목으로 insert
            cartDao.insert(dto);
        }
		return "redirect:/shop/list.do";
	}
	
	@PostMapping("buy.do")
	public String buy(@RequestParam(name = "cart_id") int[] cart_id,
			HttpSession session) {
		String user_id = (String) session.getAttribute("user_id");
		if(user_id == null) {
			return "redirect:/login.do";
		}
		
		return "redirect:/shop/cart/list.do";
	}
}