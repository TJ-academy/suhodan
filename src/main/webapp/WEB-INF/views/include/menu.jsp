<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
<div class="nav">
    <ul>
        <li class="logo">
            <a href="/">
                <img src="../../resources/images/설화수 로고.png" alt="설화수 로고" />
            </a>
        </li>
        <li class="menu-item"><a href="/">메인</a></li>
        <li class="menu-item"><a href="/map">설화 지도</a></li>
        <li class="menu-item"><a href="/shop/list.do">보따리 상점</a></li>
        <li class="menu-item"><a href="/donation/list.do">기부하기</a></li>
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

<style>
    body {
        background: #F7EAD9;
        width: 1280px;
        margin: 0 auto;
        font-family: 'Noto Sans KR', sans-serif;
    }

    .nav {
        background-color: #f5e9d9;
        width: 100%;
        height: 109px;
        display: flex;
        align-items: center;
        padding: 0 20px;
        box-sizing: border-box;
        border-bottom: 1px solid #ddd;
    }

    .nav ul {
        display: flex;
        width: 100%;
        padding: 0;
        margin: 0;
        list-style: none;
        align-items: center;
    }

    .nav ul li {
        display: flex;
        align-items: center;
        font-size: 18px;
        color: #2E2E2E;
        margin-right: 30px;
        white-space: nowrap;
    }

    .nav ul li:last-child {
        margin-left: auto;
        margin-right: 0;
    }

    .nav ul li a {
        text-decoration: none;
        color: #2E2E2E;
        padding: 8px 10px;
        transition: color 0.3s ease;
    }

    .nav ul li a:hover {
        color: black;
        font-weight: 600;
    }

    .nav ul li.logo {
        width: 297px;
        padding-right: 20px;
    }

    .nav ul li.logo a img {
        width: 200px;
        height: auto;
        display: block;
    }

    .nav ul li.menu-item {
        width: auto;
    }

    .nav ul li.user-menu a {
        margin-left: 15px;
        display: flex;
        align-items: center;
    }
</style>