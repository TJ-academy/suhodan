package com.example.suhodan.orders;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.example.suhodan.goods.GoodsDAO;
import com.example.suhodan.shop.cart.CartDAO;
import com.example.suhodan.shop.cart.CartDTO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/orders/*")
public class OrderController {
	@Autowired
	OrderDAO orderDao;
	@Autowired
	OrderItemDAO orderItemDao;
	@Autowired
	CartDAO cartDao;
	@Autowired
	GoodsDAO goodsDao;
	
	@GetMapping("list.do")
	public ModelAndView list(HttpSession session, ModelAndView mav) {
		return null;
	}
	
	@Transactional
	@PostMapping("order.do")
	public String order(OrderDTO dto, HttpSession session) throws UnsupportedEncodingException {
	    String user_id = (String) session.getAttribute("user_id");
	    if(user_id == null) {
	        return "redirect:/login.do?message=nologin";
	    }
	    dto.setUser_id(user_id);
	    
	    if ("무통장입금".equals(dto.getPay_method())) {
	        dto.setOrder_status("결제진행중");
	    } else {
	        dto.setOrder_status("결제완료");
	    }

	    //주문 테이블에 저장
	    orderDao.order(dto); //order_id 생성
	    //장바구니 상품 불러오기
	    List<CartDTO> cartItems = cartDao.list(user_id);
	    //장바구니 상품을 주문 상세로 변환
	    List<OrderItemDTO> orderItems = new ArrayList<>();
	    System.out.println("생성된 order_id: " + dto.getOrder_id());
	    for(CartDTO cart : cartItems) {
	    	OrderItemDTO item = new OrderItemDTO();
	    	item.setOrderId(dto.getOrder_id());
	    	item.setProductId(cart.getGoods_id());
	    	item.setProductName(cart.getGoods_name());
	    	item.setQuantity(cart.getAmount());
	    	item.setUnitPrice(goodsDao.getPrice(cart.getGoods_id()));
	    	orderItems.add(item);
	    }
	    
	    System.out.println(orderItems);
	    orderItemDao.insertItems(orderItems);

	    String encodedAddress1 = (dto.getOrder_address1() != null) ? URLEncoder.encode(dto.getOrder_address1(), "UTF-8") : "";
	    String encodedAddress2 = (dto.getOrder_address2() != null) ? URLEncoder.encode(dto.getOrder_address2(), "UTF-8") : "";
	    String encodedPhone = (dto.getPhone() != null) ? URLEncoder.encode(dto.getPhone(), "UTF-8") : "";
	    String encodedPayMethod = (dto.getPay_method() != null) ? URLEncoder.encode(dto.getPay_method(), "UTF-8") : "";

	    // Return redirect with encoded URL parameters
	    return "redirect:/shop/cart/complete.do?order_address1=" + encodedAddress1
	           + "&order_address2=" + encodedAddress2 
	           + "&phone=" + encodedPhone
	           + "&pay_method=" + encodedPayMethod;
	}
	
}
