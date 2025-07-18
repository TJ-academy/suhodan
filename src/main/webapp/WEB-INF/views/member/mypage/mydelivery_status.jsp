<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>배송 상세정보</title>
</head>
<body>

    <h2>배송 상세 정보</h2>

    <table border="1" width="800px">
        <tr>
            <th>주문번호</th>
            <th>상품번호</th>
            <th>상품명</th>
            <th>수량</th>
            <th>단가</th>
            <th>주문일</th>
            <th>주문상태</th>
        </tr>

        <c:forEach var="item" items="${deldetails}">
            <tr>
                <td>${item.order_id}</td>
                <td>${item.item_id}</td>
                <td>${item.product_name}</td>
                <td>${item.quantity}</td>
                <td><fmt:formatNumber value="${item.unit_price}" pattern="#,###" />원</td>
                <td><fmt:formatDate value="${item.order_date}" pattern="yyyy-MM-dd" /></td>
                <td>${item.order_status}</td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
