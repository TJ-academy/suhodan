<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
에러가 발생해써염 ㅠ_ㅠ

    <h1>문제가 발생했습니다.</h1>
    <p>문제가 발생한 경로: ${pageContext.request.requestURI}</p>
    <p>오류 메시지: ${exception.message}</p>
</body>
</html>