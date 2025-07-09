<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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


.logo-box {
	text-align: center;
	margin-bottom: 10px;
	color: #A49D9D;
}

.logo-box img {
	width: 180px;
	margin-bottom: 10px;
}

.logo-box p {
	font-size: 17px;
	color: #A49D9D;
}

.main-image {
	text-align: center;
	margin-bottom: 70px;
}

.main-image img {
	width: 100%;
	max-width: 500px;
	border-radius: 10px;
}

.product-title {
	font-size: 18px;
	font-weight: bold;
	margin: 10px 0 5px;
	color: #222;
	text-align: left;
}

.product-price {
	font-size: 20px;
	font-weight: bold;
	color: #000;
	text-align: left;
	margin-bottom: 15px;
}

.select-box {
	text-align: left;
	margin-bottom: 30px;
}

.select-box select {
	padding: 6px 12px;
	font-size: 16px;
	border: 1px solid #ccc;
	border-radius: 8px;
	margin-right: 8px;
}


.product-description {
	font-size: 15px;
	line-height: 1.6;
	color: #333;
	margin-bottom: 30px;
	text-align: center;
	white-space: pre-line;
}

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
	border-radius: 8px;
}

.add-to-cart-btn {
	display: block;
	width: 100%;
	max-width: 250px;
	margin: 0 auto;
	padding: 14px 0;
	text-align: center;
	background-color: #D9C2AD;
	color: #fff;
	font-weight: bold;
	font-size: 16px;
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

	<button class="back-button" onclick="history.back();">
		<img src="/resources/images/back.png" alt="뒤로가기 아이콘">
	</button>
	<div class="logo-box">
		<img src="/resources/images/나무로고.png" alt="로고" />
		<p>이 상품의 수익금은<br>안동 지역 어르신들을 위한 버스 정류장 쉼터 설치에 사용됩니다.</p>
	</div>

	<div class="main-image">
		<img src="/resources/goods_img/${dto.img}"
			alt="${dto.name}"
			onerror="this.onerror=null; this.src='/resources/images/설화수 로고.png';" />
	</div>

	<div class="product-title">${dto.name}</div>
	<div class="product-price">
		<fmt:formatNumber value="${dto.price}" pattern="#,###" />원
	</div>

	<div class="select-box">
		<form name="form1" method="post" action="/shop/cart/insert.do">
			<input type="hidden" name="goods_id" value="${dto.goods_id}">
			<select name="amount">
				<c:forEach begin="1" end="10" var="i">
					<option value="${i}">${i}</option>
				</c:forEach>
			</select>
		</form>
	</div>

	<div class="product-description">${dto.description}</div>

	<div class="detail-images">
		<img src="/resources/goods_detail_img/${dto.detail_img}" alt="디테일1">
		<img src="/resources/goods_detail_img/${dto.detail_img}" alt="디테일2">
	</div>

	<button class="add-to-cart-btn" onclick="document.form1.submit()">장바구니 담기</button>
</div>

</body>
</html>
