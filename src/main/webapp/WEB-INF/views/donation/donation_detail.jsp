<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.detail_container {
		width: 841px;
		margin: 0 auto;
		height: auto;
		background: #F5F1EB;
		border-radius: 20px;
		margin-top: 10px;
		margin-bottom: 50px;
		padding: 20px;
		border: 1px solid #D8C2A6;
		
	}
	
	.back-button {
		position: absolute;
		width: 14px; height: 28px;
		border: none;
		cursor: pointer;
		/* top: 40px; left: 40px; */
		margin-top: 1px;
		background: url('/resources/suhodan_images/icon/arrow_right.png') no-repeat center;
		background-size: contain;
		z-index: 10;
		transform: rotate(180deg);
	}
	
	.title_style {
		color: #2E2E2E;
		font-size: 20px;
		font-weight: 700;
		text-align: center;
	}
	.hiredate_style {
		color: #929292;
		font-size: 13px;
		text-align: center;
	}
	.img_style {
		width: 100%;
		overflow: hidden;
		border-radius: 20px;
	}
	.content_style {
		color: #2E2E2E;
		font-size: 17px;
		text-align: center;
		margin: 15px 0;
	}
	.donation_btn {
	border: none;
		width: 474px;
		height: 68px;
		border-radius: 20px;
		background: #D8C2A6;
		color: white;
		font-size: 24px;
		text-align: center;
		font-weight: 700;
		line-height: 65px;
		display: block;
		margin: 0 auto 50px auto;
	}
	.donation_btn:hover {
		background: #9C6B4F;
	}
</style>
</head>
<body>
<%@include file="../include/menu.jsp" %>
<div class="detail_container">
	
	<!-- 뒤로가기 버튼 -->
	<button class="back-button" onclick="history.back()"></button>
	
	<p class="title_style">${dto.title}</p>
	<p class="hiredate_style">
	    <span>
		    <fmt:formatDate value="${dto.start_date}" pattern="yyyy-MM-dd" />~
		    <fmt:formatDate value="${dto.end_date}" pattern="yyyy-MM-dd" />까지
	    </span>
	</p>
	<div class="img_style">
		<img src="../../resources/donation_img/${dto.filename}">
	</div>
	<p class="content_style">
	  <c:out value="${fn:replace(dto.content, '.', '.<br>')}" escapeXml="false" />
	</p>
	<!--  프로그레스바 영역 -->
	<div style="margin: 20px 0; text-align:center;">
		<span style="float:left; font-size: 15px;">
			<fmt:formatNumber value="${dto.donated_amount}" />&nbsp;원
		</span>
		<c:set var="progressPercent" value="${dto.target_amount > 0 ? (dto.donated_amount * 100) / dto.target_amount : 0}" />
		<div style="background:#7A9D54; border-radius: 8px; height: 20px; width: 100%; overflow: hidden;">
			<div style="background:#4C6B3C; height: 100%; width: ${progressPercent}%;"></div>
		</div>
		<span style="display: block; text-align: right; color: #535353; font-size: 13px;">
			<fmt:formatNumber value="${dto.target_amount}" />&nbsp;원
		</span>
	</div>
	<c:choose>
	    <c:when test="${empty sessionScope.user_id}">
	        <button class="donation_btn" onclick="alert('로그인이 필요합니다.'); location.href='/login.do?message=nologin'">후원하기</button>
	    </c:when>
	    <c:otherwise>
	        <button class="donation_btn" onclick="location.href='/donation/info/${dto.content_id}'">후원하기</button>
	    </c:otherwise>
	</c:choose>
	
</div>
</body>
</html>
