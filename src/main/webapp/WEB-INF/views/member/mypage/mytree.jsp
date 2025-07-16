<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 수호수</title>
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
		height: 720px;
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
	
	.treepage-title {
		position: absolute;
		top:40px; left: 40px;
		display: flex;
		align-items: center;
	}
	
	.treepage-title-img {
		margin-left: 30px;
		width: 25px; height: 25px;
	}
	
	.treepage-title-text {
		margin-left: 10px;
		font-size: 21px;
		font-weight: bold;
		color: #504848;
	}
	
	.treeimage {
		position: absolute;
		top: 20px; /* 이미지가 사각형 위에서 20px 내려온 위치 */
		left: 50%;
		transform: translateX(-50%);
		width: 801px;
		height: 604px;
	}
  
	.bimg {
		position: relative;
		width: 59px;
		height: 88px;
		cursor: pointer;
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
	
	.badge1, .badge2, .badge3, .badge4, .badge5, .badge6, .badge7, .badge8, .badge9 {
		position: absolute;
	}
	.badge1 { top: 120px; right: 400px; }
	.badge2 { top: 170px; left: 340px; }
	.badge3 { top: 170px; right: 290px; }
	.badge4 { top: 230px; left: 240px; }
	.badge5 { top: 240px; right: 220px; }
	
	.badge6 { top: 280px; left: 317px; }
	.badge7 { top: 330px; left: 199px; }
	.badge8 { top: 320px; right: 170px; }
	.badge9 { top: 390px; left: 300px; }
	/* .badge10 { top: 402px; right: 300px; } */
	
	/* 모달 스타일 */
	.modal {
		background-color: rgba(0, 0, 0, 0.4); /* 반투명 배경 */
		display: none; 
		position: fixed;
		top: 0; left: 0;
		z-index: 999;
		
	}
	
	.modal-content {
		top: 50%; left: 50%;
		transform: translate(-50%, -50%);
		margin: auto;
		width: 488px; height: auto;
		background-color: #F5F1EB;
		border: 1.67px solid #D8C2A6;
		border-radius: 16.65px;
		
	    padding: 20px 40px;
	    
	    position: fixed;
	    text-align: center;
	    align-items:center;
	    display: flex;
		flex-direction: column;
	}
	
	.modal-title {
		color: #9C6B4F;
		margin-top: 30px;
		margin-bottom: 20px;
		font-size: 32px;
		font-weight: bold;
	}
	
	.modal-desc {
	  font-size: 19px;
	  margin-bottom: 30px;
	}
	
	.modal-checkbtn {
	    width: 146.78px; height: 57.46px;
	    text-align: center;
	    margin-bottom: 30px;
	    background-color: #9C6B4F;
		border: 1px solid #9C6B4F;
		border-radius: 16.65px;
	    font-size: 20px;
	    color: #FFFFFF;
	    cursor: pointer;
	}
</style>

<div class="container">
	<div class="rectangle">
		<!-- 뒤로가기 버튼 -->
		<button class="back-button" onclick="location.href='/mypage'"></button>
		
		<div class="treepage-title">
			<img class="treepage-title-img" src="/resources/suhodan_images/icon/tree.png">
			<span class="treepage-title-text">나의 수호수</span>
		</div>
	
	
		<img class="treeimage" src="../../resources/images/설화수 수호수.png" alt="설화수 수호수">
	 	<c:forEach var="row" items="${blist}" varStatus="status">
			<c:if test="${status.index < 9}">
				<div class="badge${status.index + 1}" onclick="openModal('${row.badge_name}', '${row.badge_desc}')">
					<img class="bimg" src="../../resources/badge_img/${row.badge_img}" alt="${row.badge_name}" />
				</div>
			</c:if>
		</c:forEach>
		
		<!-- 페이지네이션 -->
		<div class="pagination" id="pagination">
			<c:forEach begin="1" end="${totalPage}" var="i">
				<a href="/mypage/mytree?page=${i}" 
		       style="color: ${i == currentPage ? '#2E2E2E' : '#939393'};
		       text-decoration: ${i == currentPage ? 'underline' : 'none'}">
					${i}
				</a>
			</c:forEach>
		</div>
	</div>
</div>

<!-- 모달 팝업 -->
<div id="badgeModal" class="modal">
    <div class="modal-content">
        <p id="modalTitle" class="modal-title">명패 보기</p>
        <p id="modalDesc" class="modal-desc">
        	<strong id="badgeName"></strong>의 설화를 보고 기부했던 인증패예요!<br>
        	수호자님의 후원으로<br>
        	<strong id="badgeDesc"></strong>가<br>
        	성공적으로 완수될 수 있었어요!
        </p>
        <button type="button" class="modal-checkbtn" onclick="closeModal()">확인</button>
    </div>
</div>

<script>
    function openModal(badge_name, badge_desc) {
        document.getElementById('badgeName').innerText = badge_name;
        document.getElementById('badgeDesc').innerText = badge_desc;
        document.getElementById('badgeModal').style.display = 'block';
    }

    function closeModal() {
        document.getElementById('badgeModal').style.display = 'none';
    }

    // 바깥 클릭 시 모달 닫기
    window.onclick = function(event) {
        let modal = document.getElementById('badgeModal');
        if (event.target === modal) {
            closeModal();
        }
    }
</script>
</body>
</html>