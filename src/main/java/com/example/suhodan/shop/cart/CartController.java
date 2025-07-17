package com.example.suhodan.shop.cart;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.suhodan.member.MemberDAO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/shop/cart/*")
public class CartController {

    @Autowired
    CartDAO cartDao;
    
    @Autowired
    MemberDAO memberDao;

    @GetMapping("list.do")
    public ModelAndView list(HttpSession session, ModelAndView mav) {
        Map<String, Object> map = new HashMap<>();
        String user_id = (String) session.getAttribute("user_id");

        if (user_id == null) {
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
        if (user_id != null) {
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
        if (user_id == null) {
            return "redirect:/login.do?message=nologin";
        }
        dto.setUser_id(user_id);
        CartDTO existing = cartDao.exists(user_id, dto.getGoods_id());

        if (existing != null) {
            existing.setAmount(dto.getAmount());
            cartDao.addAmount(existing);
        } else {
            cartDao.insert(dto);
        }

        return "redirect:/shop/list.do?message=success";
    }

    @PostMapping("buy.do")
    public ModelAndView buy(@RequestParam(name = "cart_id") int[] cartIds,
    		@RequestParam(name = "fee") int fee,
    		HttpSession session) {
        String user_id = (String) session.getAttribute("user_id");
        if (user_id == null) {
            return new ModelAndView("redirect:/login.do");
        }
        
        List<CartDTO> cartList = cartDao.list(user_id);
        int total = cartDao.sum_money(user_id);

        ModelAndView mav = new ModelAndView();
        mav.setViewName("shop/buy");
        mav.addObject("cartList", cartList);
        mav.addObject("total", total);
        mav.addObject("fee", fee);
        mav.addObject("dto", memberDao.detail(user_id));
        return mav;
    }
    
    @GetMapping("complete.do")
    public String completeOrder(
            @RequestParam("order_address1") String address1,
            @RequestParam("order_address2") String address2,
            @RequestParam("phone") String phone,
            @RequestParam("pay_method") String payMethod,
            @RequestParam("order_id") int order_id,
            @RequestParam(value = "refund_bank", required = false) String bankName,
            @RequestParam(value = "refund_account", required = false) String accountNumber,
            HttpSession session,
            Model model) {
    	String receiver = (String) session.getAttribute("name");
        String user_id = (String) session.getAttribute("user_id");
        int total = cartDao.sum_money(user_id);
        
        // 장바구니 비우기
        cartDao.delete_all(user_id);

        // 결제 마감일 계산
        LocalDateTime deadline = LocalDateTime.now().plusDays(7);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("M월 d일 H시 m분");

        // 기본 정보 모델에 추가
        model.addAttribute("receiver", receiver);
        model.addAttribute("address1", address1);
        model.addAttribute("address2", address2);
        model.addAttribute("phone", phone);
        model.addAttribute("total", total);
        model.addAttribute("order_id", order_id);
        model.addAttribute("deadline", deadline.format(formatter));

        // 결제 수단 처리
        if ("무통장입금".equals(payMethod)) {
            model.addAttribute("payMethod", "무통장입금");
            model.addAttribute("bankName", bankName);
            model.addAttribute("accountNumber", accountNumber);
        } else {
            model.addAttribute("payMethod", "카드 결제");
        }

        return "shop/complete";
    }
    
    
}
