<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기부내역 상세</title>
<style>
    .container {
      width: 893px !important;
      height: auto;
      margin: 0 auto;
      margin-top: 30px !important;
      background-color: #F5F1EB;
      padding: 40px 40px 40px 40px !important;
      border-radius: 15px;
      border: 2px solid #D8C2A6;
      box-shadow: 0 0 10px rgba(0,0,0,0.05);
    }

    .header {
      font-size: 20px;
      font-weight: bold;
      display: flex;
      align-items: center;
      gap: 10px;
      margin-bottom: 20px;
    }

    .card {
      border: 3px solid #9C6B4F !important;
      border-radius: 20px !important; 
      padding: 16px;
      margin-bottom: 20px;
      background-color: #F5F1EB !important;
    }

    .card-simple {
      border: 1px solid #ddd;
      border-radius: 15px;
      padding: 16px;
      background-color: #f9f9f9;
    }

    .card-content {
      display: flex;
      gap: 15px;
    }

    .card-content img {
      width: 90px;
      height: 90px;
      object-fit: cover;
      border-radius: 10px;
    }

    .text-section {
      flex: 1;
    }

    .text-section .location {
      color: #2E2E2E;
      font-size: 19px;
    }

    .text-section .title {
      font-size: 15px;
      margin: 6px 0;
    }

    .text-section .period {
      font-size: 17px;
      color: #888;
      text-align: right;
    }

    .text-section .amount {
      color: #8d4f2c;
      font-weight: bold;
      font-size: 16px;
      margin-top: 10px;
    }

    .payment-info {
      font-size: 14px;
      color: #444;
      margin-top: 10px;
      line-height: 1.6;
    }

    .btn-view {
      width: 146px;
      height: 57px;
      margin-top: 20px !important;
      margin: 0 auto;
      background-color: #9C6B4F;
      color: white;
      padding: 8px 18px;
      border: none;
      border-radius: 20px;
      cursor: pointer;
      font-size: 19px;
    }

    .btn-view:hover {
      background-color: #a25c3d;
    }

	.title {
		display: flex; /* 부트스트랩 d-flex와 유사하지만 커스텀 유지 */
		align-items: center; /* 부트스트랩 align-items-center와 유사 */
		justify-content: space-between; /* 부트스트랩 justify-content-between과 유사 */
		margin-bottom: 20px;
		font-size: 21px !important;
		font-weight: bold;
	}
	
	.con1 img {
		cursor: pointer;
	}
	
	.con2 {
		flex-grow: 1; /* 로고가 남은 공간을 차지하도록 하여 중앙으로 이동 */
		text-align: center; /* 로고 이미지 중앙 정렬 */
	}
	
	.con2 img {
		display: inline-block; /* text-align: center가 작동하도록 */
		width: 120px; /* 로고 크기 조정 */
		height: auto;
	}

	/* '기부 내역' 타이틀 섹션 */
	.donation-title-section {
		display: flex;
		align-items: center;
		margin-top: 10px;
		margin-bottom: 25px; /* 타이틀과 첫 카드 사이 간격 */
	}
	.donation-title-section img {
		width: 24px; /* 아이콘 크기 */
		height: 24px;
		vertical-align: middle;
		margin-right: 8px;
	}
	.donation-title-section span {
		font-size: 20px;
		font-weight: bold;
		color: #504848;
		vertical-align: middle;
	}
	.page_btn {
		width: 60px;
		height: 40px;
		border-radius: 10px;
		border: 1px solid ##908F60;
		background: #908F60;
		color: white;
	}
</style>
</head>
<body>
<%@ include file="../../include/menu.jsp" %>
  <div class="container">
  	<div class="title">
		<div class="con1">
			<a href="/mypage"><img alt="뒤로가기" src="/resources/images/back.png"></a>
			<img src="/resources/suhodan_images/icon/donation.png" alt="기부 아이콘" style="margin-left: 15px;">
			<span style="font-size: 19px;">기부 내역</span>
			
		</div>
		<div style="width: 25px;"></div> 
	</div>  
	<c:forEach var="d" items="${detailList}">
    <div class="card">
      <div class="card-content">
        <img src="/resources/donation_img/${d.filename}" alt="기부 이미지"
        style="width: 143px; height: 143px; overflow: hidden;">
        <div class="text-section">
          <div class="period">
          	<fmt:formatDate value="${d.startDate}" pattern="yyyy.MM.dd"/>
          	~
          	<fmt:formatDate value="${d.endDate}" pattern="yyyy.MM.dd"/>
          </div>
          <div class="location">${d.location}</div>
          <div class="title">${d.title}</div>
          <div class="amount" style="text-align: right; font-size: 21px;">
          	<span style="color: #2E2E2E;">총&nbsp;</span>
          	<fmt:formatNumber value="${d.amount}" type="currency"/>
          </div>
        </div>
      </div>
      <div class="payment-info">
        <span style="font-size:19px; margin-bottom: 20px;">결제 정보</span><br>
        <div style="font-size: 15px; margin: 0 20px;">
        	<span>결제 수단</span>
        	<span style="float:right;">카카오페이&nbsp;(${d.paymentMethod})</span>
        </div>
        <div style="font-size: 15px; margin: 0 20px; margin-bottom: 10px;">
        	<span>결제 일자</span>
        	<span style="float:right;">
        		<fmt:formatDate value="${d.donationDate}" pattern="yyyy.MM.dd"/>
        	</span>
        </div>
        <div style="font-size: 15px; font-weight: bold;">
        	<span>총 결제 금액</span>
        	<span style="float:right; margin-right: 20px;">
        		<fmt:formatNumber value="${d.amount}" type="currency"/>
        	</span>
        </div>
      </div>
      <button class="btn-view" onclick="location.href='/donation/detail/${content_id}'">해당 글 보기</button>
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
	
</body>
</html>