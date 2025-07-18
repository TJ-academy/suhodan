<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문내역 관리</title>
<link rel="stylesheet" href="/css/admin.css">
<link rel="stylesheet" href="/css/popup.css">
<style>
.toggle-details {
	background-color: #d6a77a;
	color: white;
}

.details {
	display: none;
}

.details-box {
	background-color: #f9f4ef;
	border: 1px solid #d1c6b9;
	border-radius: 16px;
	padding: 25px;
	width: 400px;
	margin: 20px auto;
	text-align: center;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.details-box p {
	margin: 10px 0;
	color: #4e3d30;
}

.details-buttons {
	margin-top: 20px;
}

.details-buttons button {
	width: 80px;
	margin: 0 10px;
}

.edit-btn {
	background-color: #e0c7a3;
	color: #3c2c1e;
}

.close-details {
	background-color: #8b5e3c;
	color: white;
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	$(document).ready(function() {
		// 상세 보기 토글
		$(".toggle-details").click(function() {
			let $detailsRow = $(this).closest("tr").next(".details");
			$detailsRow.toggle();
		});

		// 상세 보기 닫기
		$(".close-details").click(function() {
			$(this).closest("tr.details").hide();
		});
	});
</script>
</head>
<body>

	<%@ include file="../../include/admin_menu.jsp"%>
	<h2>주문내역 관리</h2>
	<br>

	<div align="right">총 ${totalCount}개의 내역이
		조회되었습니다.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
	<div class="search-box">
		<form method="get" action="order_list.do">
			<select name="searchType">
				<option value="user_id" ${searchType == 'user_id' ? 'selected' : ''}>주문한
					아이디</option>
				<option value="order_id"
					${searchType == 'order_id' ? 'selected' : ''}>주문번호</option>
				<option value="phone" ${searchType == 'phone' ? 'selected' : ''}>전화번호</option>
			</select> <input type="text" name="searchKeyword" value="${searchKeyword}" />
			<select name="sortBy">
				<option value="order_date"
					${sortBy == 'order_date' ? 'selected' : ''}>결제일</option>
				<option value="order_amount"
					${sortBy == 'order_amount' ? 'selected' : ''}>결제금액</option>
			</select> <select name="sortOrder">
				<option value="asc" ${sortOrder == 'asc' ? 'selected' : ''}>오름차순</option>
				<option value="desc" ${sortOrder == 'desc' ? 'selected' : ''}>내림차순</option>
			</select>
			<button type="submit">검색</button>
		</form>
	</div>
	<br>

	<table border="1" width="700px">
		<tr>
			<th>주문번호</th>
			<th>주문자</th>
			<th>결제일</th>
			<th>결제금액</th>
			<th>결제방법</th>
			<th>상태</th>
			<th>변경</th>
			<th>상태 관리</th>
		</tr>
		<c:if test="${not empty list}">
			<c:forEach var="row" items="${list}">
				<form method="post" action="/admin/update_status.do">
					<tr>
						<td>${row.order_id}</td>
						<td>${row.user_id}</td>
						<td><fmt:formatDate value="${row.order_date}"
								pattern="yyyy-MM-dd" /></td>
						<td><fmt:formatNumber value="${row.order_amount}"
								pattern="#,###" />원</td>
						<td>${row.pay_method}</td>
						<td><select name="order_status">
								<option value="결제진행중"
									${row.order_status eq '결제진행중' ? 'selected' : ''}>결제진행중</option>
								<option value="결제완료"
									${row.order_status eq '결제완료' ? 'selected' : ''}>결제완료</option>
								<option value="환불요청"
									${row.order_status eq '환불요청' ? 'selected' : ''}>환불요청</option>
								<option value="환불완료"
									${row.order_status eq '환불완료' ? 'selected' : ''}>환불완료</option>
								<option value="배송준비중"
									${row.order_status eq '배송준비중' ? 'selected' : ''}>배송준비중</option>
								<option value="배송중"
									${row.order_status eq '배송중' ? 'selected' : ''}>배송중</option>
								<option value="배송완료"
									${row.order_status eq '배송완료' ? 'selected' : ''}>배송완료</option>
						</select></td>
						<td><input type="hidden" name="order_id"
							value="${row.order_id}">
							<button type="submit" onclick="alert('변경되었습니다.');">변경</button></td>
						<td>
							<button class="toggle-details" type="button">상세보기</button>
						</td>
					</tr>
					<tr class="details">
						<td colspan="8">
							<div class="details-box">
								<h3>상세보기</h3>
								<p>주문번호 : ${row.order_id}</p>
								<p>주문자 : ${row.user_id}</p>
								<p>
									결제금액 :
									<fmt:formatNumber value="${row.order_amount}" pattern="#,###" />
									원
								</p>
								<p>환불계좌 : ${row.refund_bank}&nbsp;${row.refund_account}</p>
								<p>배송지 : ${row.order_address1}&nbsp;${row.order_address2}</p>
								<p>연락처 : ${row.phone}</p>
								<div class="detail-buttons">
									<button class="close-details">확인</button>
								</div>
							</div>
						</td>
					</tr>
				</form>
			</c:forEach>
		</c:if>
		<c:if test="${empty list}">
			<tr>
				<td colspan="7" align="center">검색 결과가 없습니다.</td>
			</tr>
		</c:if>
	</table>

	<%@ include file="../../include/admin_paging.jsp"%>
</body>
</html>
