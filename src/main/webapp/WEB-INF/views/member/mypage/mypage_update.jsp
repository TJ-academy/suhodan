<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>개인 정보 수정</title>
    <link rel="stylesheet" href="/css/mypage.css" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>

<body>
<%@ include file="../../include/menu.jsp" %>
<br>

<div class="mypage-container">

    <div align="left">
        <img src="/resources/suhodan_images/icon/edit.png" alt="수정 아이콘">
        <span>개인 정보 수정</span>
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
        <input type="hidden" name="passwd" id="form_passwd" />

        <div class="buttons">
            <button type="button" class="save-btn" onclick="openCheckPasswordModal()">저장하기</button>
            <br />
            <button type="button" class="withdraw-btn" onclick="btnDelete()">회원 탈퇴</button>
        </div>
    </form>
</div>

<!-- 주소 모달 -->
<div id="addressModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <span class="back-icon" onclick="closeAddressModal()">
                <img src="/resources/suhodan_images/icon/arrow_right.png" class="flip-icon" alt="뒤로가기" />
            </span>
            <h4>주소 수정</h4>
        </div>
        
        <div class="address-wrapper">
            <input type="text" id="modal_address1" placeholder="도로명 주소" readonly />
            <button type="button" class="postcode-btn" onclick="findPostcode()">검색</button>
        </div>
        
        <input type="text" id="modal_address2" placeholder="상세주소" />
        
        <div class="modal-buttons">
            <button onclick="applyAddress()">확인</button>
        </div>
    </div>
</div>

<!-- 비밀번호 재설정 모달 -->
<div id="resetPasswordModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <span class="back-icon" onclick="closeResetPasswordModal()">
                <img src="/resources/suhodan_images/icon/arrow_right.png" class="flip-icon" alt="뒤로가기" />
            </span>
            <h4>비밀번호 재설정</h4>
        </div>
        <input type="password" id="current_passwd" placeholder="현재 비밀번호" />
        <input type="password" id="new_passwd" placeholder="새 비밀번호" />
        <input type="password" id="confirm_passwd" placeholder="비밀번호 확인" />
        <p id="passwd_error" class="error-message" style="display:none;">비밀번호가 일치하지 않습니다</p>
        <p id="same_password_error" class="error-message" style="display:none;">이전 비밀번호와 동일한 비밀번호입니다</p>
        <p id="new_passwd_error" class="error-message" style="display:none;">새 비밀번호를 입력하세요</p>
        <div class="modal-buttons">
            <button onclick="submitPasswordChange()">확인</button>
        </div>
    </div>
</div>

<!-- 비밀번호 확인 모달 -->
<div id="checkPasswordModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <span class="back-icon" onclick="closeCheckPasswordModal()">
                <img src="/resources/suhodan_images/icon/arrow_right.png" class="flip-icon" alt="뒤로가기" />
            </span>
            <h4>비밀번호 확인</h4>
        </div>
        <input type="password" id="modal_passwd" placeholder="비밀번호 입력" />
        <div class="modal-buttons">
            <button onclick="submitWithPassword()">확인</button>
        </div>
    </div>
</div>

<script>
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

function btnDelete() {
    if (confirm("회원 탈퇴 하시겠습니까?")) {
        document.form1.action = "/mypage/delete.do";
        document.form1.submit();
    }
}

function openCheckPasswordModal() {
    document.getElementById("modal_passwd").value = "";
    document.getElementById("checkPasswordModal").style.display = "block";
}

function closeCheckPasswordModal() {
    document.getElementById("checkPasswordModal").style.display = "none";
}

function submitWithPassword() {
    var pw = document.getElementById("modal_passwd").value.trim();
    if (!pw) {
        alert("비밀번호를 입력해주세요.");
        return;
    }
    document.getElementById("form_passwd").value = pw;
    closeCheckPasswordModal();
    document.form1.submit();
}

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
    
    const validCurrentPassword = "${dto.passwd}"; // 실제 서버에서 확인하는 로직이 필요

    // 현재 비밀번호와 일치하지 않으면
    if (current !== validCurrentPassword) {
        document.getElementById("passwd_error").style.display = "block";
        document.getElementById("same_password_error").style.display = "none";
        document.getElementById("new_passwd_error").style.display = "none";
        return;
    }

    // 새 비밀번호를 입력하지 않았을 경우
    if (newPass === "") {
        document.getElementById("new_passwd_error").style.display = "block";
        return;
    }

    // 새 비밀번호와 확인 비밀번호가 일치하지 않으면
    if (newPass !== confirm) {
        document.getElementById("passwd_error").style.display = "block";
        document.getElementById("same_password_error").style.display = "none";
        document.getElementById("new_passwd_error").style.display = "none";
        return;
    }

    // 새 비밀번호와 현재 비밀번호가 동일하면
    if (current === newPass) {
        document.getElementById("same_password_error").style.display = "block";
        document.getElementById("passwd_error").style.display = "none";
        document.getElementById("new_passwd_error").style.display = "none";
        return;
    }

    // 비밀번호 변경 후 form_passwd에 새로운 비밀번호를 저장
    document.getElementById("form_passwd").value = newPass;

    // 비밀번호 변경을 서버로 전송하는 로직 추가
    alert("비밀번호가 변경되었습니다.");
    closeResetPasswordModal();
}
</script>

</body>
</html>
