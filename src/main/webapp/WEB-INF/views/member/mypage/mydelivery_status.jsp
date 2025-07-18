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

    <c:choose>
        <c:when test="${empty deldetails}">
            <p>배송 정보가 없습니다.</p>
        </c:when>
        <c:otherwise>
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
                        <td>${item.ORDER_ID}</td>
                        <td>${item.ITEM_ID}</td>
                        <td>${item.PRODUCT_NAME}</td>
                        <td>${item.QUANTITY}</td>
                        <td>${item.UNIT_PRICE}</td>
                        <td>${item.ORDER_DATE}</td>
                        <td>
                            ${item.ORDER_STATUS}
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </c:otherwise>
    </c:choose>

</body>
</html>
