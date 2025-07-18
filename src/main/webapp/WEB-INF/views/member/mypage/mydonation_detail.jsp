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
  width: 90%;
  max-width: 900px;
  margin: 120px auto 100px;
  padding: 30px 40px;
  border: 1.67px solid #9C6B4F;
  border-radius: 16.65px;
  background-color: #F5F1EB;
  display: flex;
  flex-direction: column;
  gap: 30px;
  font-family: 'Noto Sans KR', sans-serif;
}

.content-main {
  display: flex;
  gap: 30px;
  align-items: center;
  justify-content: space-between;
  position: relative;
}

.donation-project-image img {
  width: 130px;
  height: 130px;
  border-radius: 12px;
  object-fit: cover;
}

.donation-project-info {
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: center;
  text-align: left;
}

.donation-project-info .location {
  font-size: 19px;
  font-weight: bold;
  color: #2E2E2E;
  margin-bottom: 4px;
   text-align: left;
}

.donation-project-info .project-title {
  font-size: 19px;
  font-weight: bold;
  color: #2E2E2E;
   text-align: left;
}

.donation-project-dates {
  font-size: 14px;
  color: #6C6C6C;
  text-align: right;
  position: absolute;
  right: 0;
  top: 0;
}

.donation-project-amount {
  font-size: 19px;
  font-weight: bold;
  color: #2E2E2E;
  text-align: right;
  position: absolute;
  right: 0;
  bottom: 0;
}

.donation-project-amount span {
  color: #9C6B4F;
}

.content-payment {
  font-size: 15px;
  color: #444;
  line-height: 1.7;
  padding: 0 5px;
  
   
}

.content-payment div {
  display: flex;
  justify-content: space-between;
  margin-bottom: 6px;
  
}

.content-payment .bold {
  font-weight: bold;
  color: #2E2E2E;
}

.project-btn {
  margin: 20px auto 0;
  padding: 12px 30px;
  background-color: #D8C2A6;
  color: #fff;
  font-size: 16px;
  border: none;
  border-radius: 10px;
  cursor: pointer;
}

.project-btn:hover {
  background-color: #9C6B4F;
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
				<div style="font-size: 17px; font-weight: bold;">
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