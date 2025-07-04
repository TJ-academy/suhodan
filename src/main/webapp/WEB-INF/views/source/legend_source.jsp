<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>설화출처</title>
</head>
<body>
    <table border="1" width="700px">
        <tr>
            <td>제목</td>
            <td>출처</td>
        </tr>
        <c:forEach var="row" items="${list}">
            <tr>
                <td>${row.title}</td>
                <td>${row.source}</td>
            </tr>
        </c:forEach>
    </table>

</body>
</html>
