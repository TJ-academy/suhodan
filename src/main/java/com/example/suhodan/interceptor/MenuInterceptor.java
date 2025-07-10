package com.example.suhodan.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class MenuInterceptor implements HandlerInterceptor {
    
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 현재 요청 URL 가져오기
        String currentUrl = request.getRequestURI();
        
        String currentCategory = "";
        
        if (currentUrl.contains("/admin/member_list.do")) {
            currentCategory = "admin_member";
        } else if (currentUrl.contains("/admin/legend_list.do")) {
            currentCategory = "admin_legend";
        } else if (currentUrl.contains("/admin/reward_list.do")) {
            currentCategory = "admin_reward";
        } else if (currentUrl.contains("/admin/goods_list.do")) {
            currentCategory = "admin_goods";
        } else if (currentUrl.contains("/admin/badge_list.do")) {
            currentCategory = "admin_badge";
        } else if (currentUrl.contains("/admin/donation_list.do")) {
            currentCategory = "admin_donation";
        } else if (currentUrl.contains("/map")) {
            currentCategory = "map";
        } else if (currentUrl.contains("/shop")) {
            currentCategory = "shop";
        } else if (currentUrl.contains("/donation")) {
            currentCategory = "donation";
        } else if (currentUrl.contains("/mypage")) {
            currentCategory = "mypage";
        }
        
        // currentPage를 request에 저장 (JSP에서 사용할 수 있게)
        request.setAttribute("currentCategory", currentCategory);
        
        return true;
    }
}
