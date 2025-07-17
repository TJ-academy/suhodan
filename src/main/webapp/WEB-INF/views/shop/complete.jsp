<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.text.SimpleDateFormat, java.util.Calendar" %>
<%
    Calendar cal = Calendar.getInstance();
    cal.add(Calendar.DATE, 7);
    SimpleDateFormat sdf = new SimpleDateFormat("M월 d일 H시 m분");
    String deadline = sdf.format(cal.getTime());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>보따리 상점 - 주문 완료</title>
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
.complete-title {
	color: #9c6b4f !important;
	font-size: 32px;
	font-weight: bold;
	margin-bottom: 30px;
	
}

.divider {
	border-bottom: 1px solid #E0D2C0;
	margin-bottom: 24px;
	margin-top: 8px;   
}
.deadline-text {
	font-size: 19px;
	color: #000;
	margin-bottom: 35px;
}
.section {
	margin-bottom: 35px;
	padding-bottom: 20px;
	border-bottom: 1px solid #E0D2C0;
}
.section:last-of-type {
	border-bottom: none;
}
.section-title {
	font-size: 19px;
	color: #000000;
	margin-bottom: 20px;
}
.info-text {
	font-size: 15px;
	color: #000000;
	margin-bottom: 16px;
	display: flex;
	justify-content: space-between;
}
.info-text.date {
	font-size: 19px;
}
.info-text.receiver {
	font-size: 19px;
	display: block;
}
.value {
	text-align: right;
	flex-shrink: 0;
	margin-left: auto;
}
.total {
	font-weight: bold;
	font-size: 17px;
}
.button-group {
	display: flex;
	justify-content: flex-end;
	gap: 10px;
	margin-top: 30px;
}

.cancel-btn, .continue-btn {
	padding: 10px 24px;
	border-radius: 20px;
	font-size: 14px;
	font-family: 'Noto Sans KR', sans-serif;
	border: 1px solid #9C6B4F;
	background-color: #D9C2AD;
	color: #fff;
	cursor: pointer;
	transition: all 0.2s ease-in-out;
}

.cancel-btn:hover, .continue-btn:hover {
	background-color: #9C6B4F;
}

/* 팝업 스타일 */
#cancelPopup {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100vw;
	height: 100vh;
	background: rgba(0, 0, 0, 0.4);
	z-index: 1000;
	justify-content: center;
	align-items: center;
}
.popup-box {
	background-color: #F5F1EB;
	padding: 100px 80px;
	border-radius: 16px;
	text-align: center;
	border: 1px solid #D8C2A6;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}
.popup-box h3 {
	font-size: 32px;
	color: #9C6B4F;
	font-weight: bold;
	margin-bottom: 50px;
}
.popup-box p {
	font-size: 19px;
	color: #2E2E2E;
	margin-bottom: 50px;
}
.popup-buttons {
	display: flex;
	justify-content: center;
	gap: 14px;
}
.popup-buttons button {
	border-radius: 10px;
	padding: 10px 24px;
	font-size: 15px;
	cursor: pointer;
}
.btn-back {
	background-color: #9C6B4F;
	color: #fff;
	border: 1px solid #9C6B4F;
}
.btn-confirm {
background-color: #D8C2A6;
	color: #9C6B4F;
	border: 1px solid #9C6B4F;
}
</style>
</head>
<body>
<%@ include file="../include/menu.jsp" %>

<div class="outer-box">
	<h2 class="complete-title">주문이 완료되었습니다.</h2>

	<div class="divider"></div>
	<p class="deadline-text"><%= deadline %>까지 입금해 주세요.</p>

	<div class="section">
		<div class="info-text">
			입금 대기 금액 <span class="value"><fmt:formatNumber value="${total}" pattern="#,###" />원</span>
		</div>
		<div class="info-text">
			입금 정보 <span class="value">기업은행 987654321987</span>
		</div>
	</div>

	<div class="section">
		<div class="info-text receiver">${receiver}</div>
		<div class="info-text">${address1} ${address2}</div>
		<div class="info-text">${phone}</div>
	</div>

	<div class="section">
		<div class="section-title">결제 정보</div>
		<div class="info-text">
			결제 수단 <span class="value">무통장입금 </span>
		</div>
		<div class="info-text total" style="border-bottom: none;">
	<strong>총 결제 금액</strong> <span class="value total"><fmt:formatNumber value="${total}" pattern="#,###" />원</span>
</div>

	</div>

	<div class="button-group">
		<button class="cancel-btn" onclick="showPopup()">주문 취소</button>
		<button class="continue-btn" onclick="location.href='/shop/list.do'">계속 쇼핑하기</button>
	</div>
</div>

<!-- 주문 취소 팝업 -->
<div id="cancelPopup">
	<div class="popup-box">
		<h3>주문을 취소할까요?</h3>
		<p>‘확인’을 누르시면 주문이 취소됩니다.</p>
		<div class="popup-buttons">
			<button class="btn-back" onclick="closePopup()">뒤로 가기</button>
			<button class="btn-confirm" onclick="cancelOrder(${order_id})">확인</button>
		</div>
	</div>
</div>

<script>
	function showPopup() {
		document.getElementById('cancelPopup').style.display = 'flex';
	}
	function closePopup() {
		document.getElementById('cancelPopup').style.display = 'none';
	}
	function cancelOrder(order_id) {
		location.href = '/orders/cancel.do?order_id='+order_id; // 취소 완료 페이지 연결
	}
	
</script>
</body>
</html>
