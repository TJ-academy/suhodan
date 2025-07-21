<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/admin_menu.css'/>">
<%-- head 태그가 두 번 선언되어 있었으므로 한 번으로 합치고, 필요한 경우 타이틀 등 추가 --%>
<head>
    <meta charset="UTF-8">
    <title>관리자 메뉴</title>
</head>

<nav class="navbar navbar-expand-lg custom-navbar-bg">
    <div class="container-fluid">
        <a class="navbar-brand logo" href="/">
            <img src="../../resources/images/설화수 로고.png" alt="설화수 로고" />
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown"
                aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNavDropdown">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle ${currentCategory != null && currentCategory.equals('admin_member') ? 'active' : ''}"
                       href="#" id="memberDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        회원
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="memberDropdown">
                        <li><a class="dropdown-item" href="/admin/member_list.do">회원 관리</a></li>
                    </ul>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle ${currentCategory != null && currentCategory.equals('admin_legend') ? 'active' : ''}"
                       href="#" id="legendDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        설화
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="legendDropdown">
                        <li><a class="dropdown-item" href="/admin/legend_list.do">설화 관리</a></li>
                    </ul>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle ${currentCategory != null && currentCategory.equals('admin_reward') ? 'active' : ''}"
                       href="#" id="rewardDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        리워드
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="rewardDropdown">
                        <li><a class="dropdown-item" href="/admin/reward_list.do">리워드 관리</a></li>
                    </ul>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle ${currentCategory != null && (currentCategory.equals('admin_goods') || currentCategory.equals('admin_order')) ? 'active' : ''}"
                       href="#" id="goodsDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        상품
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="goodsDropdown">
                        <li><a class="dropdown-item" href="/admin/goods_list.do">상품 관리</a></li>
                        <li><a class="dropdown-item" href="/admin/order_list.do">주문내역 관리</a></li>
                    </ul>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle ${currentCategory != null && (currentCategory.equals('admin_badge') || currentCategory.equals('admin_user_badge')) ? 'active' : ''}"
                       href="#" id="badgeDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        명패
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="badgeDropdown">
                        <li><a class="dropdown-item" href="/admin/badge_list.do">명패 관리</a></li>
                        <li><a class="dropdown-item" href="/admin/user_badge_list.do">명패 획득 관리</a></li>
                    </ul>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle ${currentCategory != null && (currentCategory.equals('admin_donation') || currentCategory.equals('admin_donation_contents')) ? 'active' : ''}"
                       href="#" id="donationDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        기부
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="donationDropdown">
                        <li><a class="dropdown-item" href="/admin/donation_contents_list.do">기부 프로젝트 관리</a></li>
                        <li><a class="dropdown-item" href="/admin/donation_list.do">기부 내역 조회</a></li>
                    </ul>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${currentCategory != null && currentCategory.equals('admin_statistics') ? 'active' : ''}"
                       href="#">통계</a>
                </li>
            </ul>

            <ul class="navbar-nav user-nav-items">
                <c:choose>
                    <c:when test="${sessionScope.user_id == null}">
                        <li class="nav-item">
                            <a class="nav-link" href="login.do">로그인</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="join.do">회원가입</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <a class="nav-link" href="/logout.do">로그아웃</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>