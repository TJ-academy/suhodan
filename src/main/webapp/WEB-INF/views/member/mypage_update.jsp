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

<form action="/mypage/update.do">
<table border="1" width="500px">
	<tr>
		<td>아이디</td>
		<td><input name="user_id" value="${dto.user_id}" readonly></td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td><input type="password" name="passwd"></td>
	</tr>
	<tr>
		<td>이름</td>
		<td><input name="name" value="${dto.name}"></td>
	</tr>
	<tr>
		<td>성별</td>
		<td>
			<input type="radio" name="gender" value="m" id="gender-m"
				<c:if test="${dto.gender == 'm'}">checked</c:if>
			/>
			<label for="gender-m">남자</label>
			<input type="radio" name="gender" value="w" id="gender-w" 
				<c:if test="${dto.gender == 'w'}">checked</c:if>
			/>
			<label for="gender-w">여자</label>
		</td>
	</tr>
	<tr>
		<td>생년월일</td>
		<td><fmt:formatDate value="${dto.birth}" pattern="yyyy-MM-dd" /></td>
	</tr>
	<tr>
		<td>주소</td>
		<td><input name="address" value="${dto.address}"></td>
	</tr>
	<tr>
		<td>가입 날짜</td>
		<td><fmt:formatDate value="${dto.join_date}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
	</tr>
</table>
<button type="submit">저장하기</button>
</form>
</body>
</html>