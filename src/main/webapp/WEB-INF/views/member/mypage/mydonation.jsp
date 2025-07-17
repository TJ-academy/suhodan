<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기부내역</title>
<link rel="stylesheet" href="/css/mydonation_history.css">
</head>
<body>
<%@ include file="../../include/menu.jsp" %>

<div class="container">
	<div class="rectangle">
		<!-- 뒤로가기 버튼 -->
		<button class="back-button" onclick="location.href='/mypage'"></button>
		
		<div class="donationpage-title">
			<img class="donationpage-title-img" src="/resources/suhodan_images/icon/donation.png">
			<span class="donationpage-title-text">기부 내역</span>
		</div>
		
		<!-- <div class="donationpage-logo">
			<img alt="로고" src="/resources/suhodan_images/logo/logo_no_text.png" width="120" height="auto"> 
		</div> -->
		
		<c:choose>
			<c:when test="${empty dlist}">
				<div class="nodonation">
					<p>기부내역이 없습니다.</p>
				</div>
			</c:when>
			
			<c:otherwise>
				<div class="donationlist">
					<c:forEach var="d" items="${dlist}">
						<div class="donationcard">
							<div class="donation-date">
								<fmt:formatDate value="${d.donation_date}" pattern="yyyy.MM.dd" />
							</div>
							
							<div class="donation-box">
				                <div class="donation-project-image">
				                    <img src="../../resources/donation_img/${d.project_img}" alt="프로젝트 이미지" />
				                    <button class="view-button" onclick="location.href='/mypage/mydonation/${d.transaction_id}'">자세히 보기</button>
				                </div>
				
				                <div class="donation-project-info">
				                    <div class="location">${d.location}</div>
				                    <div class="project-title">${d.project_title}</div>
				                </div>
				
				                <div class="donation-project-dates">
				                	<fmt:formatDate value="${d.start_date}" pattern="yyyy.MM.dd" /> ~
    								<fmt:formatDate value="${d.end_date}" pattern="yyyy.MM.dd" />
				                </div>
				                <div class="donation-project-amount">
				                    총 <span>
				                    	<fmt:formatNumber value="${d.amount}" type="number" groupingUsed="true" /> 원
				                    </span>
				                </div>
				            </div>
						</div>
					</c:forEach>
				</div>
			</c:otherwise>
		</c:choose>
		
		<!-- 페이지네이션 -->
		<div class="pagination" id="pagination">
			<c:forEach begin="1" end="${totalPage}" var="i">
				<a href="/mypage/mydonation?page=${i}" 
		       style="color: ${i == currentPage ? '#2E2E2E' : '#939393'};
		       text-decoration: ${i == currentPage ? 'underline' : 'none'}">
					${i}
				</a>
			</c:forEach>
		</div>
	</div>
</div>
</body>
</html>