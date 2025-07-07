<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.btnStyle {
		background: #D9C2AD;
		color: white;
		width: 146px;
		height: 57px;
		font-size: 20px;
		border-radius: 40px;
		border-color: white;
		font-weight: bold;
	}
	
	.btnStyle:hover {
		background: #11A13C;
	}
	
	.donation_con {
		width: 1280px;
		height: 160px;
		background: #F2D4B4;
		margin: 40px 0;
		padding: 10px;
		position: absolute;
	}
	
	.done_btn {
		position: relative;
		bottom: 110px;
		left: 1150px;
		background: #9C6B4F;
		color: white;
		width: 83px;
		height: 83px;
		font-size: 17px;
		border-radius: 50px;
		border: none;
		font-weight: bold;
		cursor: pointer;
	}
	
	.done_btn:hover {
		background: #80360C;
	}
</style>
</head>
<body>
<%@ include file="include/menu.jsp" %>
<%@ include file="include/carousel.jsp" %>
<div class="donation_con">
	<img src="/resources/images/donation.PNG" width="100%" height="100%">
	<button class="done_btn">선물하기</button>
</div>
</body>
</html>
