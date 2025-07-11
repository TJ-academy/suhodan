<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="../../include/menu.jsp" %>

<style>
	.container {
		position: relative;
		width: 893px;
		height: 553px;
		margin: 47px auto 47px auto;
	}
	
	.rectangle {
		width: 893px;
		height: 553px;
		background-color: #F5F1EB;
		border: 1.67px solid #D8C2A6;
		border-radius: 16.65px;
		position: relative;
	}
	
	.back-button {
		position: absolute;
		width: 14px; height: 28px;
		border: none;
		cursor: pointer;
		top: 70px; left: 50px;
		background: url('/resources/images/back.png') no-repeat center;
		background-size: contain;
		z-index: 10;
	}
	
	.badgepage-title {
		position: absolute;
		top:70px; left: 50px;
		display: flex;
		align-items: center;
	}
	
	.badgepage-title-img {
		margin-left: 50px;
		width: 25px; height: 25px;
	}
	
	.badgepage-title-text {
		margin-left: 10px;
		font-size: 21px;
		font-weight: bold;
		color: #504848;
	}
	
	.badgepagedetail-center {
		width: 100%;
		justify-content: center;
	}
	
	.badgepagedetail-main {
		width: 768px; height: 294px;
		border: 1.67px solid #9C6B4F;
		border-radius: 16.65px;
		background-color: #F5F1EB;
		
		display: flex;
		justify-content: space-between;
		align-items: flex-start;
		gap: 20px;
		padding: 30px;
		
		position: absolute;
		left: 50%; top: 160px;
		transform: translateX(-50%);
	}
	
	/* .badgepagedetail-left {
		text-align: center;
		width: 150px;
	} */
	
	.badgepagedetail-left img {
		width: 152px;
		height: 196px;
	}
	
	.badgepagedetail-left p {
		font-size: 19px;
		font-weight: bold;
		color: #2E2E2E;
		position: relative;
		top: -10px;
		text-align: center;
	}

	.badgepagedetail-right {
		flex-grow: 1;
		display: flex;
		flex-direction: column;
		justify-content: flex-start;
		gap: 14px;
	}
	
	.badge-title {
		width: 240px; height: 57px;
		background-color: #9C6B4F;
		border: 1px solid #9C6B4F;
		border-radius: 25px;
		text-align: center;
		color: #FFFFFF;
		font-size: 21px;
		font-weight: bold;
		padding: 12px 16px;
	}
	
	.badge-desc {
		font-size: 19px;
		color: #2E2E2E;
	}
	
	.badge-date {
		font-size: 19px;
		color: #504848;
		margin-top: 6px;
	}
	
/* 	.back-button {
		position: absolute;
		width: 146.78px; height: 57.46px;
		background-color: #D8C2A6;
		border: 1px solid #9C6B4F;
		border-radius: 16.65px;
		cursor: pointer;
		left: 50%;
		transform: translateX(-50%);
		bottom: 50px;
		color: #744225;
		font-size: 20px;
		z-index: 10;
	}
	
	.back-button:hover {
		background-color: #9C6B4F;
		border: 1px solid #9C6B4F;
		color: #FFFFFF;
	} */
</style>

<div class="container">
	<div class="rectangle">
		<!-- 뒤로가기 버튼 -->
		<button class="back-button" onclick="location.href='/mypage/mybadges'"></button>
		
		<div class="badgepage-title">
			<img class="badgepage-title-img" src="/resources/suhodan_images/icon/badge.png">
			<span class="badgepage-title-text">명패함</span>
		</div>
		
		<div class="badgepagedetail-center">
			<div class="badgepagedetail-main">
				<div class="badgepagedetail-left">
					<img src="../../resources/badge_img/${dto.badge_img}" alt="${dto.badge_name}" />
					<p>${dto.badge_name}</p>
				</div>
				<div class="badgepagedetail-right">
					<div class="badge-title">${dto.badge_name} 도깨비 설화 명패</div>
					<div class="badge-desc">
						기부 참여 리워드로 획득<br>
						<b>${dto.badge_desc}</b>
					</div>
					<div class="badge-date">
						<fmt:formatDate value="${dto.get_date}" pattern="yyyy/MM/dd" /> 획득
					</div>
				</div>
			</div>
			
			
			<!-- <button class="back-button" onclick="location.href='/mypage/mybadges'">뒤로 가기</button> -->
		</div>
	</div>
</div>
</body>
</html>