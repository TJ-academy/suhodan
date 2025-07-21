<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>기부 목록</title>
  <script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>

  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
    }

    h2 {
      margin: 20px;
    }

    #btnAdd {
      margin: 20px;
      padding: 8px 16px;
      background-color: #2c7be5;
      color: white;
      border: none;
      border-radius: 5px;
      cursor: pointer;
    }

    .card-container {
      display: flex;
      flex-wrap: wrap;
      gap: 20px;
      justify-content: space-between;
      padding: 0 20px;
    }

    .card {
      flex: 1 0 calc(25% - 20px);
      box-sizing: border-box;
  border: 1px solid #D8C2A6 !important;
  border-radius: 16px !important;
  overflow: hidden !important;
      cursor: pointer;
    }

    .card:hover {
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }

    .card img {
      width: 100%;
      height: 180px;
      object-fit: cover;
      
    }

    .card-body {
      padding: 15px;
    }

    .card-text span {
      display: block;
      margin-bottom: 5px;
    }
    
    .pagination {
	position: relative;
	text-align: center;
	justify-content: center;
	margin: 20px auto;
	bottom: 0px;
	left: 50%;
	transform: translate(-50%, -50%);
	display: flex;
}
.pagination a {
	justify-content: center;
	margin: 0 5px;
	padding: 6px 12px;
	background-color: 'transparent';
	text-decoration: none;
	text-underline-offset: 4px;
	text-underline-color: #2E2E2E;
}
  </style>

  <script>
    $(function() {
      $("#btnAdd").click(function() {
        location.href = "/donation/write.do";
      });
    });

    function list(page) {
      location.href = "/donation/list.do?curPage=" + page;
    }
  </script>
</head>

<body>
  <%@ include file="../include/menu.jsp" %>

  <c:if test="${sessionScope.user_id == 'admin'}">
    <button type="button" id="btnAdd">글작성</button>
  </c:if>

  <div class="card-container" style="margin-top: 20px;">
    <c:forEach var="row" items="${list}">
    <c:set var="rawPercent" value="${row.target_amount > 0 ? (row.donated_amount * 100) / row.target_amount : 0}" />
<c:set var="progressPercent" value="${rawPercent > 100 ? 100 : rawPercent}" />

    
  <div class="card">
    <a href="/donation/detail/${row.content_id}">
      <img src="../../resources/donation_img/${row.filename}" class="card-img-top" alt="썸네일 이미지" />
    </a>
    <div class="card-body" onclick="location.href='/donation/detail/${row.content_id}'"
    style="border-color: #D8C2A6;">
      <p class="card-text">
        <span style="font-size: 19px; text-align:center;">
	        <strong>${row.location}</strong>
        </span>
        <span style="text-align:center; color: #504848; font-size: 13px;">${row.title}</span>
        <!-- 프로그레스바 추가 -->
        <div style="margin-top:10px;">
          <span style="color: #4C6B3C; font-weight: bold;">
	          <fmt:formatNumber value="${progressPercent}" maxFractionDigits="0" />%
          </span>
          <span style="float:right; font-size:12px; font-weight: bold;">${row.dday}일 남음</span>
          <div style="background:#eee; border-radius: 8px; height: 20px; width: 100%; overflow: hidden;">
            <div style="background:#7A9D54; height: 100%; width: ${fn:escapeXml((row.donated_amount / row.target_amount) * 100)}%;">
            </div>
          </div>
        </div>
      </p>
    </div>
    <c:if test="${sessionScope.user_id == 'admin'}">
      <button onclick="location.href='/donation/edit/${row.content_id}'">편집</button>
    </c:if>
  </div>
</c:forEach>


   <div class="container">
<!-- 페이지네이션 -->
<div class="pagination">
  <c:forEach begin="1" end="${map.page_info.totPage}" var="i">
    <a href="/donation/list.do?curPage=${i}&category=${category}&keyword=${keyword}&sort=${sort}"
       style="color: ${i == map.page_info.curPage ? '#2E2E2E' : '#939393'};
              text-decoration: ${i == map.page_info.curPage ? 'underline' : 'none'};
              text-underline-offset: 4px;
              margin: 0 6px;">
      ${i}
    </a>
  </c:forEach>
</div>


  </div>
</body>

</html>
