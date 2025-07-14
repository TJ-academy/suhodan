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
		height: 644px;
		background-color: #F5F1EB;
		border: 1.67px solid #D8C2A6;
		border-radius: 16.65px;
		position: relative;
	}
	
	.treeimage {
		position: absolute;
		top: 20px; /* 이미지가 사각형 위에서 20px 내려온 위치 */
		left: 46px; /* 이미지가 사각형 왼쪽에서 46px 떨어진 위치 */
		width: 801px;
		height: 604px;
	}
  
	.bimg {
		position: relative;
		width: 59px;
		height: 88px;
		cursor: pointer;
	}
	
	.badge1, .badge2, .badge3, .badge4, .badge5, .badge6, .badge7 {
		position: absolute;
	}
	
	.badge1 { top: 169px; left: 297px; }
	.badge2 { top: 249px; left: 219px; }
	.badge3 { top: 282px; left: 317px; }
	.badge4 { top: 367px; left: 199px; }
	.badge5 { top: 402px; left: 300px; }
	.badge6 { top: 210px; left: 120px; }
	.badge7 { top: 200px; left: 20px; }
	
	/* 모달 스타일 */
	.modal {
		display: none; 
		position: absolute; 
		z-index: 999;
		top: 50%; left: 50%;
		transform: translate(-50%, -50%);
		margin: auto;
		width: 488px; height: 395px;
		background-color: #F5F1EB;
		border: 1.67px solid #D8C2A6;
		border-radius: 16.65px;
	}
	
	.modal-content {
		background-color: transparent;
		border: 0;
	    padding: 20px;
	    width: 100%; height: 100%;
	    
	    position: relative;
	    text-align: center;
	}
	
	.modal-title {
		color: #9C6B4F;
		margin-bottom: 20px;
		font-size: 32px;
		font-weight: bold;
		margin-top: 40px;
	}
	
	.modal-desc {
	  font-size: 19px;
	}
	
	.modal-checkbtn {
	    position: absolute;
	    width: 146.78px; height: 57.46px;
	    bottom: 50px;
	    left: auto;
	    text-align: center;
	    left: 50%;
	    transform: translateX(-50%);
	    background-color: #9C6B4F;
		border: 1px solid #9C6B4F;
		border-radius: 16.65px;
	    font-size: 20px;
	    color: #FFFFFF;
	    cursor: pointer;
	}
</style>

<div class="container">
	<div class="rectangle"></div>
	<img class="treeimage" src="../../resources/images/설화수 수호수.png" alt="설화수 수호수">
 	<c:forEach var="row" items="${blist}" varStatus="status">
		<c:if test="${status.index < 10}">
			<div class="badge${status.index + 1}" onclick="openModal('${row.badge_name}', '${row.badge_desc}')">
				<img class="bimg" src="../../resources/badge_img/${row.badge_img}" alt="${row.badge_name}" />
			</div>
		</c:if>
	</c:forEach>
	
	<!-- 모달 팝업 -->
	<div id="badgeModal" class="modal">
	    <div class="modal-content">
	        <p id="modalTitle" class="modal-title">명패 보기</p>
	        <p id="modalDesc" class="modal-desc"></p>
	        <button type="button" class="modal-checkbtn" onclick="closeModal()">확인</button>
	    </div>
	</div>
</div>



<script>
    function openModal(badge_name, badge_desc) {
    	const modalTxt = `<strong>${badge_name}</strong>의 설화를 보고 기부했던 인증패예요!<br>
    	    수호자님의 후원으로<br>
    	    <strong>${badge_desc}</strong>가<br>
    	    성공적으로 완수될 수 있었어요!`;
		
        /* document.getElementById('modalTitle').innerText = title; */
        document.getElementById('modalDesc').innerText = modalTxt;
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