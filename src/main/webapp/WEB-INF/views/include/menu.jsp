<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<a href="/" style="display:inline-block; vertical-align:middle; text-align: left;">
  <img src="../resources/images/설화수 로고.png" alt="설화수 로고" style="width:200px; height:auto;" />
</a>
<span style="display:inline-block; vertical-align:middle;">
<a href="/">메인화면</a> |
<a href="#">설화 지도</a> |
<a href="#">보따리 상점</a> |
<a href="#">기부하기</a> |
<a href="/mypage">마이페이지</a> |
</span>

<div style="text-align:right;">
	<c:choose>
		<c:when test="${sessionScope.user_id == null}">
			<a href="login.do">로그인</a> |
			<a href="join.do">회원가입</a>
		</c:when>
		<c:otherwise>
<<<<<<< HEAD
			환영합니다, ${sessionScope.name} 님.&nbsp;
			<a href="/logout.do">로그아웃</a>
=======
			${sessionScope.name}님이 로그인중입니다.
			<a href="/logout.do">로그아웃</a> |
>>>>>>> guy
		</c:otherwise>
	</c:choose>
</div>
<hr>