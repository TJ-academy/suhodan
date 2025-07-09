<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
      border: 1px solid #ddd;
      border-radius: 10px;
      overflow: hidden;
      cursor: pointer;
      transition: box-shadow 0.3s;
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
  <div class="card">
    <a href="/donation/detail/${row.content_id}">
      <img src="../../resources/donation_img/${row.filename}" class="card-img-top" alt="썸네일 이미지" />
    </a>
    <div class="card-body" onclick="location.href='/donation/detail/${row.content_id}'">
      <p class="card-text">
        <span><strong>${row.title}</strong></span>
        <span>${row.content}</span>
        <span>
          <fmt:formatDate value="${row.start_date}" pattern="yyyy-MM-dd" /> -
          <fmt:formatDate value="${row.end_date}" pattern="yyyy-MM-dd" />
        </span>
        <!-- 프로그레스바 추가 -->
        <div style="margin-top:10px;">
          <div style="background:#eee; border-radius: 8px; height: 20px; width: 100%; overflow: hidden;">
            <div style="background:#4caf50; height: 100%; width: ${fn:escapeXml((row.donated_amount / row.target_amount) * 100)}%;">
            </div>
          </div>
          <small>
            <fmt:formatNumber value="${row.donated_amount}" /> 원 후원 / 목표 <fmt:formatNumber value="${row.target_amount}" /> 원
          </small>
        </div>
      </p>
    </div>
    <c:if test="${sessionScope.user_id == 'admin'}">
      <button onclick="location.href='/donation/edit/${row.content_id}'">편집</button>
    </c:if>
  </div>
</c:forEach>


    <!-- 페이지네이션 부분 -->
    <div class="container">
      <div class="d-flex justify-content-center my-4">
        <ul class="pagination"
          style="list-style:none; padding:0; display:flex; gap:6px; justify-content:center; margin:20px 0;">
          <!-- 처음 버튼 -->
          <c:if test="${map.page_info.curPage > 1}">
            <li style="margin:0;">
              <a href="javascript:list('1')"
                style="color: white; background-color: #763815; border: 1px solid #ccc; padding: 6px 12px; border-radius: 4px; text-decoration: none; display: inline-block; cursor: pointer; transition: background-color 0.3s ease;">
                처음
              </a>
            </li>
          </c:if>

          <!-- 페이지 번호 반복 -->
          <c:forEach var="num" begin="${map.page_info.blockBegin}" end="${map.page_info.blockEnd}">
            <c:choose>
              <c:when test="${num == map.page_info.curPage}">
                <li style="margin:0;">
                  <span
                    style="color: white; background-color: #006400; font-weight: bold; border: 1px solid #004d00; padding: 6px 12px; border-radius: 4px; display: inline-block; cursor: default;">
                    ${num}
                  </span>
                </li>
              </c:when>
              <c:otherwise>
                <li style="margin:0;">
                  <a href="javascript:list('${num}')"
                    style="color: white; background-color: #9C6B4F; border: 1px solid #ccc; padding: 6px 12px; border-radius: 4px; text-decoration: none; display: inline-block; cursor: pointer; transition: background-color 0.3s ease;">
                    ${num}
                  </a>
                </li>
              </c:otherwise>
            </c:choose>
          </c:forEach>

          <!-- 끝 버튼 -->
          <c:if test="${map.page_info.curPage < map.page_info.totPage}">
            <li style="margin:0;">
              <a href="javascript:list('${map.page_info.nextPage}')"
                style="color: white; background-color: #763815; border: 1px solid #ccc; padding: 6px 12px; border-radius: 4px; text-decoration: none; display: inline-block; cursor: pointer; transition: background-color 0.3s ease;">
                끝
              </a>
            </li>
          </c:if>
        </ul>
      </div>
    </div>

  </div>
</body>

</html>
