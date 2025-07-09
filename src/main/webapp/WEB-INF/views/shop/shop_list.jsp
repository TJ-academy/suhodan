<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>보따리 상점</title>
<style>
body {
	background-color: #F7EAD9;
	font-family: 'Noto Sans KR', sans-serif;
	margin: 0;
	padding: 0;
}

.shop-header {
	text-align: center;
	margin-top: 20px;
	color: #A49D9D;
}

.shop-header img {
	width: 170px;
	margin-bottom: 10px;
}

.shop-header h2 {
	font-size: 24px;
	font-weight: bold;
	color: #3e2d17;
	margin: 10px 0;
}

.shop-header p {
	font-size: 17px;
	color: #A49D9D;
}

.shop-grid {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
	gap: 36px;
	margin-top: -25px;
	padding: 50px 80px;
	justify-content: start;
	margin-left: -55px;
}


.shop-card {
width: 260px;
	height: 354px;
	background-color: #fff;
	border: 1px solid #D8C2A6;
	border-radius: 16px;
	padding: 15px;
	transition: transform 0.2s ease;
}

.shop-card img {
	width: 100%;
	height: 180px;
	object-fit: cover;
	border-radius: 12px;
	margin-bottom: 12px;
}

.card-text {
	display: flex;
	flex-direction: column;
	gap: 6px;
	margin-top: 40px;
}

.card-top {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.product-name {
	font-size: 15px;
	color: #504848;
}

.product-price {
	font-size: 19px;
	font-weight: bold;
	color: #000000;
}

.product-desc {
	font-size: 15px;
	color: #504848;
	line-height: 1.4;
	min-height: 40px;
}

.buy-icon {
	font-size: 19px;
	color: #504848;
}

.image-container {
	position: relative;
	width: 100%;
	height: 180px;
	overflow: hidden;
	border-radius: 12px;
	margin-bottom: 16px;
}

.image-container img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	transition: opacity 0.3s ease;
	border-radius: 12px;
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
	font-size: 15px;
	cursor: pointer;
	z-index: 3;
	opacity: 0;
	pointer-events: none;
	transition: opacity 0.3s ease;
	text-decoration: none;
}

.image-container:hover img {
	opacity: 0.4;
}

.image-container:hover .hover-button {
	opacity: 1;
	pointer-events: auto;
}

</style>
</head>
<body>
<%@ include file="../include/menu.jsp" %>

	<div class="shop-header">
		<img src="/resources/images/나무로고.png" alt="로고" />
		<p>모든 수익금은 해당 마을을 지키는 데 사용됩니다.</p>
	</div>

	<div class="shop-grid">
		<c:forEach var="row" items="${list}">
<div class="shop-card">
	<div class="image-container">
		<img src="/resources/images/${row.img}" alt="${row.name}"
			onerror="this.onerror=null; this.src='/resources/images/설화수 로고.png';" />
		<a href="/shop/detail/${row.reward_id}" class="hover-button">자세히 보기</a>
	</div>
	<div class="card-text">
		<div class="card-top">
			<div class="product-name">${row.name}</div>
			<div class="buy-icon">🛒</div>
		</div>
		<div class="product-price">
			<fmt:formatNumber value="${row.price}" pattern="#,###" />원
		</div>
		<div class="product-desc">${row.description}</div>
	</div>
</div>

		</c:forEach>
	</div>

</body>
</html>
