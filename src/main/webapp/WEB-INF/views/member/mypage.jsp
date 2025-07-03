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
<%@ include file="../include/menu.jsp" %>
<h2>마이페이지</h2>

<a href="#">디지털 수호수</a>
<a href="/mypage/edit">회원정보 수정</a>

<table border="1" width="500px">
	<tr>
		<td>아이디</td>
		<td>${dto.user_id}</td>
	</tr>
	<tr>
		<td>이름</td>
		<td>${dto.name}</td>
	</tr>
	<tr>
		<td>성별</td>
		<td>
			<c:if test="${dto.gender == 'm'}">남자</c:if>
			<c:if test="${dto.gender == 'w'}">여자</c:if>
		</td>
	</tr>
	<tr>
		<td>생년월일</td>
		<td><fmt:formatDate value="${dto.birth}" pattern="yyyy-MM-dd" /></td>
	</tr>
	<tr>
		<td>주소</td>
		<td>${dto.address}</td>
	</tr>
	<tr>
		<td>가입 날짜</td>
		<td><fmt:formatDate value="${dto.join_date}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
	</tr>
</table>
</body>
</html>