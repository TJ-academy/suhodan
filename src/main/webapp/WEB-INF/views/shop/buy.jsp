<%@ page language="java" contentType="text/html; charset=UTF-8"%>
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
.input-row input,
.input-inline input,
.input-inline button,
.input-row select {
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
.input-inline input { flex: 1; }
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
	align-items: flex-start;
	gap: 10px;
}
.radio-group small {
	color: #a0522d;
	font-size: 13px;
	margin-left: 24px;
}
</style>
</head>
<body>
<%@ include file="../include/menu.jsp" %>

<div class="outer-box">
	<form action="/shop/cart/complete.do" method="post">
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
				<input type="text" id="address2" name="address2" placeholder="상세 주소를 입력해 주세요" required>
			</div>
		</div>

		<div class="input-row">
			<label for="phone1">연락처</label>
			<div class="input-inline phone-group">
				<input type="tel" id="phone1" name="phone1" maxlength="3" required>
				<input type="tel" id="phone2" name="phone2" maxlength="4" required>
				<input type="tel" id="phone3" name="phone3" maxlength="4" required>
			</div>
		</div>

		<div class="section-title">주문상품</div>
		<div class="order-summary">
			<c:forEach var="item" items="${cartList}">
				<div class="order-item">
					<div class="item-info">
						<img src="/resources/goods_img/${item.goods_img}" alt="${item.goods_name}" onerror="this.onerror=null; this.src='/resources/images/설화수 로고.png';" />
						<span>${item.goods_name} | ${item.amount}개</span>
					</div>
					<div><fmt:formatNumber value="${item.goods_price * item.amount}" pattern="#,###" />원</div>
				</div>
			</c:forEach>
			<div class="total-price">
				총 주문 금액: <fmt:formatNumber value="${total}" pattern="#,###" />원
			</div>
		</div>

		<div class="payment-method">
			<h3>결제 수단</h3>
			<div class="radio-group">
				<label>
					<input type="radio" name="payMethod" value="card" checked>
					<span>신용/체크 카드</span>
				</label>
				<label>
					<input type="radio" name="payMethod" value="bank">
					<div>
						<span>무통장 입금</span>
						<small>※ 수령인의 이름과 입출금 계좌의 명의가 동일해야 합니다.</small>
					</div>
				</label>
			</div>
		</div>

		<!-- 환불 계좌 입력 폼 -->
		<div id="bankForm" style="display:none; margin-top: 20px;">
			<div class="input-row">
				<label>환불 계좌</label>
				<select id="bankName">
					<option value="기업은행">기업은행</option>
					<option value="국민은행">국민은행</option>
					<option value="신한은행">신한은행</option>
					<option value="농협">농협</option>
				</select>
			</div>
			<div class="input-row">
				<label>계좌번호</label>
				<input type="text" id="accountNumber" placeholder="숫자만 입력" />
			</div>
			<div class="input-row no-label">
				<button type="button" class="submit-btn" style="max-width:180px;" onclick="saveBankInfo()">인증 및 저장하기</button>
			</div>
		</div>

		<!-- 요약 정보 -->
		<div id="bankSummary" style="display:none; margin-top: 20px;">
			<div class="input-row">
				<label>환불 계좌</label>
				<span id="summaryText" style="flex:1;"></span>
				<button type="button" onclick="editBankInfo()">변경</button>
			</div>
		</div>

		<!-- 결제 버튼 -->
		<button type="submit" class="submit-btn">결제하기</button>
	</form>
</div>

<!-- 주소 검색 API -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function loadMyInfo() {
	const name = document.getElementById("dtoName").value;
	const address1 = document.getElementById("dtoAddress1").value;
	const address2 = document.getElementById("dtoAddress2").value;
	
	document.getElementById("receiver").value = name;
	document.getElementById("address1").value = address1;
	document.getElementById("address2").value = address2;
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

document.addEventListener("DOMContentLoaded", function () {
	const radios = document.querySelectorAll('input[name="payMethod"]');
	radios.forEach(r => {
		r.addEventListener('change', function () {
			if (this.value === "bank") {
				document.getElementById("bankForm").style.display = "block";
			} else {
				document.getElementById("bankForm").style.display = "none";
				document.getElementById("bankSummary").style.display = "none";
			}
		});
	});
});

function saveBankInfo() {
	const bank = document.getElementById("bankName").value;
	const number = document.getElementById("accountNumber").value.trim();

	if (!number || isNaN(number)) {
		alert("계좌번호를 숫자로 입력해 주세요.");
		return;
	}
	document.getElementById("summaryText").innerText = bank + " " + number;
	document.getElementById("bankForm").style.display = "none";
	document.getElementById("bankSummary").style.display = "block";
}

function editBankInfo() {
	document.getElementById("bankForm").style.display = "block";
	document.getElementById("bankSummary").style.display = "none";
}
</script>
</body>
</html>
