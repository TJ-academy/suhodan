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
		let cart_id = $(this).data("cart-id");
		let amount = $(this).val();

		// amount 음수나 0일 경우 삭제로 처리하거나 1 이상으로 제한 가능
		if(amount < 1) {
			if(confirm("수량을 0으로 설정하면 삭제됩니다. 삭제하시겠습니까?")) {
				$.ajax({
					url: "/shop/cart/delete.do",
					method: "GET",
					data: { cart_id: cart_id },
					success: function() {
						location.reload();  // 삭제 후 페이지 새로고침
					}
				});
			} else {
				$(this).val(1); // 다시 1로 되돌림
			}
			return;
		}

		$.ajax({
			url: "/shop/cart/update.do",
			method: "POST",
			data: { cart_id: cart_id, amount: amount },
			success: function(response) {
				// 필요시 처리, 예: 금액 갱신 등
				location.reload();  // 업데이트 후 새로고침 (필요 없으면 제거)
			},
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
				<img src="/resources/images/${row.reward_img}" 
				width="100px" height="auto" alt="${row.reward_name}"
				onerror="this.onerror=null; this.src='/resources/images/설화수 로고.png';" />
				
				<span>
					<input type="hidden" name="cart_id" value="${row.cart_id}" />
					<strong>${row.reward_name}</strong>
					<br>
					<fmt:formatNumber value="${row.reward_price}" pattern="#,###" />원
					<br>
					<input type="number" style="width:30px;" min="0" max="10" name="amount" 
					value="${row.amount}" data-cart-id="${row.cart_id}">
				</span>
				<br>
   				<fmt:formatNumber value="${row.money}" pattern="#,###" />원
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