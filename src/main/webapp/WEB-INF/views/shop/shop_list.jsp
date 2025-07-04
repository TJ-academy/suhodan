<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>보따리 상점</title>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<h2>보따리 상점</h2>
<p>모든 수익금은 해당 마을을 지키는 데 사용됩니다.</p>

<div class="shop-container">
	<c:forEach var="row" items="${list}">
		<div class="shop-card">
			<img src="/resources/images/${row.img}" 
				width="100px" height="auto" alt="${row.name}"
				onerror="this.onerror=null; this.src='/resources/images/설화수 로고.png';" />
			<a href="/shop/detail/${row.reward_id}">${row.name}</a>
			<fmt:formatNumber value="${row.price}" pattern="#,###" />원
		</div>
	</c:forEach>
</div>
</body>
</html>