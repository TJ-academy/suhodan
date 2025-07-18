<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>명패함</title>

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
		height: 553px; max-height: 1209px;
		left: 50%;
		transform: translateX(-50%);
		background-color: #F5F1EB;
		border: 1.67px solid #D8C2A6;
		border-radius: 16.65px;
		position: relative;
	}
	
	.nobadge-rectangle {
		width: 893px;
		height: auto;
		left: 50%;
		transform: translateX(-50%);
		background-color: #F5F1EB;
		border: 1.67px solid #D8C2A6;
		border-radius: 16.65px;
		position: relative;
	}
	
	.back-button {
		position: absolute;
		width: 14px; height: 28px;
		border: none;
		cursor: pointer;
		top: 70px; left: 50px;
		background: url('/resources/images/back.png') no-repeat center;
		background-size: contain;
		z-index: 10;
	}
	
	.badgepage-title {
		position: absolute;
		top:70px; left: 50px;
		display: flex;
		align-items: center;
	}
	
	.badgepage-title-img {
		margin-left: 50px;
		width: 25px; height: 25px;
	}
	
	.badgepage-title-text {
		margin-left: 10px;
		font-size: 21px;
		font-weight: bold;
		color: #504848;
	}
	
	.nobadge {
	    align-items: center;
	    margin-top: 150px;
	    margin-bottom: 100px;
	}
	
	.nobadge p {
		font-size: 19px;
		color: #504848;
	}
	
	.badgepage-expand-btn {
      position: absolute;
      top: 70px;
      right: 50px;
      background-color: #9C6B4F;
      color: white;
      border: none;
      border-radius: 16.65px;
      cursor: pointer;
      font-size: 20px;
      width: 146.78px; height: 57.46px;
    }
    
    .badgepage-cardlist {
    	position: relative;
    	top: 160px;
    	width: 722px; height: auto;
    	margin: 0 auto;
    	display: flex;
		justify-content: flex-start;  /* 좌측 정렬 */
		gap: 34px;
		flex-wrap: nowrap;
		overflow: hidden;
    }
    
    .badgepage-card {
    	width: 218px; height: 294px;
    	flex: 0 0 218px;
		text-align: center;
		border: 1.67px solid #BABABA;
		border-radius: 16.65px;
		background-color: #F5F1EB;
    }
    
	.badgepage-card img {
		position: relative;
		width: 152px;
		height: 196px;
	}
	
	.badgepage-card p {
		font-size: 19px;
		font-weight: bold;
		color: #2E2E2E;
		position: relative;
		top: -20px;
	}
	
	.badgepage-card button {
		background-color: #BABABA;
		color: white;
		border: 1px solid #BABABA;
		border-radius: 16.65px;
		position: relative;
		top: -30px;
		cursor: pointer;
		font-size: 17px;
		width: 116.11px; height: 35.11px;
	}
	
	.badgepage-card:hover {
		border: 1.67px solid #9C6B4F;
	}
	
	.badgepage-card:hover button {
		background-color: #9C6B4F;
		border: 1px solid #9C6B4F;
	}
	
	.nav-buttons {
		position: absolute;
		top: 310px;
		left: 30px;
		width: 833px;
		display: flex;
		justify-content: space-between;
		padding: 0 10px;
		box-sizing: border-box;
	}
	
	.nav-buttons button {
		width: 23px;
		height: 23px;
		background: none;
		border: none;
		cursor: pointer;
		pointer-events: auto; /* 버튼 클릭 가능하게 복원 */
	}
	
	/* 화살표 이미지 적용 */
	.nav-buttons button.right {
		background: url('/resources/images/arrow right.png') no-repeat center;
		background-size: contain;
	}
	
	.nav-buttons button.left {
		background: url('/resources/images/arrow right.png') no-repeat center;
		background-size: contain;
		transform: scaleX(-1); /* 좌우 반전 */
	}
	
	.pagination {
		position: absolute;
		text-align: center;
		/* margin-top: 30px; */
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
	
	.expand {
		display: none;
	}
</style>

</head>
<body>
<%@ include file="../../include/menu.jsp" %>

<div class="container">
	<div class="${empty blist ? 'nobadge-rectangle' : 'rectangle'}">
		<!-- 뒤로가기 버튼 -->
		<button class="back-button" onclick="location.href='/mypage'"></button>
		
		<div class="badgepage-title">
			<img class="badgepage-title-img" src="/resources/suhodan_images/icon/badge.png">
			<span class="badgepage-title-text">명패함</span>
		</div>
		
		<c:choose>
			<c:when test="${empty blist}">
				<div class="nobadge">
					<p>리워드함이 비어있습니다.</p>
				</div>
			</c:when>
				
			<c:otherwise>
				<button class="badgepage-expand-btn" onclick="toggleView()">펼쳐서 보기</button>
				
				<!-- 넘겨서 본 버전(기본) -->
				<div id="noexpand" class="noexpand">
					<div id="badgeListNoExpand" class="badgepage-cardlist">
					 	<c:forEach var="row" items="${blist}" varStatus="status">
					 		<div class="badgepage-card">
						 		<img src="../../resources/badge_img/${row.badge_img}" alt="${row.badge_name}" />
						 		<p>${row.badge_name}</p>
						 		<button onclick="location.href='/mypage/mybadges/${row.userbadge_id}'">자세히 보기</button>
						 	</div>
						</c:forEach>
					</div>
					
					<!-- 넘기기 버튼 -->
					<div class="nav-buttons" id="navButtons">
						<button class="left" onclick="scrollBadges('left')"></button>
						<button class="right" onclick="scrollBadges('right')"></button>
					</div>
				</div>
				
				<!-- 펼쳐서 본 버전 -->
				<div id="expand" class="expand">
					<div id="badgeListExpand" class="badgepage-cardlist">
					 	<c:forEach var="ex" items="${paged}" varStatus="status">
					 		<div class="badgepage-card">
						 		<img src="../../resources/badge_img/${ex.badge_img}" alt="${ex.badge_name}" />
						 		<p>${ex.badge_name}</p>
						 		<button onclick="location.href='/mypage/mybadges/${ex.userbadge_id}'">자세히 보기</button>
						 	</div>
						</c:forEach>
					</div>
					
					<!-- 페이지네이션 -->
					<div class="pagination" id="pagination">
						<c:forEach begin="1" end="${totalPage}" var="i">
							<a href="/mypage/mybadges?page=${i}&view=expand" 
					       style="color: ${i == currentPage ? '#2E2E2E' : '#939393'};
					       text-decoration: ${i == currentPage ? 'underline' : 'none'}">
								${i}
							</a>
						</c:forEach>
					</div>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
</div>


<script>
  let expanded = false;
  
	window.addEventListener('DOMContentLoaded', () => {
		const params = new URLSearchParams(window.location.search);
		if (params.get("view") === "expand") {
			document.querySelector('.badgepage-expand-btn').innerText = '넘겨서 보기';
			toggleView(); // 자동으로 펼침
		}
	});

  function toggleView() {
	const badgeListNoExpand = document.getElementById('badgeListNoExpand');
	const badgeListExpand = document.getElementById('badgeListExpand');
    
    const noexpand = document.getElementById('noexpand');
    const expand = document.getElementById('expand');
    
    const btn = document.querySelector('.badgepage-expand-btn');
    const rect = document.querySelector('.rectangle');
    const badgeCount = document.querySelectorAll('.badgepage-card').length;

    expanded = !expanded;

    if (expanded) {
    	btn.innerText = '넘겨서 보기';
    	
    	noexpand.style.display='none';
		expand.style.display='block';
		
		badgeListExpand.style.flexWrap = 'wrap';
		badgeListExpand.style.height = 'auto';
		badgeListExpand.style.paddingBottom = '30px';
		
		const originHeight = 553;
		const rowHeight = 328;
		const rows = Math.floor(badgeCount / 3);
		
		rect.style.height = (originHeight + rows * rowHeight) + 'px';
    } else {
    	btn.innerText = '펼쳐서 보기';
    	
    	noexpand.style.display = 'block';
        expand.style.display = 'none';
        
    	badgeListNoExpand.style.height = '350px';
    	badgeListNoExpand.style.flexWrap = 'nowrap';
		
		rect.style.height = '553px';
		badgeListNoExpand.scrollLeft = 0;
    }
  }

  function scrollBadges(direction) {
    const list = document.getElementById('badgeListNoExpand');
    const scrollAmount = 252;

    if (direction === 'left') {
      list.scrollLeft -= scrollAmount;
    } else {
      list.scrollLeft += scrollAmount;
    }
  }
</script>
</body>
</html>