<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
</head>
<body>
<%@ include file="../../include/menu.jsp" %>
<h2>마이페이지</h2>
<div>
	${sessionScope.name} 님
</div>
<div>
	<ul>
		<li><a href="/mypage/edit">개인 정보 수정</a></li>
		<li><a href="#">나의 수호수</a></li>
		<li><a href="#">리워드함</a></li>
		<li><a href="#">구매 내역</a></li>
		<li><a href="#">배송 조회</a></li>
		<li><a href="#">명패함</a></li>
		<li><a href="#">기부 내역</a></li>
	</ul>
</div>
<div><a href="/logout.do">로그아웃</a></div>
</body>
</html>