<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<style>
    body {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: #fdf4ec;
        margin: 0;
        padding: 0;
    }

    h2 {
        text-align: center;
        margin-top: 40px;
        color: #3f2e1d;
    }

    .mypage-container {
        max-width: 500px;
        margin: 30px auto;
        background-color: #f9f7f2;
        padding: 30px 40px;
        border-radius: 16px;
        box-shadow: 0 0 8px rgba(0, 0, 0, 0.06);
        text-align: center;
    }

    .mypage-container h3 {
        font-size: 18px;
        color: #3f2e1d;
        margin-bottom: 25px;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .mypage-container h3::before {
        content: url('/resources/suhodan_images/icon/user.png');
        width: 20px;
        height: 20px;
        margin-right: 8px;
    }

    .menu-box {
        background-color: #ffffff;
        border: 1px solid #e5d2bd;
        border-radius: 12px;
        padding: 20px;
    }

    .menu-box ul {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .menu-box li {
        border-bottom: 1px solid #ddd0bb;
        padding: 12px 0;
        display: flex;
        align-items: center;
    }

    .menu-box li:last-child {
        border-bottom: none;
    }

    .menu-box img {
        width: 20px;
        margin-right: 10px;
    }

    .menu-box a {
        text-decoration: none;
        color: #3f2e1d;
        font-weight: 500;
        flex: 1;
        text-align: left;
    }

    .logout {
        margin-top: 20px;
        text-align: center;
        color: #5c4531;
    }

    .logout a {
        color: #5c4531;
        text-decoration: none;
        font-weight: bold;
    }

    .logout a:hover {
        text-decoration: underline;
    }
</style>
</head>
<body>
<%@ include file="../../include/menu.jsp" %>

<div class="mypage-container">
    <h3>${sessionScope.name} 님</h3>

    <div class="menu-box">
        <ul>
            <li><img src="/resources/suhodan_images/icon/edit.png"><a href="/mypage/edit">개인 정보 수정</a></li>
            <li><img src="/resources/suhodan_images/icon/tree.png"><a href="/mypage/mytree">나의 수호수</a></li>
            <li><img src="/resources/suhodan_images/icon/reward.png"><a href="#">리워드함</a></li>
            <li><img src="/resources/suhodan_images/icon/clipboard.png"><a href="#">구매 내역</a></li>
            <li><img src="/resources/suhodan_images/icon/delivery.png"><a href="#">배송 조회</a></li>
            <li><img src="/resources/suhodan_images/icon/badge.png"><a href="/mypage/mybadges">명패함</a></li>
            <li><img src="/resources/suhodan_images/icon/donation.png"><a href="/mypage/mydonation">기부 내역</a></li>
        </ul>
    </div>

    <div class="logout">
        <a href="/logout.do">로그아웃</a>
    </div>
</div>
</body>
