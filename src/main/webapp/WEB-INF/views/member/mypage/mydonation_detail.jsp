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
		position: relative;
		width: 893px;
		height: auto;
		margin: 47px auto 47px auto;
		text-align: center;
		align-items: center;
	}
	
	.rectangle {
		width: 893px;
		height: auto;
		left: 50%;
		transform: translateX(-50%);
		background-color: #F5F1EB;
		border: 1.67px solid #D8C2A6;
		border-radius: 16.65px;
		position: relative;
		text-align: center;
		align-items: center;
	}
	
	.back-button {
		position: absolute;
		width: 14px; height: 28px;
		border: none;
		cursor: pointer;
		top: 40px; left: 40px;
		margin-top: 1px;
		background: url('/resources/suhodan_images/icon/arrow_right.png') no-repeat center;
		background-size: contain;
		z-index: 10;
		transform: rotate(180deg);
	}
	
	.donationpage-title {
		position: absolute;
		top:40px; left: 40px;
		display: flex;
		align-items: center;
	}
	
	.donationpage-title-img {
		margin-left: 50px;
		width: 25px; height: 25px;
	}
	
	.donationpage-title-text {
		margin-left: 10px;
		font-size: 21px;
		font-weight: bold;
		color: #504848;
	}
	
	.donationpagedetail-card {
	    display: flex;
	    flex-direction: column;
	    gap: 40px;
	    align-items: center;
	    margin-top: 130px;
	    margin-bottom: 100px;
	    margin-left: 45.5px;
	    /* left: 100%;
		transform: translateX(-50%); */
	    width: 802px;
	    height: 455px;
	    border: 1.67px solid #9C6B4F;
	    border-radius: 16.65px;
	}
	
	/* 외곽 박스 */
	.content-main {
	    display: flex;
	    position: relative;
	    /* gap: 15px; */
	}
	
	/* 프로젝트 이미지 */
	.donation-project-image {
	    position: relative;
	    width: 143px;
	    height: 143px;
	    top: 50%;
	    left: 24px;
	    transform: translateY(-50%);
	    border-radius: 15px;
	    overflow: hidden;
	    flex-shrink: 0;
	}
	
	.donation-project-image img {
	    width: 100%;
	    height: 100%;
	    object-fit: cover;
	    transition: filter 0.3s;
	}
	
	/* 중앙 정보 */
	.donation-project-info {
	    display: flex;
	    flex-direction: column;
	    justify-content: center;
	    text-align: left;
	    margin-left: 45px;
	    flex-grow: 1;
	    /* gap: 4px; */
	}
	
	.donation-project-info .location {
		font-weight: bold;
	    color: #2E2E2E;
	    font-size: 19px;
	}
	
	.donation-project-info .project-title {
	    font-weight: bold;
	    color: #2E2E2E;
	    font-size: 21px;
	}
	
	/* 오른쪽 상단 날짜 */
	.donation-project-dates {
	    position: absolute;
	    top: 12px;
	    right: 20px;
	    font-size: 17px;
	    color: #6C6C6C;
	}
	
	/* 오른쪽 하단 금액 */
	.donation-project-amount {
	    position: absolute;
	    bottom: 12px;
	    right: 20px;
	    font-size: 21px;
	    font-weight: bold;
	    color: #2E2E2E;
	}
	
	.donation-project-amount span {
	    color: #9C6B4F;
	    font-weight: bold;
	}

    .content-payment {
      font-size: 14px;
      color: #444;
      margin-top: 10px;
      line-height: 1.6;
    }

    .project-btn {
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

    .project-btn:hover {
      background-color: #a25c3d;
    }
</style>
</head>
<body>
<%@ include file="../../include/menu.jsp" %>
<div class="container">
	<div class="rectangle">
		<!-- 뒤로가기 버튼 -->
		<button class="back-button" onclick="history.back()"></button>
		
		<div class="donationpage-title">
			<img class="donationpage-title-img" src="/resources/suhodan_images/icon/donation.png">
			<span class="donationpage-title-text">기부 내역</span>
		</div>
		
		<div class="donationpagedetail-card">
			<div class="content-main">
				<div class="donation-project-image">
					<img src="/resources/donation_img/${dto.project_img}" alt="프로젝트 이미지">
				</div>

				<div class="donation-project-info">
                	<div class="location">${dto.location}</div>
					<div class="project-title">${dto.project_title}</div>
            	</div>

				<div class="donation-project-dates">
            		<fmt:formatDate value="${dto.start_date}" pattern="yyyy.MM.dd" /> ~
					<fmt:formatDate value="${dto.end_date}" pattern="yyyy.MM.dd" />
            	</div>

				<div class="donation-project-amount">
                	총 <span>
                		<fmt:formatNumber value="${dto.amount}" type="number" groupingUsed="true" /> 원
                 	</span>
             	</div>
			</div>
			<div class="content-payment">
				<span style="font-size:19px; margin-bottom: 20px;">결제 정보</span><br>
				<div style="font-size: 15px; margin: 0 20px;">
					<span>결제 수단</span>
					<span style="float:right;">카카오페이&nbsp;(${dto.payment_method})</span>
				</div>
				<div style="font-size: 15px; margin: 0 20px; margin-bottom: 10px;">
					<span>결제 일자</span>
					<span style="float:right;">
						<fmt:formatDate value="${dto.donation_date}" pattern="yyyy.MM.dd"/>
					</span>
				</div>
				<div style="font-size: 15px; font-weight: bold;">
					<span>총 결제 금액</span>
					<span style="float:right; margin-right: 20px;">
						<fmt:formatNumber value="${dto.amount}" type="currency"/>
					</span>
				</div>
			</div>
			<button class="project-btn" onclick="location.href='/donation/detail/${dto.project_id}'">해당 글 보기</button>
	    </div>
	</div>
</div>
</body>
</html>