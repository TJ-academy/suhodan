<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>관리자</title>
</head>
<body>
<%@ include file="../../include/admin_menu.jsp" %>
	<h2>명패 관리</h2>

	<table border="1" width="700px">
		<tr>
			<td>No.</td>
            <td>지역</td>
            <td>연결 설화</td>
            <td>이름</td>
            <td>설명</td>
            <td>이미지</td>
            <td>상태 관리</td>
		</tr>
		<c:if test="${not empty list}">
        <c:forEach var="row" items="${list}">
        	<tr>
        		<td>${row.badge_id}</td>
	            <td>디비에업서여</td>
	            <td>디비에업서여</td>
	            <td>${row.name}</td>
	            <td>${row.description}</td>
	            <td>${row.img}</td>
	            <td>
	            	<button>수정</button>
                    <button>삭제</button>
	            </td>
        	</tr>
        </c:forEach>
        </c:if>
	</table>
	<div>
        <c:forEach var="i" begin="1" end="${totalPage}">
            <c:choose>
                <c:when test="${i == currentPage}">
                    <strong>[${i}]</strong>
                </c:when>
                <c:otherwise>
                    <a href="badge_list.do?page=${i}">[${i}]</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </div>
</body>
</html>