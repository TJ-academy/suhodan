<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		padding: 20px;
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
		width: 474px;
		height: 68px;
		border-radius: 20px;
		background: #9C6B4F;
		color: white;
		font-size: 24px;
		text-align: center;
		font-weight: 700;
		line-height: 65px;
		display: block;
		margin: 0 auto;
	}
	.donation_btn:hover {
		background: #5E2200;
	}
</style>
</head>
<body>
<%@include file="../include/menu.jsp" %>
<div class="detail_container">
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
	<p style="text-align:center; color: red;">
		목표금액: ${dto.target_amount}
	</p>
	<button class="donation_btn">후원하기</button>
</div>
</body>
</html>