<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<title>리워드함</title>
    
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
	
	.rewardpage-title {
		position: absolute;
		top:40px; left: 40px;
		display: flex;
		align-items: center;
	}
	
	.rewardpage-title-img {
		margin-left: 50px;
		width: 25px; height: 25px;
	}
	
	.rewardpage-title-text {
		margin-left: 10px;
		font-size: 21px;
		font-weight: bold;
		color: #504848;
	}
	
	.noreward {
	    align-items: center;
	    margin-top: 150px;
	    margin-bottom: 100px;
	}
	
	.noreward p {
		font-size: 19px;
		color: #504848;
	}
	
	.rewardlist {
	    display: flex;
	    flex-direction: column;
	    gap: 40px;
	    align-items: center;
	    margin-top: 110px;
	    margin-bottom: 100px;
	}
	
	/* 기부 날짜 */
	.reward-date {
	    align-self: center;
	    margin-left: 10px;
	    font-size: 17px;
	    color: #6C6C6C;
	    text-align: left;
	}
	
	/* 외곽 박스 */
	.reward-box {
	    width: 802px;
	    height: 191px;
	    border: 1.67px solid #CECECE;
	    border-radius: 16.65px;
	    display: flex;
	    position: relative;
	    transition: border-color 0.3s;
	}
	
	/* 프로젝트 이미지 */
	.reward-project-image {
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
	
	.reward-project-image img {
	    width: 100%;
	    height: 100%;
	    object-fit: cover;
	    transition: filter 0.3s;
	}
	
	.reward-box:hover {
	    border-color: #9C6B4F;
	}
	
	.reward-box:hover .reward-project-image img {
	    filter: brightness(60%);
	}
	
	/* 자세히 보기 버튼 */
	.reward-project-image button {
	    position: absolute;
	    top: 50%;
	    left: 50%;
	    transform: translate(-50%, -50%);
	    background-color: #9C6B4F;
	    border: 1px solid #9C6B4F;
	    padding: 5px;
	    font-size: 17px;
	    width: 116px;
	    color: #FFFFFF;
	    border-radius: 16.65px;
	    transition: opacity 0.3s;
	    display: none;
	}
	
	.reward-box:hover .reward-project-image button {
	    display: block;
	}
	
	/* 중앙 정보 */
	.reward-project-info {
	    display: flex;
	    flex-direction: column;
	    justify-content: center;
	    text-align: left;
	    margin-left: 45px;
	    flex-grow: 1;
	    /* gap: 4px; */
	}
	
	.reward-project-info .location {
		font-weight: bold;
	    color: #2E2E2E;
	    font-size: 19px;
	}
	
	.reward-project-info .project-title {
	    font-weight: bold;
	    color: #2E2E2E;
	    font-size: 21px;
	}
	
	.reward-project-info .reward-name {
	    color: #6C6C6C;
	    font-size: 17px;
	}
	
	/* 오른쪽 상단 날짜 */
	.reward-project-dates {
	    position: absolute;
	    top: 12px;
	    right: 20px;
	    font-size: 17px;
	    color: #6C6C6C;
	}
	
	/* 오른쪽 하단 금액 */
	.reward-project-amount {
	    position: absolute;
	    bottom: 12px;
	    right: 20px;
	    font-size: 21px;
	    font-weight: bold;
	    color: #2E2E2E;
	}
	
	.reward-project-amount span {
	    color: #9C6B4F;
	    font-weight: bold;
	}
	
	.pagination {
		position: absolute;
		text-align: center;
		margin-top: 30px;
		bottom: 15px;
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
</head>

<body>
<%@ include file="../../include/menu.jsp" %>

<div class="container">
	<div class="rectangle">
		<!-- 뒤로가기 버튼 -->
		<button class="back-button" onclick="history.back()"></button>
		
		<div class="rewardpage-title">
			<img class="rewardpage-title-img" src="/resources/suhodan_images/icon/reward.png">
			<span class="rewardpage-title-text">리워드함</span>
		</div>
		
	 	<div class="rewardlist">
				<div class="rewardcard">
					<div class="reward-date">
						<fmt:formatDate value="${dto.donation_date}" pattern="yyyy.MM.dd" />
					</div>
		
		            <div class="reward-box">
		                <div class="reward-project-image">
		                    <img src="../../resources/donation_img/${dto.project_img}" alt="프로젝트 이미지" />
		                </div>
		
		                <div class="reward-project-info">
		                    <div class="location">${dto.location}</div>
		                    <div class="project-title">${dto.project_title}</div>
		                    <div class="reward-name">${dto.reward_name}</div>
		                </div>
		
		                <div class="reward-project-dates">
		                	<fmt:formatDate value="${dto.start_date}" pattern="yyyy.MM.dd" /> ~
										<fmt:formatDate value="${dto.end_date}" pattern="yyyy.MM.dd" />
		                </div>
		                <div class="reward-project-amount">
		                    총 <span>
		                    	<fmt:formatNumber value="${row.amount}" type="number" groupingUsed="true" />
		                     원</span>
		                </div>
		                
		                <div class="reward-project-buttons">
		                	<button class="badge" onclick="location.href='/mypage/mybadges'"></button>
		                	<button class="delivery"></button>
		                </div>
		            </div>
				</div>
		</div>
		
		<!-- 페이지네이션 -->
		<div class="pagination" id="pagination">
			<c:forEach begin="1" end="${totalPage}" var="i">
				<a href="/mypage/myreward?page=${i}" 
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