<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@include file="../include/menu.jsp" %>
	<table>
		<tr>
			<td>${dto.title}</td>
		</tr>
		<tr>
			<td>
				<p>${dto.story}</p>
			</td>
		</tr>
	</table>
</body>
</html>