<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매</title>
<style>
body {
	background-color: #fdf4ec;
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
	box-sizing: border-box;
}

.section-title {
	font-size: 32px;
	font-weight: bold;
	color: #5e3c19;
	margin-bottom: 20px;
}

.input-row {
	display: flex;
	align-items: center;
	margin-bottom: 16px;
}

.input-row label {
	width: 100px;
	font-weight: bold;
	color: #3f2b18;
}

.input-row input,
.input-inline input,
.input-inline button {
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 10px;
	box-sizing: border-box;
	font-family: 'Noto Sans KR', sans-serif;
}

.input-inline {
	display: flex;
	gap: 10px;
	flex: 1;
}

.input-inline input {
	flex: 1;
}

.input-inline button {
	padding: 10px 16px;
	background-color: #fff;
	border: 1px solid #aaa;
	cursor: pointer;
	border-radius: 10px;
}

.input-row.full-inline {
	align-items: flex-start;
}
.input-row.full-inline .input-inline {
	flex: 1;
}

.no-label label {
	visibility: hidden;
	width: 100px;
}

.input-inline.phone-group input {
	width: 10px;
}

.order-summary {
	background-color: #f8eee4;
	border: 1px solid #d7c4b0;
	border-radius: 12px;
	padding: 20px;
	margin-top: 30px;
}

.order-item {
	display: flex;
	align-items: center;
	justify-content: space-between;
	margin-bottom: 16px;
}

.order-item img {
	width: 50px;
	height: 50px;
	border-radius: 8px;
	object-fit: cover;
	margin-right: 15px;
}

.item-info {
	display: flex;
	align-items: center;
}

.total-price {
	font-size: 22px;
	font-weight: bold;
	color: #8b5c38;
	text-align: right;
	margin-top: 20px;
}

.submit-btn {
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

.submit-btn:hover {
	background-color: #9C6B4F;
}

.payment-method {
	margin-top: 40px;
}

.payment-method h3 {
	font-size: 32px;
	font-weight: bold;
	color: #5e3c19;
	margin-bottom: 14px;
}

.radio-group {
	display: flex;
	flex-direction: column;
	gap: 10px;
	font-size: 15px;
	color: #3f2b18;
}

.radio-group label {
	display: flex;
	align-items: center;
	gap: 10px;
}
</style>
</head>
<body>
<%@ include file="../include/menu.jsp"%>

<div class="outer-box">
	<form action="/shop/cart/complete.do" method="post">
		<div class="section-title">배송지</div>

		<!-- 수령인 -->
		<div class="input-row">
			<label for="receiver">수령인</label>
			<input type="text" id="receiver" name="receiver" required>
		</div>

		<!-- 배송지 -->
		<div class="input-row">
			<label for="address1">배송지</label>
			<div class="input-inline">
				<input type="text" id="address1" name="address1" readonly required>
				<button type="button" onclick="execDaumPostcode()">우편번호 검색</button>
			</div>
		</div>
		<div class="input-row full-inline no-label">
			<label></label>
			<div class="input-inline">
				<input type="text" id="address2" name="address2" placeholder="상세 주소를 입력해 주세요" required>
			</div>
		</div>

		<!-- 연락처 -->
		<div class="input-row">
			<label for="phone1">연락처</label>
			<div class="input-inline phone-group">
				<input type="tel" id="phone1" name="phone1" maxlength="3" required>
				<input type="tel" id="phone2" name="phone2" maxlength="4" required>
				<input type="tel" id="phone3" name="phone3" maxlength="4" required>
			</div>
		</div>

		<!-- 주문상품 -->
		<div class="section-title">주문상품</div>
		<div class="order-summary">
			<c:forEach var="item" items="${cartList}">
				<div class="order-item">
					<div class="item-info">
						<img src="/resources/goods_img/${item.goods_img}" alt="${item.goods_name}"
							 onerror="this.onerror=null; this.src='/resources/images/설화수 로고.png';" />
						<span>${item.goods_name} | ${item.amount}개</span>
					</div>
					<div>
						<fmt:formatNumber value="${item.goods_price * item.amount}" pattern="#,###" />원
					</div>
				</div>
			</c:forEach>
			<div class="total-price">
				총 주문 금액: <fmt:formatNumber value="${total}" pattern="#,###" />원
			</div>
		</div>

		<!-- 결제 수단 -->
		<div class="payment-method">
			<h3>결제 수단</h3>
			<div class="radio-group">
				<label><input type="radio" name="payMethod" value="card" checked> 신용/체크 카드</label>
				<label><input type="radio" name="payMethod" value="bank"> 무통장 입금</label>
			</div>
		</div>

		<!-- 결제 버튼 -->
		<button type="submit" class="submit-btn">결제하기</button>
	</form>
</div>

<!-- 주소 검색 스크립트 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function execDaumPostcode() {
	new daum.Postcode({
		oncomplete: function(data) {
			const fullAddr = "(" + data.zonecode + ") " + (data.roadAddress || data.jibunAddress);
			document.getElementById("address1").value = fullAddr;
			document.getElementById("address2").focus();
		}
	}).open();
}
</script>
</body>
</html>
