<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${dto.title}</title>
<style>
body {
	background-color: #fdf4ec;
	font-family: 'Noto Sans KR', sans-serif;
	margin: 0;
	padding: 0;
}

.outer-box {
	max-width: 1000px;
	margin: 50px auto;
	background-color: #F5F1EB;
	border: 1px solid #D8C2A6;
	border-radius: 20px;
	padding: 50px;
	position: relative;
}

.back-button {
	position: absolute;
	top: 50px; left: 50px;
	display: flex;
	align-items: center;
	background-color: transparent;
	border: none;
	color: #3e2d17;
	font-size: 16px;
	cursor: pointer;
}

.back-button img {
	width: 15px;
	height: 25px;
	margin-top: 40px;
}

.title {
	font-size: 32px;
	font-weight: bold;
	color: #2E2E2E;
	text-align: center;
	margin-top: 40px;
}

.subtitle {
	font-size: 17px;
	color: #2E2E2E;
	margin-bottom: 50px;
}

.legend-img {
    position: relative;
    width: 100%;
    max-width: 900px;
    height: 500px;  /* 이미지 높이 설정 */
    margin: 90px auto 40px;
    text-align: center;
}

.image-container {
    position: relative;
    width: 100%;
    height: 100%;
}

.legend-img img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

audio {
    position: absolute;
    bottom: 20px; /* 아래에서 20px 떨어지게 설정 */
    right: 20px; /* 오른쪽에서 20px 떨어지게 설정 */
    padding: 10px;
    border-radius: 8px;
}


.divider-line {
	border: none;
	border-top: 2px solid #C4C4C4;
	width: 80%;
	margin: 40px auto 20px;
}

.story {
	font-size: 15px;
	color: #2F2F2F;
	line-height: 1.8;
	text-align: left;
	white-space: pre-line;
}

.btn-donate {
	margin-top: 40px;
	background-color: #D9C2AD;
	color: white;
	border: none;
	padding: 12px 150px;
	font-size: 19px;
	border-radius: 8px;
	cursor: pointer;
	transition: background-color 0.3s ease;
	text-decoration: none;
	display: block;
	width: 50%; /* Adjust the width for better centering */
	margin-left: auto;
	margin-right: auto;
	text-align: center;
}

.btn-donate:hover {
	background-color: #9C6B4F;
}
</style>
</head>
<body>

<%@ include file="../include/menu.jsp" %>

	<div class="outer-box">
	<button class="back-button" onclick="history.back();">
		<img src="/resources/images/back.png" alt="뒤로가기 아이콘">
	</button>
	<div class="title">${dto.title}</div>
	
	<div class="legend-img">
	
    <!-- 배경 이미지 -->
    <div class="image-container">
        <img src="/resources/legend_img/${dto.img}" alt="설화 이미지" onerror="this.onerror=null; this.src='/resources/images/설화수 로고.png';">
        <!-- MP3 아이콘 -->
        <audio controls>
            <source src="/resources/output_tts/샘플.mp3" type="audio/mp3">
            
        </audio>
    </div>
</div>
<hr class="divider-line">

	<!-- 설화 본문 -->
	<div class="story">${dto.story}</div>

	<!-- 후원하기 버튼 -->
	 <a href="/donation/info/${dto.legend_id}" class="btn-donate">후원하기</a>

</div>

</body>
</html>
