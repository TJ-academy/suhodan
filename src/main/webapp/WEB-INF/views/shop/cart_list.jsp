<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
$(function() {
	$("#btnList").click(function() {
		location.href="/shop/list.do";
	});
	$("#btnDelete").click(function() {
		if(confirm("장바구니를 비우시겠습니까?")) {
			location.href="/shop/cart/deleteAll.do";
		}
	});
	
	// amount input 변경 시 서버에 즉시 업데이트 요청 보내기
	$("input[name='amount']").on("change", function() {
		let $amountInput = $(this); // 현재 변경된 amount input
		let $parentDiv = $amountInput.closest("div"); // 같은 장바구니 항목 div

		let cart_id = $parentDiv.find(".cart_id").val();
		let price = parseInt($parentDiv.find(".goods_price").text().replace(/,/g, ''));
		let amount = parseInt($amountInput.val());

		// amount 음수나 0일 경우 삭제로 처리하거나 1 이상으로 제한 가능
		if(amount < 1) {
			if(confirm("수량을 0으로 설정하면 삭제됩니다. 삭제하시겠습니까?")) {
				$.ajax({
					url: "/shop/cart/delete.do",
					method: "GET",
					data: { cart_id: cart_id }
				});
			} else {
				$(this).val(1); // 다시 1로 되돌림
			}
			return;
		}
		
		// 금액 계산 후 표시
		let money = price * amount;
		$parentDiv.find(".money").text(money.toLocaleString());

		$.ajax({
			url: "/shop/cart/update.do",
			method: "POST",
			data: { cart_id: cart_id, amount: amount },
			error: function() {
				alert("수량 업데이트에 실패했습니다.");
			}
		});
	});
});
</script>

</head>
<body>
<%@ include file="../include/menu.jsp" %>
<h2>장바구니</h2>
<c:choose>
	<c:when test="${map.count == 0}">
		장바구니가 비어있습니다.
	</c:when>
	<c:otherwise>
		<form method="post" action="/shop/cart/buy.do">
		<c:forEach var="row" items="${map.list}">
			<div>
				<img src="/resources/goods_img/${row.goods_img}" 
				width="100px" height="auto" alt="${row.goods_name}"
				onerror="this.onerror=null; this.src='/resources/images/설화수 로고.png';" />
				
				<span>
					<input type="hidden" name="cart_id" value="${row.cart_id}" class="cart_id" />
					<strong>${row.goods_name}</strong>
					<br>
					<span class="goods_price">
						<fmt:formatNumber value="${row.goods_price}" pattern="#,###" />
					</span>원
					<br>
					<input type="number" style="width:50px;" min="0" max="10" name="amount" 
					value="${row.amount}" class="amount">
				</span>
				<br>
				<span class="money">
   					<fmt:formatNumber value="${row.money}" pattern="#,###" />
   				</span>원
				<a href="/shop/cart/delete.do?cart_id=${row.cart_id}">삭제</a>
			</div>
			<div style="border-bottom: 1px solid #ccc; width: 300px; margin: 10px 0;"></div>
		</c:forEach>
		<br>
		
		<div>
			장바구니 금액 합계:
			<fmt:formatNumber value="${map.sumMoney}" pattern="#,###,###" />
			<br>
			배송료: ${map.fee}<br>
			총합계:
			<fmt:formatNumber value="${map.sum}" pattern="#,###,###" />
		</div>
		<button type="button" id="btnDelete">장바구니 비우기</button>
		<button type="submit">구매하기</button>
		</form>
	</c:otherwise>
</c:choose>
<br>
<button type="button" id="btnList">상품목록</button>
</body>
</html>