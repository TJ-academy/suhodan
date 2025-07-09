<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<head>
<!-- Link to the external CSS file -->
<link rel="stylesheet" type="text/css" href="../css/menu.css">
</head>

<!-- Navigation Bar -->
<div class="nav">
	<ul>
		<!-- Logo -->
		<li class="logo"><a href="/"> <img
				src="../../resources/images/설화수 로고.png" alt="설화수 로고" />
		</a></li>

		<!-- Navigation Links -->
		<li class="menu-item"><a href="/admin/member_list.do">회원 관리</a></li>
		<li class="menu-item"><a href="/admin/legend_list.do">설화 관리</a></li>
		<li class="menu-item"><a href="/admin/reward_list.do">리워드 관리</a></li>
		<li class="menu-item"><a href="/admin/goods_list.do">굿즈 관리</a></li>
		<li class="menu-item"><a href="/admin/badge_list.do">명패 관리</a></li>
		<li class="menu-item"><a href="#">통계 관리</a></li>

		<!-- User Menu -->
		<li class="user-menu"><c:choose>
				<c:when test="${sessionScope.user_id == null}">
					<a href="login.do">로그인</a> |
        <a href="join.do">회원가입</a>
				</c:when>
				<c:otherwise>
        ${sessionScope.name}님이 로그인중입니다.
        <a href="/logout.do">로그아웃</a> |
      </c:otherwise>
			</c:choose></li>
	</ul>
</div>