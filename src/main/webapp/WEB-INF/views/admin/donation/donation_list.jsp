<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>기부 내역</title>
    <link rel="stylesheet" href="/css/admin.css">
    <link rel="stylesheet" href="/css/popup.css">
</head>
<body>
    <%@ include file="../../include/admin_menu.jsp" %>
    <div class="header-container">
        <h2>기부 관리</h2>
        
        <!-- 검색 기능 -->
        <form action="donation_list.do" method="get">
            <select name="search_option">
                <option value="donor_id" ${searchOption == 'donor_id' ? 'selected' : ''}>Donor ID</option>
                <option value="content_title" ${searchOption == 'content_title' ? 'selected' : ''}>Content Title</option>
                <option value="">전체</option>
            </select>
            <input type="text" name="keyword" value="${keyword}" placeholder="검색어를 입력하세요" />
            <button type="submit">검색</button>
        </form>
        
        <!-- 추가하기 버튼 -->
        <button id="addButton">추가하기</button>
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
            <td>상태</td>
            <td>보상</td>
            <td>상세</td>
        </tr>

        <c:if test="${not empty list}">
            <c:forEach var="row" items="${list}">
                <tr>
                    <td>${row.transaction_id}</td>
                    <td>${row.content_title}</td>
                    <td>${row.donor_id}</td>
                    <td><fmt:formatNumber value="${row.amount}" pattern="#,###" /> 원</td>
                    <td><fmt:formatDate value="${row.donation_date}" pattern="yyyy-MM-dd" /></td>
                    <td>${row.payment_method}</td>
                    <td>${row.status}</td>
                    <td>${row.reward_name}</td>
                    <td>
                        <button class="edit-button" data-transaction-id="${row.transaction_id}"
                                data-donor-id="${row.donor_id}" data-amount="${row.amount}"
                                data-donation-date="${row.donation_date}" data-payment-method="${row.payment_method}"
                                data-status="${row.status}" data-reward-name="${row.reward_name}">수정</button>
                        <button class="delete-button" data-transaction-id="${row.transaction_id}">삭제</button>
                    </td>
                </tr>
            </c:forEach>
        </c:if>
    </table>

    <!-- 페이지 네비게이션 -->
    <%@ include file="../../include/admin_paging.jsp" %>

</body>
</html>
