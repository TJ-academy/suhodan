package com.example.suhodan.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AdminInterceptor implements HandlerInterceptor {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		String userId = (String) request.getSession().getAttribute("user_id");

		// admin인 경우 /admin/ 경로로 리다이렉트
		if ("admin".equals(userId) && !request.getRequestURI().startsWith("/admin")) {
			response.sendRedirect("/admin/"); // /admin으로 리다이렉트
			return false; // 더 이상 컨트롤러로 진행되지 않음
		}

		// admin이 아니면 /admin/** 경로에 접근할 수 없도록 설정
		if (!"admin".equals(userId) && request.getRequestURI().startsWith("/admin")) {
			response.sendRedirect("/"); // 예시로 에러 페이지로 리다이렉트
			return false; // 더 이상 컨트롤러로 진행되지 않음
		}

		return true; // 나머지 요청은 정상적으로 처리
	}
}