<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기부내역 상세</title>
</head>
<body>
<%@ include file="../../include/menu.jsp" %>
<c:forEach var="d" items="${detailList}">
    <div>
        <p>📍 지역: ${d.location}</p>
        <p>📝 제목: ${d.title}</p>
        <p>📅 기간: ${d.startDate} ~ ${d.endDate}</p>
        <p>💳 결제수단: ${d.paymentMethod}</p>
        <p>💸 결제금액: <fmt:formatNumber value="${d.amount}" type="currency"/></p>
        <p>🕒 결제일자: <fmt:formatDate value="${d.donationDate}" pattern="yyyy-MM-dd"/></p>
    </div>
    <hr/>
</c:forEach>

</body>
</html>