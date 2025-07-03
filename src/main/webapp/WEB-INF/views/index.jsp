<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="include/menu.jsp" %>
	<c:choose>
		<c:when test="${sessionScope.user_id != null}">
			<h2>
				${sessionScope.name} ( ${sessionScope.user_id} )님의 방문을 환영합니다.
			</h2>
		</c:when>
		<c:otherwise>
			<h2>
				환영합니다. 로그인 후 이용가능합니다.
			</h2>
		</c:otherwise>
	</c:choose>
	<!-- 설화 페이지 이동 섹션 -->
	<div>
		<p>사라지는 마을, 잊지 말아야 할 이야기</p>
		<button>자세히 보기</button>
	</div>
	<!-- 기부하기 페이지 이동 섹션 -->
	<div>
		<p>
			할머니의 마지막 이야기, 우리가 잇습니다. 지금, 전설이 사라지기 전에 함께해주세요.
		</p>
		<button>선물하기</button>
	</div>
	<a href="/map">ddd</a>
</body>
</html>
