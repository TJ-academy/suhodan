<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
<head>
<!-- Link to the external CSS file -->
<head>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/menu.css'/>">
</head>

<!-- Navigation Bar -->
<div class="nav">
	<ul>
		<!-- Logo -->
		<li class="logo"><a href="/"> <img
				src="../../resources/images/설화수 로고.png" alt="설화수 로고" />
		</a></li>

		<!-- Navigation Links -->
		<li class="menu-item"><a href="/admin/member_list.do"
			class="${currentCategory != null && currentCategory.equals('admin_member') ? 'active' : ''}">회원</a>
			<ul class="submenu">
				<li><a href="/admin/member_list.do">회원 관리</a></li>
			</ul></li>
		<li class="menu-item"><a href="/admin/legend_list.do"
			class="${currentCategory != null && currentCategory.equals('admin_legend') ? 'active' : ''}">설화</a>
			<ul class="submenu">
				<li><a href="/admin/legend_list.do">설화 관리</a></li>
			</ul></li>
		<li class="menu-item"><a href="/admin/reward_list.do"
			class="${currentCategory != null && currentCategory.equals('admin_reward') ? 'active' : ''}">리워드</a>
			<ul class="submenu">
				<li><a href="/admin/reward_list.do">리워드 관리</a></li>
			</ul></li>
		<li class="menu-item"><a href="/admin/goods_list.do"
			class="${currentCategory != null && currentCategory.equals('admin_goods') ? 'active' : ''}
			${currentCategory != null && currentCategory.equals('admin_order') ? 'active' : ''}">상품</a>
			<ul class="submenu">
				<li><a href="/admin/goods_list.do">상품 관리</a></li>
				<li><a href="/admin/order_list.do">주문내역 관리</a></li>
			</ul></li>
		<li class="menu-item"><a href="/admin/badge_list.do"
			class="${currentCategory != null && currentCategory.equals('admin_badge') ? 'active' : ''}
			${currentCategory != null && currentCategory.equals('admin_user_badge') ? 'active' : ''}">명패</a>
			<ul class="submenu">
				<li><a href="/admin/badge_list.do">명패 관리</a></li>
				<li><a href="/admin/user_badge_list.do">명패 획득 관리</a></li>
			</ul></li>
		<li class="menu-item"><a href="/admin/donation_contents_list.do"
			class="${currentCategory != null && currentCategory.equals('admin_donation') ? 'active' : ''}
			${currentCategory != null && currentCategory.equals('admin_donation_contents') ? 'active' : ''}">기부</a>
			<ul class="submenu">
				<li><a href="/admin/donation_contents_list.do">기부 프로젝트 관리</a></li>
				<li><a href="/admin/donation_list.do">기부 내역 조회</a></li>
			</ul></li>
		<li class="menu-item"><a href="#"
			class="${currentCategory != null && currentCategory.equals('admin_statistics') ? 'active' : ''}">통계</a>
			</li>

		<!-- User Menu -->
		<li class="user-menu"><c:choose>
				<c:when test="${sessionScope.user_id == null}">
					<a href="login.do">로그인</a>
					<a href="join.do">회원가입</a>
				</c:when>
				<c:otherwise>
        [ ${sessionScope.name}님 ]
        <a href="/logout.do">로그아웃</a>
				</c:otherwise>
			</c:choose></li>
	</ul>
</div>
<br>
