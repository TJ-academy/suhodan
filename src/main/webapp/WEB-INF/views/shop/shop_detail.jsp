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
<h2>상품정보</h2>
<table>
	<tr>
		<td><img src="/resources/images/${dto.img}" width="300px" height="300px"></td>
		<td align="center">
			<table>
				<tr>
					<td>상품명</td>
					<td>${dto.name}</td>
				</tr>
				<tr>
					<td>가격</td>
					<td><fmt:formatNumber value="${row.price}" pattern="#,###" /></td>
				</tr>
				<tr>
					<td>상품 설명</td>
					<td>${dto.description}</td>
				</tr>
				<tr>
					<td colspan="2">
						<form name="form1" method="post" action="/shop/cart/insert.do">
							<input type="hidden" name="reward_id" value="${dto.reward_id}">
							<select name="amount">
								<c:forEach begin="1" end="10" var="i">
									<option value="${i}">${i}</option>
								</c:forEach>
							</select> 개
							<input type="submit" value="장바구니">
						</form>
						<a href="/shop/list.do">보따리 상점</a>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</body>
</html>