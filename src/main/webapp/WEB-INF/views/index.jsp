<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/index.css">
</head>
<body>
<%@ include file="include/menu.jsp" %>
<%@ include file="include/carousel.jsp" %>
<div class="donation_con">
   <img src="/resources/images/donation.PNG" width="100%" height="100%">
   <button class="done_btn" onclick="location.href='/donation/list.do'">선물하기</button>
</div>
<div style="clear:both;"></div>
<%@ include file="include/footer.jsp" %>
</body>
</html>

