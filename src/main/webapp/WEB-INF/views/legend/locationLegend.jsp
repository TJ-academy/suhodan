<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>설화</title>
</head>
<body>
<%@include file="../include/menu.jsp" %>
<h2>${location}의 설화</h2>
    <table border="1" width="700px">
        <tr>
            <td>No.</td>
            <td>지역</td>
            <td>제목</td>
        </tr>
        <c:forEach var="row" items="${list}">
            <tr>
                <td>${row.legend_id}</td>
                <td>${row.location}</td>
                <td>
                	<a href="/legend/detail/${row.legend_id}">
                		${row.title}
                	</a>
                </td>
            </tr>
        </c:forEach>
    </table>

</body>
</html>
