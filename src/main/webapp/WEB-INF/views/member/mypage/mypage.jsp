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
        margin-top: 0px;
        color: #3f2e1d;
    }

    .mypage-container {
        width: 500px;
        margin: 47px auto;
        padding: 30px 40px;
        background-color: #F5F1EB;
		border: 1.67px solid #D8C2A6;
		border-radius: 16.65px;
        text-align: center;
    }

    .mypage-container span {
        font-size: 21px;
        color: #3f2e1d;
        margin-bottom: 25px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: bold;
    }

    .mypage-container span::before {
        content: url('/resources/suhodan_images/icon/user.png');
        width: 20px;
        height: 20px;
        margin-right: 8px;
    }

    .menu-box {
        background-color: #ffffff;
        border: 1.67px solid #D8C2A6;
		border-radius: 16.65px;
        padding: 20px;
        font-size: 16px;
    }

    .menu-box ul {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .menu-box li {
        border-bottom: 1px solid #BABABA;
        padding: 12px 10px;
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
        margin-top: 21px;
        text-align: center;
        color: #504848;
    }

    .logout a {
        color: #504848;
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
    <span>${sessionScope.name} 님</span>

    <div class="menu-box">
        <ul>
            <li>
            	<img src="/resources/suhodan_images/icon/edit.png">
            	<a href="/mypage/pwdcheck">개인 정보 수정</a>
            </li>
            <li>
	            <img src="/resources/suhodan_images/icon/tree.png">
	            <a href="/mypage/mytree">나의 수호수</a>
            </li>
            <li>
	            <img src="/resources/suhodan_images/icon/reward.png">
	            <a href="/mypage/myreward">리워드함</a>
            </li>
            <li>
	            <img src="/resources/suhodan_images/icon/clipboard.png">
	            <a href="#">구매 내역</a>
            </li>
            <li>
	            <img src="/resources/suhodan_images/icon/delivery.png">
	            <a href="#">배송 조회</a>
            </li>
            <li>
	            <img src="/resources/suhodan_images/icon/badge.png">
	            <a href="/mypage/mybadges">명패함</a>
            </li>
            <li>
	            <img src="/resources/suhodan_images/icon/donation.png">
	            <a href="/mypage/mydonation">기부 내역</a>
            </li>
        </ul>
    </div>

    <div class="logout">
        <a href="/logout.do">로그아웃</a>
    </div>
</div>
</body>
</html>