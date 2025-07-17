<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>내 주문 목록</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        h1 { color: #333; }
        .order_con {
            width: 841px;
            background: #F5F1EB;
            border-radius: 20px;
            margin: 20px auto 0 auto;
            border: 2px solid #D8C2A6;
            padding: 20px;
        }
        .order-group {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 25px;
            background-color: #fcfcfc;
            box-shadow: 2px 2px 8px rgba(0,0,0,0.1);
        }
        .order-header {
            background-color: #e6f7ff;
            padding: 10px 15px;
            margin: -15px -15px 15px -15px;
            border-top-left-radius: 8px;
            border-top-right-radius: 8px;
            font-size: 1.1em;
            font-weight: bold;
            color: #336699;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .order-header span {
            font-weight: normal;
            font-size: 0.9em;
            color: #555;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        th, td {
            border: 1px solid #eee;
            padding: 10px;
            text-align: left;
            vertical-align: top;
        }
        th {
            background-color: #f2f2f2;
            color: #333;
        }
        td {
            background-color: #fff;
        }
    </style>
</head>
<body>
<%@ include file="../../include/menu.jsp" %>

<div class="order_con">
    <c:choose>
        <c:when test="${not empty orders}">
            <c:set var="prevOrderId" value="-1" />

            <c:forEach var="orderItem" items="${orders}" varStatus="status">
                <c:if test="${orderItem.ORDER_ID != prevOrderId}">
                    <c:if test="${prevOrderId != -1}">
                        </tbody>
                        </table>
                        </div>
                    </c:if>

                    <div class="order-group">
                        <div class="order-header">
                            <div>주문 번호: ${orderItem.ORDER_ID}</div>
                            <span>
                                ${orderItem.PAY_METHOD} |
                                <strong style="color: ${orderItem.ORDER_STATUS eq '결제진행중' ? '#ff9800' : '#4CAF50'};">
                                    ${orderItem.ORDER_STATUS}
                                </strong>
                            </span>
                        </div>
                        <table>
                            <thead>
                                <tr>
                                	<th>이미지</th>
                                    <th>상품명</th>
                                    <th>수량</th>
                                    <th>단가</th>
                                    <th>총 가격</th>
                                </tr>
                            </thead>
                            <tbody>
                </c:if>
                <tr>
                	<td><img src="/resources/goods_img/${orderItem.IMG}" width="50"></td>
                    <td>${orderItem.PRODUCT_NAME}</td>
                    <td>${orderItem.QUANTITY}</td>
                    <td>${orderItem.UNIT_PRICE}</td>
                    <td>${orderItem.QUANTITY * orderItem.UNIT_PRICE}</td>
                </tr>

                <c:set var="prevOrderId" value="${orderItem.ORDER_ID}" />

                <c:if test="${status.last}">
                        </tbody>
                        </table>
                    </div>
                </c:if>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <p>아직 주문 내역이 없어요! 😢 다시 주문해주떼염!</p>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>