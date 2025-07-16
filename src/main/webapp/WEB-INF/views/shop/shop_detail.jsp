<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>보따리 상점 - 상세</title>
<style>
body {
	background-color: #FDF4EC;
	font-family: 'Noto Sans KR', sans-serif;
	margin: 0;
	padding: 0;
}

.outer-box {
	max-width: 1000px;
	margin: 60px auto;
	background-color: #F5F1EB;
	border: 1px solid #D8C2A6;
	border-radius: 20px;
	padding: 50px 60px;
	position: relative;
	box-sizing: border-box;
}

.back-button {
	position: absolute;
	top: 40px; left: 60px;
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
	margin-top: 30px;
}

/* 메인 이미지 */
.main-image {
	width: 100%;
	max-width: 900px;
	height: 500px;
	margin: 90px auto 40px;
	overflow: hidden;
}

.main-image img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

/* 상품 정보 */
.product-info {
	position: relative;
	min-height: 100px;
	margin-bottom: 30px;
}

.product-title {
	font-size: 26px;
	font-weight: bold;
	color: #000000;
	text-align: left;
}

.product-meta {
	position: absolute;
	bottom: 0;
	right: 0;
	display: flex;
	align-items: center;
	gap: 20px;
}

.product-price {
	font-size: 26px;
	font-weight: bold;
	color: #000000;
}

.amount-input {
	width: 60px;
	padding: 6px 10px;
	font-size: 16px;
	border: 1px solid #ccc;
	border-radius: 8px;
	text-align: center;
}

/* 구분선 */
.divider-line {
	border: none;
	border-top: 2px solid #C4C4C4;
	width: 100%;
	margin: 40px auto 20px;
}

/* 설명 영역 */
.product-description {
	font-size: 22px;
	line-height: 1.7;
	color: #333;
	margin-bottom: 40px;
	text-align: center;
	white-space: pre-line;
}

/* 상세 이미지들 */
.detail-images {
	display: flex;
	flex-direction: column;
	align-items: center;
	gap: 16px;
	margin-bottom: 30px;
}

.detail-images img {
	width: 100%;
	max-width: 360px;
}

/* 버튼 */
.add-to-cart-btn {
	display: block;
	width: 100%;
	max-width: 430px;
	margin: 0 auto;
	padding: 14px 0;
	text-align: center;
	background-color: #D9C2AD;
	color: #fff;
	font-weight: bold;
	font-size: 19px;
	border: none;
	border-radius: 10px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.add-to-cart-btn:hover {
	background-color: #9C6B4F;
}
</style>
</head>
<body>
<%@ include file="../include/menu.jsp" %>

<div class="outer-box">

	<!-- 뒤로가기 버튼 -->
	<button class="back-button" onclick="history.back()">
		<img src="/resources/images/back.png" alt="뒤로가기 아이콘">
	</button>

	<!-- 메인 이미지 -->
	<div class="main-image">
		<img src="/resources/goods_img/${dto.img}"
			alt="${dto.name}"
			onerror="this.onerror=null; this.src='/resources/shop_img/설화수.png';" />
	</div>

	<!-- 상품명 + 가격/수량 -->
	<div class="product-info">
		<div class="product-title">${dto.name}</div>
		<div class="product-meta">
			<div class="product-price">
				<fmt:formatNumber value="${dto.price}" pattern="#,###" />원
			</div>
			<form name="form1" method="post" action="/shop/cart/insert.do">
				<input type="hidden" name="goods_id" value="${dto.goods_id}">
				<input type="number" name="amount" class="amount-input" value="1" min="1" max="10">
			</form>
		</div>
	</div>

	<!-- 구분선 -->
	<hr class="divider-line">

	<!-- 상품 설명 -->
	<div class="product-description">${dto.description}</div>

	<!-- 상세 이미지 -->
	<div class="detail-images">
		<img src="/resources/goods_detail_img/${dto.detail_img}" alt="디테일1">
	</div>

	<!-- 장바구니 버튼 -->
	<button class="add-to-cart-btn" onclick="document.form1.submit()">장바구니 담기</button>
</div>

</body>
</html>
