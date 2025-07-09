<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	body {
	  background-color: #F7EAD9;
	  margin: 0;
	  font-family: 'Noto Sans KR', sans-serif;
	  color: #6B4F3B;
	
	  display: flex;
	  flex-direction: column;
	  align-items: center; /* 가로 가운데 정렬 */
	}
	.welcome {
		color: #9C6B4F;
		font-weight: bold;
		font-size: 32px;
	}
	.text2 {
		font-size: 19px;
		color: #2E2E2E;
		text-align: center;
	}
	.login_btn {
		width: 146px;
		height: 57px;
		background: #9C6B4F;
		color: white;
		border-radius: 20px;
		border: none;
	}
	.login_btn:hover {
		background: #733512;
	}
</style>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<div style="margin-bottom: 134px;"></div>
<img src="../../resources/images/suho.PNG"><br>
<p class="welcome">환영합니다!</p>
<p class="text2">
마을의 새로운 수호자님.<br>
사라지는 설화를 지키는 여정에 함께 해주셔서 감사합니다.
</p><br><br>
<a href="login.do">
	<button type="button" class="login_btn">로그인</button>
</a>
</body>
</html>