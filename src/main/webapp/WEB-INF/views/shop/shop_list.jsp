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

.shop-list {
	margin: 20px;
	justify-content: center;
	align-items: center;
	width: 1130px; height: 100%;
	left: 50%; transform: translateX(-50%);
	position: relative;
}

.shop-header {
	text-align: center;
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

.shop-filter {
	justify-content: center;
	text-align: right;
	margin-bottom: -20px;
	margin-top: 20px;
}

.shop-filter select, .shop-filter input, .shop-filter button {
	padding: 5px 12px;
	background-color: #FFFFFF;
	border: 1.67px solid #D8C2A6;
	border-radius: 17px;
	color: #504848;
}

.shop-filter select:focus,
.shop-filter input:focus,
.shop-filter button:focus {
	border-color: #9C6B4F;
	outline: none;
}

.shop-filter button {
	padding: 6px 15px;
}

.shop-grid {
	display: flex;
	flex-wrap: wrap;
	gap: 30px;
	padding: 30px 0;
	justify-content: flex-start;
	align-items: center;
	left: 50%;
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
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.product-name {
	font-size: 17px;
	color: #504848;
	margin-top: 10px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.product-price {
	font-size: 21px;
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
	margin-left: auto;
}

.cart-icon {
	width: 22px;
	height: 22px;
	object-fit: contain;
	display: block;
	margin-left: auto;
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

.shop-empty {
	text-align: center;
	color: #504848;
	font-size: 18px;
	margin: 50px 0;
}

.pagination {
	position: relative;
	text-align: center;
	justify-content: center;
	margin: 20px auto;
	bottom: 0px;
	left: 50%;
	transform: translate(-50%, -50%);
	display: flex;
}
.pagination a {
	justify-content: center;
	margin: 0 5px;
	padding: 6px 12px;
	background-color: 'transparent';
	text-decoration: none;
	text-underline-offset: 4px;
	text-underline-color: #2E2E2E;
}
</style>
</head>
<body>
<%@ include file="../include/menu.jsp" %>

<div class="shop-list">
	<div class="shop-header">
		<img src="/resources/images/logo_no_text.png" alt="로고" />
		<p>당신의 따뜻한 마음이 작은 마을의 내일을 지켜줍니다.</p>
	</div>
	
	<div class="shop-filter">
		<form action="/shop/list.do" method="get">
			<select name="category">
				<option value="name" ${category == 'name' ? 'selected' : ''}>상품명</option>
				<option value="location" ${category == 'location' ? 'selected' : ''}>지역명</option>
			</select>
	
			<input type="text" name="keyword" value="${keyword}" placeholder="검색어 입력" />
	
			<select name="sort">
				<option value="new" ${sort == 'new' ? 'selected' : ''}>신상품순</option>
				<option value="low" ${sort == 'low' ? 'selected' : ''}>낮은 가격순</option>
				<option value="high" ${sort == 'high' ? 'selected' : ''}>높은 가격순</option>
				<option value="name" ${sort == 'name' ? 'selected' : ''}>이름순</option>
			</select>
	
			<button type="submit">검색</button>
		</form>
	</div>

	<div class="shop-grid">
		<c:forEach var="row" items="${list}">
			<div class="shop-card">
				<div class="image-container">
					<img class="product-img" src="../../resources/goods_img/${row.img}" alt="${row.name}"
						onerror="this.onerror=null; this.src='../../resources/images/설화수 로고.png';" />
					<a href="/shop/detail/${row.goods_id}" class="hover-button">자세히 보기</a>
				</div>
				<div class="card-text">
					<div class="card-top">
					    <div class="product-name">${row.name}</div>
					    <form action="/shop/cart/insert.do" method="post">
					        <input type="hidden" name="goods_id" value="${row.goods_id}">
					        <input type="hidden" name="amount" value="1">
					        <button type="submit" class="buy-icon-btn">
					            <img src="../../resources/shop_img/cart_plus.png" class="cart-icon" />
					        </button>
					    </form>
					</div>
	
					<div class="product-price">
						<fmt:formatNumber value="${row.price}" pattern="#,###" />원
					</div>
					<div class="product-desc">${row.description}</div>
				</div>
			</div>
		</c:forEach>
	</div>
	
	
	<c:if test="${totalCount == 0}">
	    <div class="shop-empty">
	        검색 결과가 없습니다.
	    </div>
	</c:if>
	
	<!-- 페이지네이션 -->
	<div class="pagination">
	    <c:forEach begin="1" end="${totalPage}" var="i">
	        <a href="/shop/list.do?page=${i}&category=${category}&keyword=${keyword}&sort=${sort}"
	           style="color: ${i == currentPage ? '#2E2E2E' : '#939393'};
				       text-decoration: ${i == currentPage ? 'underline' : 'none'}">
	            ${i}
	        </a>
	    </c:forEach>
	</div>
</div>

<c:if test="${param.message == 'success'}">
	<script>alert("장바구니에 추가되었습니다.");</script>
</c:if>
</body>
</html>
