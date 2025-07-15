<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기부 내역 조회</title>
<link rel="stylesheet" href="/css/admin.css">
<link rel="stylesheet" href="/css/popup.css">
</head>
<body>
	<%@ include file="../../include/admin_menu.jsp"%>
	<h2>기부내역 확인</h2>
    <button class="add-btn" id="addButton">추가하기</button>
    <br>

    <div class="search-box">
        <form method="get" action="donation_list.do">
            <select name="searchType">
                <option value="donor_id" ${searchType == 'donor_id' ? 'selected' : ''}>기부자</option>
				<option value="content_title" ${searchType == 'content_title' ? 'selected' : ''}>기부 프로젝트</option>
            </select>
            <input type="text" name="searchKeyword" value="${searchKeyword}" />
            <button type="submit">검색</button>
        </form>
    </div>
	<br>

	<table border="1" width="100%">
		<tr>
			<td>No.</td>
			<td>기부 제목</td>
			<td>기부자</td>
			<td>기부 금액</td>
			<td>기부일</td>
			<td>결제 방식</td>
			<td>보상</td>
		</tr>

		<c:if test="${not empty list}">
			<c:forEach var="row" items="${list}">
				<tr>
					<td>${row.transaction_id}</td>
					<td>${row.content_title}</td>
					<td>${row.donor_id}</td>
					<td><fmt:formatNumber value="${row.amount}" pattern="#,###" />
						원</td>
					<td><fmt:formatDate value="${row.donation_date}"
							pattern="yyyy-MM-dd" /></td>
					<td><c:choose>
							<c:when test="${row.payment_method == 'point'}">포인트</c:when>
							<c:when test="${row.payment_method == 'card'}">카드</c:when>
						</c:choose></td>
					<td>${row.reward_name}</td>
				</tr>
			</c:forEach>
		</c:if>

		<c:if test="${empty list}">
			<tr>
				<td colspan="7" align="center">검색 결과가 없습니다.</td>
			</tr>
		</c:if>
	</table>

	<!-- 페이지 네비게이션 -->
	<%@ include file="../../include/admin_paging.jsp"%>

</body>
</html>
