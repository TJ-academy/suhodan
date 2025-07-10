<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>명패함</title>
</head>
<body>
<%@ include file="../../include/menu.jsp" %>

<style>
	.container {
		position: relative;
		width: 893px;
		height: 644px;
		margin: 47px auto 47px auto;
		position: relative;
	}
	
	.rectangle {
		width: 893px;
		height: 644px;
		background-color: #F5F1EB;
		border: 1.67px solid #D8C2A6;
		border-radius: 16.65px;
		position: relative;
	}
	
	.back-button {
		width: 14px; height: 28px;
		border: none;
		/* background-color: transparent; */
		cursor: pointer;
		margin-top: 50px;
		margin-left: 50px;
	}
	
	.badgepage-title {
		position: absolute;
		top:50px; left: 50px; 
	}
	
	.badgepage-title-img {
		margin-left: 50px;
		margin-bottom: 5px;
		width: 25px; height: 25px;
	}
	
	.badgepage-title-text {
		margin-left: 10px;
		font-size: 21px;
		font-weight: bold;
		color: #504848;
	}
	
	.expand-btn {
      position: absolute;
      top: 20px;
      right: 20px;
      background-color: #9C6B4F;
      color: white;
      border: none;
      border-radius: 16.65px;
      cursor: pointer;
      font-size: 20px;
      width: 146.78px; height: 57.46px;
    }
    
    
	.bimg {
		position: relative;
		width: 59px;
		height: 88px;
		cursor: pointer;
	}
</style>

<div class="container">
	<div class="rectangle">
		<!-- 뒤로가기 버튼 -->
		<button class="back-button" onclick="location.href='/mypage'">
			<img src="/resources/images/back.png" alt="뒤로가기 아이콘">
		</button>
		
		<div class="badgepage-title">
			<img class="badgepage-title-img" src="/resources/suhodan_images/icon/badge.png">
			<span class="badgepage-title-text">명패함</span>
		</div>
		
		<button class="expand-btn" onclick="toggleView()">펼쳐서 보기</button>
		
		<!-- 배지 카드 리스트 -->
		<div id="badgeList" class="badgepage-list">
		 	<c:forEach var="row" items="${blist}" varStatus="status">
		 		<img class="bimg" src="../../resources/badge_img/${row.badge_img}" alt="${row.badge_name}" />
		 		<p>${row.badge_name}</p>
		 		<button type="button">자세히 보기</button>
			</c:forEach>
		</div>
		
		<!-- 넘기기 버튼 -->
		<div class="nav-buttons" id="navButtons">
			<button onclick="scrollBadges('left')">&lt;</button>
			<button onclick="scrollBadges('right')">&gt;</button>
		</div>
	</div>
</div>


<script>
  let expanded = false;

  function toggleView() {
    const badgeList = document.getElementById('badgeList');
    const navBtns = document.getElementById('navButtons');
    const btn = document.querySelector('.expand-btn');

    expanded = !expanded;

    if (expanded) {
      badgeList.style.flexWrap = 'wrap';
      navBtns.style.display = 'none';
      btn.innerText = '넘겨서 보기';
    } else {
      badgeList.style.flexWrap = 'nowrap';
      navBtns.style.display = 'flex';
      btn.innerText = '펼쳐서 보기';
    }
  }

  function scrollBadges(direction) {
    const list = document.getElementById('badgeList');
    const scrollAmount = list.clientWidth;

    if (direction === 'left') {
      list.scrollLeft -= scrollAmount;
    } else {
      list.scrollLeft += scrollAmount;
    }
  }
</script>
</body>
</html>