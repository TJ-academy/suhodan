<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="/css/menu.css">
<div class="nav">
    <ul>
        <li class="logo">
            <a href="/">
                <img src="../../resources/images/설화수 로고.png" alt="설화수 로고" />
            </a>
        </li>
        <li class="menu-item"><a href="/map" class="${currentCategory != null && currentCategory.equals('map') ? 'active' : ''}">설화 지도</a></li>
        <li class="menu-item"><a href="/shop/list.do" class="${currentCategory != null && currentCategory.equals('shop') ? 'active' : ''}">보따리 상점</a></li>
        <li class="menu-item"><a href="/donation/list.do" class="${currentCategory != null && currentCategory.equals('donation') ? 'active' : ''}">기부하기</a></li>
        <li class="menu-item"><a href="/mypage" class="${currentCategory != null && currentCategory.equals('mypage') ? 'active' : ''}">마이페이지</a></li>
        <li class="user-menu">
            <c:choose>
                <c:when test="${sessionScope.user_id == null}">
                    <a href="/login.do">로그인</a>
                </c:when>
                <c:otherwise>
                    <c:if test="${fn:contains(pageContext.request.requestURI, '/shop')}">
                        <a href="/shop/cart/list.do">장바구니</a>
                    </c:if>
                    <a href="/mypage">${sessionScope.name}님</a>
                    <a href="/logout.do">로그아웃</a>
                </c:otherwise>
            </c:choose>
        </li>
    </ul>
</div>