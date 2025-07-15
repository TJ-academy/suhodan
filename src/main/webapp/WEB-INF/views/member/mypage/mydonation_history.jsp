<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기부내역</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/css/mydonation_history.css">
</head>
<body>
<%@ include file="../../include/menu.jsp" %>

<div class="dona_con">
	<div class="title">
		<div class="con1">
			<a href="/mypage"><img alt="뒤로가기" src="/resources/images/back.png"></a>
		</div>
		<div class="con2">
			<img alt="로고" src="/resources/suhodan_images/logo/logo_no_text.png" width="120" height="auto"> 
		</div>
		<div style="width: 25px;"></div> 
	</div>
	<div class="donation-title-section">
		<img src="/resources/suhodan_images/icon/donation.png" alt="기부 아이콘">
		<span>기부 내역</span>
	</div>

	<c:forEach var="d" items="${dlist}">
	<div class="card-custom d-flex"> 
		<div class="card-image-wrapper me-4"> 
			<img src="/resources/donation_img/${d.filename}" alt="기부 이미지">
			<button class="view-details-btn"
			onclick="location.href='/mypage/mydonation/${d.content_id}'">자세히 보기</button>
		</div>
		
		<div class="d-flex flex-column justify-content-between flex-grow-1"> 
			<div class="d-flex justify-content-end">
				<p class="card-header-meta"><fmt:formatDate value="${d.donationDate}" pattern="yyyy-MM-dd"/></p>
			</div>
			
			<div class="d-flex flex-column align-items-start my-auto">
				<p class="location mb-1">${d.location}</p>
				<p class="project-title mb-0">${d.title}</p>
			</div>
			
			<div class="d-flex justify-content-end mt-auto"> 
				<span class="total-amount"><span style="color:#2E2E2E;">총</span> <fmt:formatNumber value="${d.amount}" type="currency"/></span>
			</div>
		</div>
	</div>
	</c:forEach>
	  <!-- 페이징 버튼 -->
	  <div style="text-align: center; margin-top: 20px;">
	    <c:if test="${currentPage > 1}">
	      <button onclick="location.href='?page=${currentPage - 1}'" class="page_btn">이전</button>
	    </c:if>	
	    <c:if test="${currentPage < totalPage}">
	      <button onclick="location.href='?page=${currentPage + 1}'" class="page_btn">다음</button>
	    </c:if>
	  </div>
	
</div>
</body>
</html>