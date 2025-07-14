<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기부내역</title>
<style>
	.dona_con {
	}
</style>
</head>
<body>
<%@ include file="../../include/menu.jsp" %>
<!-- 날짜, 제목, 내용, 기부금액 -->
<div class="dona_con">

</div>
<table>
	<tr>
		<th>제목</th>
		<th>내용</th>
		<th>기부금액</th>
		<th>기부일</th>
	</tr>
	<c:forEach var="d" items="${dlist}">
		<tr>
			<td>${d.title}</td>
			<td>${d.content}</td>
			<td><fmt:formatNumber value="${d.amount}" type="currency"/></td>
			<td><fmt:formatDate value="${d.donationDate}" pattern="yyyy-MM-dd"/></td>
		</tr>
	</c:forEach>
</table>
</body>
</html>