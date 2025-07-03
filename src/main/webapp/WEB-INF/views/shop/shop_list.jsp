<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>보따리 상점</title>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<h2>보따리 상점</h2>
모든 수익금은 해당 마을을 지키는 데 사용됩니다.
<table border="1" width="500px">
	<tr>
		<th>상품ID</th>
		<th> </th>
		<th>상품명</th>
		<th>가격</th>
	</tr>
	<c:forEach var="row" items="${list}">
	<tr>
		<td>${row.reward_id}</td>
		<td align="center"><img src="/resources/images/${row.img}" width="100px" height="auto"></td>
		<td><a href="/shop/detail/${row.reward_id}">${row.name}</a></td>
		<td><fmt:formatNumber value="${row.price}" pattern="#,###" /></td>
	</tr>
	</c:forEach>
</table>
</body>
</html>