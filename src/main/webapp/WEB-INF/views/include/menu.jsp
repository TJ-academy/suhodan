<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- Bootstrap CSS 및 JS 추가 --%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>

<%-- 사용자 정의 CSS 파일 (필요한 경우만) --%>
<link rel="stylesheet" href="/css/menu.css">

<nav class="navbar navbar-expand-lg navbar-light custom-navbar-bg">
    <div class="container-fluid">
        <%-- 로고 --%>
        <a class="navbar-brand logo" href="/">
            <img src="../../resources/images/설화수 로고.png" alt="설화수 로고" />
        </a>

        <%-- 햄버거 토글 버튼 (모바일에서만 보임) --%>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <%-- 메뉴 항목들 --%>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <%-- 주 메뉴 항목 --%>
                <li class="nav-item">
                    <a class="nav-link ${currentCategory != null && currentCategory.equals('map') ? 'active' : ''}" href="/map">설화 지도</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${currentCategory != null && currentCategory.equals('shop') ? 'active' : ''}" href="/shop/list.do">보따리 상점</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${currentCategory != null && currentCategory.equals('donation') ? 'active' : ''}" href="/donation/list.do">기부하기</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${currentCategory != null && currentCategory.equals('mypage') ? 'active' : ''}" href="/mypage">마이페이지</a>
                </li>
                <%-- 드롭다운 메뉴 예시 (필요하다면)
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        더 보기
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="#">서브 메뉴 1</a></li>
                        <li><a class="dropdown-item" href="#">서브 메뉴 2</a></li>
                    </ul>
                </li>
                --%>
            </ul>

            <%-- 사용자 메뉴 항목 (오른쪽에 정렬) --%>
            <ul class="navbar-nav user-nav-items">
                <c:choose>
                    <c:when test="${sessionScope.user_id == null}">
                        <li class="nav-item">
                            <a class="nav-link" href="/login.do">로그인</a>
                        </li>
                    </c:when>
                    <c:when test="${sessionScope.user_id == 'admin'}">
                        <li class="nav-item">
                            <a class="nav-link" href="/admin/">관리자 기능</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/logout.do">로그아웃</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${fn:contains(pageContext.request.requestURI, '/shop')}">
                            <li class="nav-item">
                                <a class="nav-link" href="/shop/cart/list.do">장바구니</a>
                            </li>
                        </c:if>
                        <li class="nav-item">
                            <a class="nav-link" href="/mypage" style="margin: 0;">${sessionScope.name}님</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/logout.do">로그아웃</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>