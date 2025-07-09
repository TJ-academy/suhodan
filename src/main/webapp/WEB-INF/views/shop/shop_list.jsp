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

.shop-header p {
	font-size: 17px;
	color: #A49D9D;
}

.shop-grid {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 36px;
	padding: 50px 0;
	justify-content: center;
	margin: 0 auto;
	max-width: 1200px;
	margin-top: -30px;
}

.shop-card {
	width: 260px;
	height: 380px;
	background-color: #fff;
	border: 1px solid #D8C2A6;
	border-radius: 16px;
	padding: 15px;
	transition: transform 0.2s ease;
	overflow: visible;
}

.product-img {
	width: 100%;
	height: 180px;
	object-fit: cover;
	border-radius: 12px;
	margin-bottom: 10px;
}

.card-text {
	display: flex;
	flex-direction: column;
	gap: 6px;
	margin-top: -20px;
}

.product-name {
	font-size: 17px;
	color: #504848;
	margin-top: 10px;
}

.product-price {
	font-size: 19px;
	font-weight: bold;
	color: #000000;
	margin-top: -10px;
}

.product-desc {
	font-size: 15px;
	color: #504848;
	line-height: 1.4;
	min-height: 40px;
}

.card-top {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding-top: 5px;
}


.buy-icon-btn {
	background: none;
	border: none;
	padding: 0;
	margin: 0;
	width: 30px;
	height: 30px;
	cursor: pointer;
	display: flex;
	align-items: center;
	justify-content: center;
	margin-top: 20px;
}

.cart-icon {
	width: 22px;
	height: 22px;
	object-fit: contain;
	display: block;
}

.image-container {
	position: relative;
	width: 100%;
	padding-top: 100%;
	overflow: hidden;
	border-radius: 12px;
	margin-bottom: 14px;
}

.image-container img {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	object-fit: cover;
	border-radius: 12px;
	transition: opacity 0.3s ease;
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
<p>당신의 따뜻한 마음이 작은 마을의 내일을 지켜줍니다.</p>
</div>

<div class="shop-grid">
	<c:forEach var="row" items="${list}">
		<div class="shop-card">
			<div class="image-container">
				<img class="product-img" src="/resources/shop_img/${row.img}" alt="${row.name}"
					onerror="this.onerror=null; this.src='/resources/shop_img/상품.png';" />
				<a href="/shop/detail/${row.reward_id}" class="hover-button">자세히 보기</a>
			</div>
			<div class="card-text">
				<div class="card-top">
					<div class="product-name">${row.name}</div>
					<button class="buy-icon-btn" onclick="addToCart(${row.reward_id})">
						<img src="/resources/shop_img/cart_plus.png" class="cart-icon" />
					</button>
				</div>
				<div class="product-price">
					<fmt:formatNumber value="${row.price}" pattern="#,###" />원
				</div>
				<div class="product-desc">${row.description}</div>
			</div>
		</div>
	</c:forEach>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

</script>
</body>
</html>
