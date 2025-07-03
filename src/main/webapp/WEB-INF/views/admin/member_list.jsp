<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.details {
	display: none; /* 기본적으로 숨기기 */
	background-color: #f9f9f9;
}
</style>
<script>
	function toggleDetails(button) {
		var row = button.closest('tr').nextElementSibling;
		if (row.style.display === 'none') {
			row.style.display = 'table-row';
		} else {
			row.style.display = 'none';
		}
	}
	
	function closeDetails(button) {
		var row = button.closest('tr').previousElementSibling; // 해당 상세보기의 이전 행을 찾음
		var detailsRow = button.closest('tr');
		detailsRow.style.display = 'none';
	}
</script>
</head>
<body>
	<%@ include file="../include/menu.jsp"%>
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
						pattern="yyyy-MM-dd HH:mm:ss" /></td>
				<td>${row.total_donation}</td>
				<td>${row.badge_count}</td>
				<td>
					<button  onclick="toggleDetails(this)">상세보기</button>
					<button>정지</button>
				</td>
			</tr>
			<tr class="details">
				<td colspan="8">
					<p>아이디: ${row.user_id}</p>
					<p>이름: ${row.name}</p>
					<p>성별: ${row.gender}</p>
					<p>
						생년월일:
						<fmt:formatDate value="${row.birth}" pattern="yyyy-MM-dd" />
					</p>
					<p>
						가입일:
						<fmt:formatDate value="${row.join_date}" pattern="yyyy-MM-dd" />
					</p>
					<p>총 기부액: ${row.total_donation}</p>
					<p>보유 배지: 보유 배지</p>
					<p>기부 내역 보기: 기부 내역</p>
					<p>
						상태변경:
						<button>수정</button>
						<button>정지</button>
					</p>
					<button onclick="closeDetails(this)">확인</button>
				</td>
			</tr>
		</c:forEach>
	</table>
</body>
</body>
</html>