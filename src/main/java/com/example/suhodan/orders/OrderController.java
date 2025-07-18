package com.example.suhodan.orders;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
	    System.out.println("주문 상태: " + dto.getOrder_status());  // 상태 로그 찍기

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

	    int order_id = dto.getOrder_id();
	    String encodedAddress1 = (dto.getOrder_address1() != null) ? URLEncoder.encode(dto.getOrder_address1(), "UTF-8") : "";
	    String encodedAddress2 = (dto.getOrder_address2() != null) ? URLEncoder.encode(dto.getOrder_address2(), "UTF-8") : "";
	    String encodedPhone = (dto.getPhone() != null) ? URLEncoder.encode(dto.getPhone(), "UTF-8") : "";
	    String encodedPayMethod = (dto.getPay_method() != null) ? URLEncoder.encode(dto.getPay_method(), "UTF-8") : "";

	    // Return redirect with encoded URL parameters
	    return "redirect:/shop/cart/complete.do?order_address1=" + encodedAddress1
	           + "&order_address2=" + encodedAddress2 
	           + "&phone=" + encodedPhone
	           + "&pay_method=" + encodedPayMethod
	           + "&order_id=" + order_id;
	}
	
	@GetMapping("list.do")
	public ModelAndView list(HttpSession session, ModelAndView mav) {
		String user_id = (String) session.getAttribute("user_id");
		
	    if (user_id == null) {
	        // 로그인 안된 경우 로그인 페이지로 리다이렉트
	        return new ModelAndView("redirect:/login.do?message=nologin");
	    }
		
		//사용자 주문목록 불러오기
		List<Map<String, Object>> orders = orderDao.getUserOrders(user_id);
		System.out.println("orders: " + orders);
		mav.addObject("orders", orders);
		mav.setViewName("/member/mypage/myorders");
		
		return mav;
	}
	
	@GetMapping("cancel.do")
	public String cancel(@RequestParam(name = "order_id") int order_id) {
		orderDao.delete(order_id);
		String message = "success_cancel";
		
		return "redirect:/orders/list.do?message=" + message;
	}
	
	//환불요청
	@GetMapping("refund.do")
	public ModelAndView requestRefund(@RequestParam(name = "order_id") int order_id,
			ModelAndView mav) {
		orderDao.request_refund(order_id);
		String message = "success_refundRequest";
		mav.addObject("message", message);
		mav.addObject("dto", orderDao.refund_detail(order_id));
		mav.setViewName("/shop/cancel_complete");
		return mav;
	}
	
	//배송디테일 페이지
	@GetMapping("delivery_detail.do")
	public ModelAndView deldetail(int order_id, ModelAndView mav) {
		//배송디테일
		List<Map<String, Object>> deldetails = orderDao.detailDelivery(order_id);
		mav.addObject("deldetails", deldetails);
		mav.setViewName("/member/mypage/deldetail");
		
		return mav;
	}
	
	//배송조회 페이지(폐기? 필요없어짐. 해당 xml, dao, daoimpl도 삭제할것)
	/*
	@GetMapping("delivery_list.do")
	public ModelAndView delist(HttpSession session, ModelAndView mav) {
		String user_id = (String) session.getAttribute("user_id");
		
	    if (user_id == null) {
	        // 로그인 안된 경우 로그인 페이지로 리다이렉트
	        return new ModelAndView("redirect:/login.do?message=nologin");
	    }
		
		//사용자 배송현황 목록 불러오기
		List<Map<String, Object>> dels = orderDao.selectDeliveryStatus(user_id);
		mav.addObject("delis", dels);
		mav.setViewName("/member/mypage/mydelis");
		
		return mav;
	}
	*/

	
}
