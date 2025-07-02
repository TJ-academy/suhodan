<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>회원가입</h2>
<form method="post" action="/join_next.do">
	<label>아이디를 입력하세요.</label><br>
	<input type="text" name="user_id">
	<button type="button">중복체크</button><br>
	
	<label>비밀번호를 입력하세요.</label><br>
	<input type="password" name="passwd"><br>
	
	<label>비밀번호를 다시 입력하세요.</label><br>
	<input type="password"><br>
	<p>아이디와 비밀번호는 영문/숫자로 이루어져야 합니다.</p>
	<button type="submit">다음으로</button>
</form>
</body>
</html>