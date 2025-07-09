<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function donationCon_delete() {
		if(confirm("삭제하시겠습니까?")) {
			document.form1.action = "/donation/delete.do";
			document.form1.submit();
		}
	}
	
	function donationCon_update() {
		const title = document.form1.title.value;
		const content = document.form1.content.value;
		const target_amount = document.form1.target_amount.value;
		const location = document.form1.location.value;
		if(title == "") {
			alert("제목을 입력하세요.");
			document.form1.title.focus();
			return;
		}
		if(content == "") {
			alert("내용을 입력하세요.");
			document.form1.content.focus();
			return;
		}
		if(target_amount == "") {
			alert("목표금액을 입력하세요.");
			document.form1.target_amount.focus();
			return;
		}
		if(location == "") {
			alert("기부지역을 입력하세요.");
			document.form1.location.focus();
			return;
		}
		document.form1.action = "/donation/update.do";
		document.form1.submit();
	}
</script>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<form name="form1" method="post" enctype="multipart/form-data">
<table>
	<tr>
		<td>제목</td>
		<td><input name="title" value="${dto.title}"></td>
	</tr>
	<tr>
		<td>내용</td>
		<td><textarea rows="5" cols="60" name="content">${dto.content}</textarea></td>
	</tr>
	<tr>
		<td>목표금액</td>
		<td><input name="target_amount" value="${dto.target_amount}"></td>
	</tr>
	<tr>
		<td>시작일</td>
		<td>
			<input type="date" name="start_date" value="<fmt:formatDate value='${dto.start_date}' pattern='yyyy-MM-dd'/>">
		</td>
	</tr>
	<tr>
		<td>종료일</td>
		<td>
			<input type="date" name="end_date" value="<fmt:formatDate value='${dto.end_date}' pattern='yyyy-MM-dd'/>">
		</td>
	</tr>
	<tr>
		<td>기부지역</td>
		<td><input name="location" value="${dto.location}"></td>
	</tr>
	<tr>
		<td>기부썸네일</td>
		<td>
			<img src="../../resources/donation_img/${dto.filename}"
			width="300px" height="300px"><br>
			<input type="file" name="file1">
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="hidden" name="content_id" value="${content_id}">
			<input type="button" value="수정" onclick="donationCon_update()">
			<input type="button" value="삭제" onclick="donationCon_delete()">
			<input type="button" value="목록" onclick="location.href='/donation/list.do'">		
		</td>
	</tr>
</table>
</form>
</body>
</html>