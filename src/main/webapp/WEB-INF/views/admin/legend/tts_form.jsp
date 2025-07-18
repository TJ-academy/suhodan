<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>음성 생성기</title>
<link rel="stylesheet" href="/css/admin.css">
<style>
body {
	background-color: #fdf4ec;
	font-family: 'Noto Sans KR', sans-serif;
	margin: 0;
	padding: 0;
}

.tts-container h2 {
	text-align: center;
	margin-top: 10px;
	color: #9C6B4F; /* ✅ 원하는 색상 적용 */
	fonFt-size: 32px;
	font-weight: bold;
	margin-bottom: 50px;
	
}

.tts-container {
	max-width: 500px;
	margin: 30px auto;
	background-color: #f5f1eb;
	padding: 40px 50px;
	border-radius: 15px;
	border: 1px solid #D8C2A6;
}

label {
	display: block;
	text-align: left;
	margin-bottom: 8px;
	color: #2E2E2E;
}

input[type="text"], textarea {
	width: 100%;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 10px;
	box-sizing: border-box;
	margin-bottom: 20px;
	font-size: 13px;
}

input[type="text"]::placeholder, textarea::placeholder {
	font-size: 13px;
	color: #999;
}

textarea {
	resize: vertical;
}

input[type="submit"] {
	background-color: #D8C2A6;
	color: white;
	border: none;
	padding: 12px 25px;
	font-size: 16px;
	border-radius: 10px;
	cursor: pointer;
	transition: background-color 0.2s ease;
	margin: 0 auto;
	display: block;
	margin-top: 30px;
}

input[type="submit"]:hover {
	background-color: #9C6B4F;
}
</style>
</head>
<body>
	<%@ include file="../../include/admin_menu.jsp"%>

	<div class="tts-container">
		<h2>음성 생성기</h2>
		<form action="/admin/legend/generate_speech.do" method="post">
			<label for="filename">파일명 :</label> <input
				type="text" name="filename" id="filename" placeholder="예: hello.mp3">

			<label for="text">텍스트 입력 :</label>
			<textarea name="text" id="text" rows="6"
				placeholder="여기에 텍스트를 입력하세요."></textarea>

			<input type="submit" value="생성">
		</form>
	</div>

</body>
</html>
