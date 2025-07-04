<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<a href="/" style="display:inline-block; vertical-align:middle; text-align: left;">
  <img src="../resources/images/설화수 로고.png" alt="설화수 로고" style="width:200px; height:auto;" />
</a>
<span style="display:inline-block; vertical-align:middle;">
<a href="/">메인화면</a> |
<a href="/">메인</a> |
<a href="/map">설화 지도</a> |
<a href="/shop/list.do">보따리 상점</a> |
<a href="#">기부하기</a> |
<a href="/mypage">마이페이지</a> |
<a href="/admin/legend_reg">설화추가(작업용/삭제예정)</a>
</span>

<div style="text-align:right;">
	<c:choose>
		<c:when test="${sessionScope.user_id == null}">
			<a href="login.do">로그인</a> |
			<a href="join.do">회원가입</a>
		</c:when>
		<c:otherwise>
			환영합니다, ${sessionScope.name} 님.&nbsp;
			<a href="/logout.do">로그아웃</a>
		</c:otherwise>
	</c:choose>
</div>
<hr>