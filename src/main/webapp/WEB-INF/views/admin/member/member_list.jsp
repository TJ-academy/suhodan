<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 관리</title>
<link rel="stylesheet" href="/css/admin.css">
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
	<h2>회원관리</h2>

	<table border="1" width="700px">
		<tr>
			<td>아이디</td>
			<td>이름</td>
			<td>가입일자</td>
			<td>총기부액</td>
			<td>배지 수</td>
			<td>상태 관리</td>
		</tr>
		<c:forEach var="row" items="${list}">
			<tr>
				<td>${row.user_id}</td>
				<td>${row.name}</td>
				<td><fmt:formatDate value="${row.join_date}"
						pattern="yyyy-MM-dd" /></td>
				<td>${row.total_donation}</td>
				<td>${row.badge_count}</td>
				<td>
					<button class="toggle-details">상세보기</button>
					<button>정지</button>
				</td>
			</tr>
			<tr class="details">
				<td colspan="8">
					<div class="details-box">
						<h3>상세보기</h3>
						<p>아이디 : ${row.user_id}</p>
						<p>이름 : ${row.name}</p>
						<p>
							성별 :
							<c:choose>
								<c:when test="${row.gender == 'w'}">여성</c:when>
								<c:when test="${row.gender == 'm'}">남성</c:when>
							</c:choose>
						</p>
						<p>
							생년월일 :
							<fmt:formatDate value="${row.birth}" pattern="yyyy-MM-dd" />
						</p>
						<p>
							가입일 :
							<fmt:formatDate value="${row.join_date}" pattern="yyyy-MM-dd" />
						</p>
						<p>
							총 기부액 : ${row.total_donation}원 <a href="#"><button
									type="button">기부 내역 보기</button></a>
						</p>
						<p>보유 배지 : 보유 배지</p>
						<p>주소 : ${row.address1} ${row.address2}</p>
						<p>핸드폰 번호 : 아직디비에필드없음</p>
						<div class="detail-buttons">
							<button class="edit-btn">수정</button>
							<button class="close-details">확인</button>
						</div>
					</div>
				</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>

