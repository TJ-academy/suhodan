<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 취소 완료</title>
<style>
body {
	background-color: #f9f3ea;
	font-family: 'Noto Sans KR', sans-serif;
	margin: 0;
	padding: 0;
}
.container {
	max-width: 800px;
	margin: 80px auto;
	background-color: #f5f1eb;
	border: 1px solid #e0d4c2;
	border-radius: 12px;
	padding: 40px;
}
.title {
	font-size: 26px;
	color: #804f28;
	font-weight: bold;
	margin-bottom: 30px;
}
.refund-info {
	margin-bottom: 20px;
	border-top: 1px solid #ccc;
	padding-top: 20px;
}
.refund-info div {
	display: flex;
	justify-content: space-between;
	margin-bottom: 10px;
	font-size: 16px;
}
.canceled-item {
	display: flex;
	align-items: center;
	justify-content: space-between;
	border-top: 1px solid #ddd;
	padding: 15px 0;
}
.item-left {
	display: flex;
	align-items: center;
}
.item-left img {
	width: 60px;
	height: 60px;
	object-fit: cover;
	border-radius: 10px;
	margin-right: 15px;
}
.item-name {
	font-weight: bold;
}
.item-price {
	font-size: 15px;
}
.btn {
	margin-top: 30px;
	display: inline-block;
	background-color: #ddd1be;
	color: #333;
	padding: 10px 18px;
	border: none;
	border-radius: 8px;
	text-decoration: none;
	font-size: 14px;
}
.btn:hover {
	background-color: #c5b39b;
}
</style>
</head>
<body>
<%@ include file="../include/menu.jsp" %>

<div class="container">
	<div class="title">주문 취소가 완료되었습니다.</div>

	<div class="refund-info">
		<div>
			<span>환불 예정 금액</span>
			<span><fmt:formatNumber value="${refundAmount}" pattern="#,###"/>원</span>
		</div>
	</div>

	<c:forEach var="item" items="${canceledList}">
		<div class="canceled-item">
			<div class="item-left">
				<img src="/resources/goods_img/${item.goods_img}" alt="${item.goods_name}">
				<div>
					<div class="item-name">${item.goods_name}</div>
					<div class="item-desc">${item.goods_desc} | ${item.amount}개</div>
				</div>
			</div>
			<div class="item-price">
				<fmt:formatNumber value="${item.goods_price * item.amount}" pattern="#,###"/>원
			</div>
		</div>
	</c:forEach>

	<a href="/shop/list.do" class="btn">계속 쇼핑하기</a>
</div>

</body>
</html>
