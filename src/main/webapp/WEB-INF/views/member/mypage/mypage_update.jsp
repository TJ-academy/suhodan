<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>개인 정보 수정</title>
    <!-- <link rel="stylesheet" href="/css/mypage.css" /> -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    
    <style>
	    .mypage-container {
	        width: 500px;
	        margin: 47px auto;
	        padding: 30px 40px;
	        background-color: #F5F1EB;
			border: 1.67px solid #D8C2A6;
			border-radius: 16.65px;
	        text-align: center;
	    }
	    
		.mypage-container .title {
			align-items: center;
			display: flex;
			gap: 10px;
			margin-bottom: 20px;
			margin-top: 10px;
		}
		
		.back-icon {
			width: 14px; height: 28px;
			border: none;
			cursor: pointer;
			margin-right: 10px;
			background: url('/resources/suhodan_images/icon/arrow_right.png') no-repeat center;
			background-size: contain;
			z-index: 10;
			transform: rotate(180deg);
		}
		
		.mypage-container .title-text {
			font-size: 21px;
			font-weight: bold;
			color: #504848;
		}
		
		.form-row {
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		    margin-left: 20px;
		    margin-right: 20px;
		    padding: 10px 10px;
		    font-size: 18px;
		    color: #504848;
		    border-bottom: 1px solid #BABABA;
		}
		
		.form-row input[type="text"] {
			width: 214px;
			padding: 4px 10px;
			border: 1px solid #CFCFCF;
		    border-radius: 5px;
		    background-color:#FFFFFF;
		}
		.form-row input[type="date"] {
		    width: 214px;
		    padding: 4px 10px;
		    border: 1px solid #CFCFCF;
		    border-radius: 5px;
		    background-color:#FFFFFF;
		}
		
		.form-row input[type="radio"] {
		    margin-left: 20px;
		}
		
		.form-row span label {
			margin-left: 2px;
		}
		
		.form-row a img {
		    height: 20px;
		    margin-right: 10px;
		}
		
		.buttons {
		    text-align: center;
		    margin-top: 28px;
		}
		
		.save-btn {
		    background-color: #936f4d;
		    color: white;
		    border: none;
		    padding: 8px 24px;
		    border-radius: 16.65px;
		    font-size: 18px;
		    cursor: pointer;
		}
		
		.withdraw-btn {
		    background: none;
		    border: none;
		    color: #504848;
		    font-size: 15px;
		    margin-top: 12px;
		    cursor: pointer;
		    text-decoration: none;
		}
		
		.save-btn:hover {
		    background-color: #7d5e3f;
		}
		
		.withdraw-btn:hover {
		    color: #333;
		    text-decoration: underline;
		}

		
		.modal {
			display: none; /* 기본은 숨김 */
		    position: fixed;
		    top: 0; left: 0;
		    background-color: rgba(0, 0, 0, 0.4); /* 반투명 배경 */
    		z-index: 998;
		}
		
		.modal-content {
			position: fixed; 
			z-index: 999;
			top: 50%; left: 50%;
			transform: translate(-50%, -50%);
			width: 500px !important; height: auto;
			background-color: #F5F1EB !important;
			border: 1.67px solid #D8C2A6;
			border-radius: 16.65px;
			padding: 20px;
		}
		
		.modal-header {
			align-items: center;
			text-align: center;
			display: flex;
			gap: 10px;
			margin-bottom: 20px;
			margin-top: 10px;
			border-bottom: 1px solid #BABABA !important;
		}
		
		.modal-header h4 {
			font-size: 21px;
			font-weight: bold;
			color: #504848;
			margin-bottom: -0.5px;
		}
		
		/* 모달에서 입력 필드 스타일 */
		.modal-content input {
		    width: 440px; height: 46px;
		    padding: 4px 10px;
			border: 1px solid #C4C4C4;
		    border-radius: 16.65px;
		    background-color:#FFFFFF;
		    font-size: 18px;
		    margin-bottom: 16px;
		    margin-left: 10px;
		    margin-right: 10px;
		}
		
		.modal-content input:focus {
			border: 1px solid #9C6B4F;
			outline: none;
		}
		
		.pswd-input input {
			width: 420px; height: 46px;
			margin-left: 20px;
		    margin-right: 20px;
		}
		
		/* 확인버튼 */
		.modal-content .modal-buttons {
		    text-align: center;
		    margin-top: 20px;
		    margin-bottom: 20px;
		}
		
		.modal-content .modal-buttons button {
		    width: 146.78px;
		    padding: 12px;
		    background-color: #D8C2A6;
		    color: white;
		    border: 1px solid #9C6B4F;
		    font-size: 18px;
		    border-radius: 16.65px;
		    cursor: pointer;
		}
		
		.modal-content .modal-buttons button:hover {
		    background-color: #9C6B4F;
		}
		
		/* 주소 수정 버튼 */
		.modal-content .address-wrapper {
		    display: flex;
		    /* justify-content: space-between; */
		    align-items: center;
		    margin-bottom: 16px;
		}
		
		.address-wrapper input[type="text"] {
		    width: 290px;
		    /* flex-grow: 1; */
		    /* margin-right: 10px;
		    padding: 12px; */
		    /* width: 37px; height: 46px;
		    font-size: 14px;
		    width: 337px; height: 46px;
		    border-radius: 8px;
		    border: 1px solid #ccc;
		    background-color: #fff; */
		}
		
		/* 우편번호 검색 버튼 */
		.address-wrapper .postcode-btn {
			width: 140px; height: 46px;
		    background-color: #939393;
		    color: white;
		    font-size: 18px;
		    padding: 10px;
		    border-radius: 18px;
		    border: none;
		    cursor: pointer;
		    margin-top: -15px;
		    /* transition: background-color 0.3s; */
		}
		
		.postcode-btn:hover {
		    background-color: #636363;
		}
		
		.message {
			color: #E64B4E;
			margin-top: -5px;
			margin-bottom: -5px;
			text-align: center;
		}
		
		.result-message {
			color: #E64B4E;
			font-size: 15px;
			margin-top: -5px;
			margin-bottom: -10px;
		}
	</style>
</head>

<body>
<%@ include file="../../include/menu.jsp" %>

<div class="mypage-container">
    <div align="left" class=title>
    	<!-- 뒤로가기 버튼 -->
		<button class="back-icon" onclick="location.href='/mypage'"></button>
		<!-- <span class="back-icon" onclick="location.href='/mypage'">
		    <img src="/resources/suhodan_images/icon/arrow_right.png" class="flip-icon" alt="뒤로가기" />
		</span> -->
		<img src="/resources/suhodan_images/icon/edit.png" alt="수정 아이콘">
		<span class="title-text">개인 정보 수정</span>
    </div>

    <form name="form1" method="post" action="/mypage/update.do">
        <div class="form-row">
            <label>이름</label>
            <input type="text" name="name" value="${dto.name}" />
        </div>
        <div class="form-row">
            <label>아이디</label>
            <span>${dto.user_id}</span>
            <input type="hidden" name="user_id" value="${dto.user_id}" />
        </div>
        <div class="form-row">
            <label>비밀번호 재설정</label>
            <p class="result-message">
		    	<c:if test="${not empty message}">
					<c:out value="${message}" escapeXml="false"/>
				</c:if>
				<c:if test="${empty message}">
					&nbsp;
				</c:if>
		    </p>
            <a href="javascript:void(0);" onclick="openResetPasswordModal()">
                <img src="/resources/suhodan_images/icon/arrow_right.png" alt="화살표" />
            </a>
        </div>
        <div class="form-row">
            <label>성별</label>
            <span>
                <input type="radio" name="gender" value="m" id="gender-m" <c:if test="${dto.gender == 'm'}">checked</c:if>>
                <label for="gender-m">남자</label>
                <input type="radio" name="gender" value="w" id="gender-w" <c:if test="${dto.gender == 'w'}">checked</c:if>>
                <label for="gender-w">여자</label>
            </span>
        </div>
        <div class="form-row">
            <label>생년월일</label>
            <input type="date" name="birth" value="<fmt:formatDate value='${dto.birth}' pattern='yyyy-MM-dd' />" />
        </div>
        <div class="form-row">
            <label>주소</label>
            <a href="javascript:void(0);" onclick="openAddressModal()">
                <img src="/resources/suhodan_images/icon/arrow_right.png" alt="화살표" />
            </a>
        </div>

        <input type="hidden" name="address1" id="address1" value="${dto.address1}" />
        <input type="hidden" name="address2" id="address2" value="${dto.address2}" />
        <%-- <input type="hidden" name="passwd" value="${dto.passwd}" /> --%>

        <div class="buttons">
            <button type="submit" class="save-btn">저장하기</button>
            <br />
            <button type="button" class="withdraw-btn" onclick="btnDelete()">회원 탈퇴</button>
        </div>
    </form>
</div>

<!-- 주소 모달 -->
<div id="addressModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
        	<button class="back-icon" onclick="closeAddressModal()"></button>
            <!-- <span class="back-icon" onclick="closeAddressModal()">
                <img src="/resources/suhodan_images/icon/arrow_right.png" class="flip-icon" alt="뒤로가기" />
            </span> -->
            <h4>주소 수정</h4>
        </div>
        
        <div class="address-wrapper">
            <input type="text" id="modal_address1" placeholder="도로명 주소" readonly />
            <button type="button" class="postcode-btn" onclick="findPostcode()">우편번호 검색</button>
        </div>
        
        <input class="modal_address2" type="text" id="modal_address2" placeholder="상세주소" />
        
        <div class="modal-buttons">
            <button onclick="applyAddress()">확인</button>
        </div>
    </div>
</div>

<!-- 비밀번호 재설정 모달 -->
<div id="resetPasswordModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
        	<button class="back-icon" onclick="closeResetPasswordModal()"></button>
            <h4>비밀번호 재설정</h4>
        </div>
        <form name="pwdform" method="post" action="/mypage/pwdedit">
	        <div class="pswd-input">
		        <input type="password" id="current_passwd" name="current_passwd" placeholder="현재 비밀번호" />
		        <input type="password" id="new_passwd" name="new_passwd" placeholder="새 비밀번호" />
		        <input type="password" id="confirm_passwd" name="confirm_passwd" placeholder="비밀번호 확인" />
		    </div>
	    </form>
	    
	    <p id="message" class="message">&nbsp;</p>
        <p id="passwd_error" class="error-message" style="display:none;">비밀번호가 일치하지 않습니다</p>
        <p id="same_password_error" class="error-message" style="display:none;">이전 비밀번호와 동일한 비밀번호입니다</p>
        <p id="new_passwd_error" class="error-message" style="display:none;">새 비밀번호를 입력하세요</p>
        <div class="modal-buttons">
            <button onclick="submitPasswordChange()">확인</button>
        </div>
    </div>
</div>

<script>
//주소 수정 관련 함수
function openAddressModal() {
    document.getElementById("modal_address1").value = document.getElementById("address1").value;
    document.getElementById("modal_address2").value = document.getElementById("address2").value;
    document.getElementById("addressModal").style.display = "block";
}

function closeAddressModal() {
    document.getElementById("addressModal").style.display = "none";
}

function applyAddress() {
    document.getElementById("address1").value = document.getElementById("modal_address1").value;
    document.getElementById("address2").value = document.getElementById("modal_address2").value;
    closeAddressModal();
}

function findPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            var addr = (data.userSelectedType === 'R') ? data.roadAddress : data.jibunAddress;
            document.getElementById("modal_address1").value = "(" + data.zonecode + ") " + addr;
            document.getElementById("modal_address2").focus();
        }
    }).open();
}


//회원 탈퇴
function btnDelete() {
    if (confirm("회원 탈퇴 하시겠습니까?")) {
        document.form1.action = "/mypage/delete.do";
        document.form1.submit();
    }
}


//비밀번호 재설정 관련 함수
function openResetPasswordModal() {
    document.getElementById("resetPasswordModal").style.display = "block";
}

function closeResetPasswordModal() {
    document.getElementById("resetPasswordModal").style.display = "none";
}

function submitPasswordChange() {
    const current = document.getElementById("current_passwd").value.trim();
    const newPass = document.getElementById("new_passwd").value.trim();
    const confirm = document.getElementById("confirm_passwd").value.trim();
    const msg = document.getElementById("message");
    
	// 현재 비밀번호를 입력하지 않았을 경우
	if (current === "") {
		return msg.textContent = "현재 비밀번호를 입력해주세요.";
	}
 
	// 새 비밀번호를 입력하지 않았을 경우
	if (newPass === "") {
	     return msg.textContent = "새 비밀번호를 입력해주세요.";
	}
    
	// 새 비밀번호와 확인 비밀번호가 일치하지 않으면
	if (newPass !== confirm) {
		return msg.textContent = "새 비밀번호가 일치하지 않습니다.";
	}
	
	document.pwdform.submit();
    closeResetPasswordModal();
}
</script>

</body>
</html>
