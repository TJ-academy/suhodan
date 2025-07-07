<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
	$(function(){
		$("#btnAdd").click(function(){
			location.href = "/donation/write.do";
		});
	});
</script>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<h2>기부</h2>
<table border="1" width="500px">
	<tr>
		<td>ID</td>
		<td> </td>
		<td>title</td>
		<td>content</td>
		<td>target_amount</td>
		<td>hiredate</td>
		<td>location</td>
		<td>created_at</td>
	</tr>
	<c:forEach var="row" items="${list}">
		<tr>
			<td>${row.content_id}</td>
			<td align="center">
				<img src="/resources/donation_img/${row.filename}"
				width="100px" height="100px">
			</td>
			<td>
				<a href="/donation/detail/${row.content_id}">${row.title}</a>
			</td>
			<td>
				${row.content}
			</td>
			<td>${row.target_amount}</td>
			<td>${row.start_date} - ${row.end_date}</td>
			<td>${row.location}</td>
			<td>${row.created_at}</td>
		</tr>
	</c:forEach>
</table>
</body>
</html>