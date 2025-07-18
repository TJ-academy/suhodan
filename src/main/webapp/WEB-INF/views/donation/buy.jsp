<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리워드 구매</title>
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
.section-header {
	display: flex;
	align-items: center;
}
.load-info-btn {
	padding: 5px 13px;
	font-size: 13px;
	color: #FFFFFF;
	background-color: #9C6B4F;
	border: 1px solid #9C6B4F;
	cursor: pointer;
	border-radius: 16.65px;
	margin-left: 10px;
	margin-bottom: 10px;
}
.input-row {
	display: flex;
	align-items: center;
	margin-bottom: 16px;
	gap: 10px;
}
.input-row label {
	width: 100px;
	font-weight: bold;
	color: #3f2b18;
}
.input-inline {
	display: flex;
	gap: 10px;
	flex: 1;
}
.input-inline input,
.input-row input {
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 10px;
	box-sizing: border-box;
	font-family: 'Noto Sans KR', sans-serif;
}
.input-inline button {
	padding: 10px 16px;
	background-color: #fff;
	border: 1px solid #aaa;
	cursor: pointer;
	border-radius: 16.65px;
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
	margin: 40px auto 0;
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
</style>
</head>
<body>

<%@ include file="../include/menu.jsp" %>

<div class="outer-box">
	<form action="/donation/complete.do" method="post">
		<input type="hidden" name="rewardTier" value="${param.tier}" />
		<input type="hidden" name="amount" value="${param.amount}" />
<div class="section-header">
		<div class="section-title">배송지</div>
		<button type="button" class="load-info-btn" onclick="loadMyInfo()">내 정보 불러오기</button>
			<input type="hidden" id="dtoName" value="${dto.name}" />
			<input type="hidden" id="dtoAddress1" value="${dto.address1}" />
			<input type="hidden" id="dtoAddress2" value="${dto.address2}" />
		</div>
		
		<div class="input-row">
			<label for="receiver">수령인</label>
			<input type="text" id="receiver" name="receiver" required>
		</div>

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
				<input type="text" id="address2" name="address2" placeholder="상세 주소를 입력해 주세요" required style="width: 95.3%;">
			</div>
		</div>

		<div class="input-row">
			<label for="phone1">연락처</label>
			<div class="input-inline">
				<input type="tel" name="phone1" maxlength="3" required>
				<input type="tel" name="phone2" maxlength="4" required>
				<input type="tel" name="phone3" maxlength="4" required>
			</div>
		</div>

		<div class="section-title">주문상품</div>
		<div class="order-summary">
			<div class="order-item">
				<div class="item-info">
					<img src="/resources/images/리워드.png" alt="리워드 이미지" onerror="this.onerror=null; this.src='/resources/images/설화수 로고.png';" />
					<span>${reward.name} (${param.tier}</span>
				</div>
				<div>0원</div>
			</div>
			<div class="total-price">
				총 주문 금액: 0원
			</div>
		</div>

		<button type="submit" class="submit-btn">결제하기</button>
	</form>
</div>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function loadMyInfo() {
	const name = document.getElementById("dtoName").value;
	const address1 = document.getElementById("dtoAddress1").value;
	const address2 = document.getElementById("dtoAddress2").value;
	const phone1 = document.getElementById("dtoPhone1").value;
	const phone2 = document.getElementById("dtoPhone2").value;
	const phone3 = document.getElementById("dtoPhone3").value;
	
	document.getElementById("receiver").value = name;
	document.getElementById("address1").value = address1;
	document.getElementById("address2").value = address2;
	document.getElementById("phone1").value = phone1;
	document.getElementById("phone2").value = phone2;
	document.getElementById("phone3").value = phone3;
}

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
