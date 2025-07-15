<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>

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
	position: relative;
}
.back-button {
	position: absolute;
	top: 40px; left: 60px;
	background: none;
	border: none;
	cursor: pointer;
}
.back-button img {
	width: 15px; height: 25px;
}
.cart-title {
	font-size: 30px;
	font-weight: bold;
	text-align: center;
	margin-bottom: 65px;
	color: #9C6B4F;
}
.cart-box {
	display: flex;
	flex-direction: column;
	gap: 30px;
}
.cart-item {
	border-bottom: 1px solid #ddd;
	padding-bottom: 30px;
}
.cart-content {
	display: flex;
	gap: 20px;
}
.product-image {
	width: 100px;
	height: 100px;
	object-fit: cover;
	border-radius: 10px;
}
.item-details {
	flex: 1;
	display: flex;
	flex-direction: column;
}
.product-header {
	display: flex;
	justify-content: space-between;
}
.product-name {
	font-size: 17px;
	font-weight: bold;
}
.delete-btn {
	color: #760000;
	text-decoration: none;
}
.product-info {
	display: flex;
	align-items: center;
	gap: 15px;
	margin-top: 10px;
}
.product-price {
	font-size: 15px;
}
.amount {
	width: 50px;
	padding: 4px 8px;
	border: 1px solid #ccc;
	border-radius: 6px;
	text-align: center;
}
.money {
	text-align: right;
	margin-top: 19px;
}
.summary {
	margin-top: 40px;
	text-align: right;
}
.summary .total {
	font-size: 20px;
	font-weight: bold;
	margin-top: 10px;
}
.cart-actions {
	margin-top: 30px;
	text-align: center;
	display: flex;
	justify-content: center;
	gap: 20px;
}
.action-btn {
	background-color: #D8C2A6;
	color: white;
	border: none;
	padding: 10px 30px;
	border-radius: 8px;
	font-size: 16px;
	cursor: pointer;
}
.action-btn:hover {
	background-color: #9C6B4F;
}
</style>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
$(function() {
	function updateSummary() {
		let sum = 0;
		$(".cart-item").each(function() {
			const price = parseInt($(this).find(".product-price").data("price"));
			const amount = parseInt($(this).find(".amount").val());
			if (!isNaN(price) && !isNaN(amount)) {
				sum += price * amount;
			}
		});

		const fee = (sum >= 50000 || sum === 0) ? 0 : 3000;
		const total = sum + fee;

		$(".summary-sum").text(sum.toLocaleString() + "원");
		$(".summary-fee").text(fee.toLocaleString() + "원");
		$(".summary-total").text(total.toLocaleString() + "원");
	}

	$("input[name='amount']").on("change", function() {
		const $item = $(this).closest(".cart-item");
		const cart_id = $item.find(".cart_id").val();
		const price = parseInt($item.find(".product-price").data("price"));
		let amount = parseInt($(this).val());

		if (amount < 1) {
			if (confirm("수량이 1보다 작습니다. 삭제하시겠습니까?")) {
				location.href = "/shop/cart/delete.do?cart_id=" + cart_id;
			} else {
				$(this).val(1);
			}
			return;
		}

		const total = price * amount;
		$item.find(".money").text(total.toLocaleString() + "원");
		updateSummary();

		$.post("/shop/cart/update.do", { cart_id, amount })
		 .fail(() => alert("수량 업데이트 실패"));
	});

	updateSummary();
});
</script>
</head>
<body>

<%@ include file="../include/menu.jsp" %>

<div class="outer-box">
	<button class="back-button" onclick="location.href='/shop/list.do'">
		<img src="/resources/images/back.png" alt="뒤로가기">
	</button>

	<div class="cart-title">장바구니</div>

	<c:choose>
		<c:when test="${map.count == 0}">
			<p style="text-align:center;">장바구니가 비어있습니다.</p>
		</c:when>
		<c:otherwise>
			<form method="post" action="/shop/cart/buy.do">
				<div class="cart-box">
					<c:forEach var="row" items="${map.list}">
						<div class="cart-item">
							<div class="cart-content">
								<img class="product-image" src="/resources/goods_img/${row.goods_img}" alt="${row.goods_name}" onerror="this.onerror=null; this.src='/resources/images/설화수 로고.png';" />

								<div class="item-details">
									<div class="product-header">
										<div class="product-name">${row.goods_name}</div>
										<a class="delete-btn" href="/shop/cart/delete.do?cart_id=${row.cart_id}">삭제</a>
									</div>

									<input type="hidden" class="cart_id" name="cart_id" value="${row.cart_id}" />

									<div class="product-info">
										<div class="product-price" data-price="${row.goods_price}">
											<fmt:formatNumber value="${row.goods_price}" pattern="#,###" />원
										</div>
										<input type="number" name="amount" class="amount" min="1" max="10" value="${row.amount}" />
									</div>

									<div class="money">
										<fmt:formatNumber value="${row.money}" pattern="#,###" />원
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>

				<div class="summary">
					장바구니 금액 합계: <span class="summary-sum"><fmt:formatNumber value="${map.sumMoney}" pattern="#,###" /></span><br>
					배송료: <span class="summary-fee"><fmt:formatNumber value="${map.fee}" pattern="#,###" /></span><br>
					<div class="total">총합계: <span class="summary-total"><fmt:formatNumber value="${map.sum}" pattern="#,###" /></span></div>
				</div>

				<div class="cart-actions">
					<button type="button" class="action-btn" onclick="location.href='/shop/cart/deleteAll.do'">장바구니 비우기</button>
					<button type="submit" class="action-btn">구매하기</button>
				</div>
			</form>
		</c:otherwise>
	</c:choose>
</div>

</body>
</html>
