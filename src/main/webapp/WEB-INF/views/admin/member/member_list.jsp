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
	<h2>회원 관리</h2>
	<br>

	<div align="right">총 ${totalCount}개의 내역이 조회되었습니다.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    <div class="search-box">
        <form method="get" action="member_list.do">
            <select name="searchType">
                <option value="user_id" ${searchType == 'user_id' ? 'selected' : ''}>아이디</option>
                <option value="name" ${searchType == 'name' ? 'selected' : ''}>이름</option>
            </select>
            <input type="text" name="searchKeyword" value="${searchKeyword}" />
            <select name="sortBy">
                <option value="join_date" ${sortBy == 'join_date' ? 'selected' : ''}>가입일</option>
                <option value="total_donation" ${sortBy == 'total_donation' ? 'selected' : ''}>기부금액</option>
                <option value="badge_count" ${sortBy == 'badge_count' ? 'selected' : ''}>배지 수</option>
            </select>
            <select name="sortOrder">
                <option value="asc" ${sortOrder == 'asc' ? 'selected' : ''}>오름차순</option>
                <option value="desc" ${sortOrder == 'desc' ? 'selected' : ''}>내림차순</option>
            </select>
            <button type="submit">검색</button>
        </form>
    </div>
	<br>

	<table border="1" width="700px">
		<tr>
			<td>아이디</td>
			<td>이름</td>
			<td>가입일자</td>
			<td>총기부액</td>
			<td>배지 수</td>
			<td>상태 관리</td>
		</tr>
		<c:if test="${not empty list}">
			<c:forEach var="row" items="${list}">
				<tr>
					<td>${row.user_id}</td>
					<td>${row.name}</td>
					<td><fmt:formatDate value="${row.join_date}"
							pattern="yyyy-MM-dd" /></td>
					<td><fmt:formatNumber value="${row.total_donation}"
							pattern="#,###" />원</td>
					<td>${row.badge_count}</td>
					<td>
						<button class="toggle-details">상세보기</button>
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
								총 기부액 :
								<fmt:formatNumber value="${row.total_donation}" pattern="#,###" />
								원
							</p>
							<p>
								<a
									href="donation_list.do?searchType=donor_id&searchKeyword=${row.user_id}"><button
										type="button">기부 내역 보기</button></a>
							</p>
							<p>보유 배지 : 보유 배지</p>
							<p>주소 : ${row.address1} ${row.address2}</p>
							<p>핸드폰 번호 : ${row.phone1} - ${row.phone2} - ${row.phone3}</p>
							<div class="detail-buttons">
								<button class="close-details">확인</button>
							</div>
						</div>
					</td>
				</tr>
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

