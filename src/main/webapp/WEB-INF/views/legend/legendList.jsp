<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 설화 보기</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	background-color: #F7EAD9;
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

.list {
	text-align: center;
	margin-bottom: 40px;
}

.logo img {
	width: 180px;
	margin-bottom: 10px;
}

.list h2 {
	font-size: 24px;
	font-weight: bold;
	color: #3e2d17;
}

.card-grid {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(395px, 1fr));
	gap: 24px;
	justify-content: center;
}

.legend-card {
	width: 100%;
	max-width: 395px;
	height: 348px;
	position: relative;
	background-color: #F5F1EB;
	border: 1px solid #D8C2A6;
	border-radius: 12px;
	overflow: hidden;
	margin: 0 auto;
}

.legend-data {
	position: absolute;
	top: 10px;
	right: 12px;
	font-size: 13px;
	color: #5c5241;
	z-index: 2;
}

.image-container {
	position: relative;
	width: 100%;
	height: 131px;
	overflow: hidden;
	margin-top: 50px;
}

.image-container img {
	width: 354px;
	height: 131px;
	object-fit: cover;
	display: block;
	margin: 0 auto;
	border-radius: 10px;
}

.image-container:hover img {
	opacity: 0.4;
}

.hover-button {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	background-color: #9C6B4F;
	color: white;
	padding: 6px 16px;
	border: none;
	border-radius: 6px;
	font-size: 14px;
	cursor: pointer;
	z-index: 3;
	opacity: 0;
	pointer-events: none;
	transition: opacity 0.3s ease;
}

.image-container:hover .hover-button {
	opacity: 1;
	pointer-events: auto;
}

.legend-content {
	padding: 18px;
	margin-top: 10px;
	text-align: center;
}

.legend-title {
	font-size: 19px;
	font-weight: bold;
	color: #2E2E2E;
	margin-bottom: 6px;
}

.legend-location {
	font-size: 17px;
	color: #2E2E2E;
	font-weight: bold;
}

.legend-desc {
	font-size: 13px;
	color: #2E2E2E;
	margin-top: 15px;
}


.search-bar {
	display: flex;
	justify-content: flex-end;
	align-items: center;
	margin-bottom: 30px;
	gap: 10px;
}

.search-bar input[type="text"] {
	padding: 6px 12px;
	border: 1px solid #ccc;
	border-radius: 20px;
	font-size: 14px;
	width: 250px;
	background-color: #fff;
}

.search-bar button {
	background-color: transparent;
	border: none;
	cursor: pointer;
	padding: 0;
}

.search-bar button img {
	width: 18px;
	height: 18px;
}

</style>
</head>
<body>
	<%@ include file="../include/menu.jsp"%>

	<div class="outer-box">
	<button class="back-button" onclick="history.back();">
		<img src="/resources/images/back.png" alt="뒤로가기 아이콘">
	</button>
		<!-- 상단 로고 및 제목 -->
		<div class="list">
			<img src="/resources/images/나무로고.png" alt="로고">
			<h2>전체 설화 보기</h2>
		</div>
		
		<form method="get" action="/legend/legend.do" class="search-bar">
	<input type="text" name="keyword" placeholder="지역 또는 프로젝트 이름으로 검색">
	<button type="submit">
		<img src="/resources/images/search-icon.png" alt="검색">
	</button>
</form>

		<!-- 카드 리스트 -->
		<div class="card-grid">
			<c:forEach var="row" items="${list}">
				<div class="legend-card">
					<!-- 날짜 -->
					<div class="legend-data">
						<fmt:formatDate value="${row.reg_date}" pattern="yyyy.MM.dd" />
					</div>

					<!-- 이미지: DB에서 가져온 이미지 경로 -->
					<div class="image-container">
						<img src="${row.img}" alt="설화 이미지"> <a
							href="/legend/detail/${row.legend_id}">
							<button class="hover-button">자세히 보기</button>
						</a>
					</div>

					<!-- 텍스트 콘텐츠 -->
					<div class="legend-content">
						<c:set var="mainArea" value="${fn:split(row.location, ' ')[0]}" />
						<c:set var="subArea" value="${fn:split(row.location, ' ')[1]}" />
						<div class="legend-location">
							<span style="font-weight: normal;">${mainArea}</span> <span
								style="font-weight: bold;"> ${subArea}</span>
						</div>
						<div class="legend-title">${row.title}</div>
						<div class="legend-desc">
							<c:out value="${row.story}" />
						</div>
					</div>
				</div>
			</c:forEach>
		</div> 

</div>
</body>
</html>