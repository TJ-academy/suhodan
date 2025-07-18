<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: center;
            font-size: 14px;
        }
        th {
            background-color: #f1f1f1;
        }
        button {
            padding: 5px 10px;
            background-color: #5a4e3c;
            color: white;
            border: none;
            border-radius: 4px;
        }
        select {
            padding: 4px;
        }
    </style>
</head>
<body>

<%@ include file="../../include/admin_menu.jsp"%>

<h2>주문내역 관리</h2>
<br>

<table>
    <thead>
        <tr>
            <th>주문번호</th>
            <th>주문자</th>
            <th>주문일</th>
            <th>주문금액</th>
            <th>결제방법</th>
            <th>환불계좌</th>
            <th>배송지</th>
            <th>연락처</th>
            <th>주문상태</th>
            <th>변경</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="row" items="${list}">
            <form method="post" action="/admin/update_status.do">
                <tr>
                    <td>${row.order_id}</td>
                    <td>${row.user_id}</td>
                    <td><fmt:formatDate value="${row.order_date}" pattern="yyyy-MM-dd" /></td>
                    <td><fmt:formatNumber value="${row.order_amount}" pattern="#,###" />원</td>
                    <td>${row.pay_method}</td>
                    <td>${row.refund_bank}&nbsp;${row.refund_account}</td>
                    <td>${row.order_address1}&nbsp;${row.order_address2}</td>
                    <td>${row.phone}</td>
                    <td>
                        <select name="order_status">
                            <option value="결제진행중" ${row.order_status eq '결제진행중' ? 'selected' : ''}>결제진행중</option>
                            <option value="결제완료" ${row.order_status eq '결제완료' ? 'selected' : ''}>결제완료</option>
                            <option value="환불요청" ${row.order_status eq '환불요청' ? 'selected' : ''}>환불요청</option>
                            <option value="환불완료" ${row.order_status eq '환불완료' ? 'selected' : ''}>환불완료</option>
                            <option value="배송준비중" ${row.order_status eq '배송준비중' ? 'selected' : ''}>배송준비중</option>
                            <option value="배송중" ${row.order_status eq '배송중' ? 'selected' : ''}>배송중</option>
                            <option value="배송완료" ${row.order_status eq '배송완료' ? 'selected' : ''}>배송완료</option>
                        </select>
                    </td>
                    <td>
                        <input type="hidden" name="order_id" value="${row.order_id}">
                        <button type="submit" onclick="alert('변경되었습니다.');">변경</button>
                    </td>
                </tr>
            </form>
        </c:forEach>
    </tbody>
</table>

</body>
</html>
