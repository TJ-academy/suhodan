<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function donationCon_write() {
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
		document.form1.action = "/donation/insert.do";
		document.form1.submit();
	}
</script>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<h2>기부컨텐츠 등록</h2>
<form name="form1" method="post" enctype="multipart/form-data">
<table>
	<tr>
		<td>제목</td>
		<td><input name="title"></td>
	</tr>
	<tr>
		<td>내용</td>
		<td><textarea rows="5" cols="60" name="content"></textarea></td>
	</tr>
	<tr>
		<td>목표금액</td>
		<td><input name="target_amount"></td>
	</tr>
	<tr>
		<td>시작일</td>
		<td><input type="date" name="start_date">
	</tr>
	<tr>
		<td>종료일</td>
		<td><input type="date" name="end_date">
	</tr>
	<tr>
		<td>기부지역</td>
		<td><input name="location"></td>
	</tr>
	<tr>
		<td>기부썸네일</td>
		<td><input type="file" name="file1"></td>
	</tr>
</table>
</form>
<input type="button" value="등록" onclick="donationCon_write()">
<input type="button" value="목록" onclick="location.href='/donation/list.do'">
</body>
</html>