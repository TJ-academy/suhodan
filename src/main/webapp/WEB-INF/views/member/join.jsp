<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/join.css">
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<p class="join_text">회원가입</p>
<div class="join_box">
  <div class="join_container d-flex justify-content-center">
	<form method="post" action="/join_next.do" onsubmit="return checkPasswordMatch()">
	<label>아이디를 입력하세요.</label>
	<div class="input-group">
		<input type="text" name="user_id" id="user_id" style="width: 209px;">
		<button type="button" onclick="checkIdDuplicate()" class="dupliBtn"
		style="border-radius: 0 10px 10px 0;">중복체크</button><br>
	</div>
	<span id="idCheckMsg" class="error"></span>
		
	<label>비밀번호를 입력하세요.</label>
	<div class="input-group">
		<input type="password" name="passwd" id="pass1" style="width: 338px;">
	</div>
	<label>비밀번호를 다시 입력하세요.</label>
	<div class="input-group">
		<input type="password" id="pass2" style="width:338px;">
	</div>
	<p id="errorMsg" class="error" style="margin-top: 0;"></p>
	<p class="text1">아이디와 비밀번호는 영문/숫자로 이루어져야 합니다.</p>
	<button type="submit" id="submitBtn" disabled>다음으로 ✔</button>
	</form>
  </div>
</div>
<script>
	function checkPasswordMatch() {
	    const pass1 = document.getElementById("pass1").value;
	    const pass2 = document.getElementById("pass2").value;
	    const errorMsg = document.getElementById("errorMsg");
	
	    if (pass1 !== pass2) {
	        errorMsg.textContent = "비밀번호가 일치하지 않습니다.";
	        return false; // 폼 제출 막기
	    } else {
	        errorMsg.textContent = ""; // 오류 메시지 제거
	        return true; // 정상 제출
	    }
	}
	
	function checkIdDuplicate() {
	    const userId = document.getElementById("user_id").value;
	    const msg = document.getElementById("idCheckMsg");
	    const submitBtn = document.getElementById("submitBtn");
	    
	    if (userId.trim() === "") {
	        msg.textContent = "아이디를 입력해주세요.";
	        msg.style.color = "red";
	        submitBtn.disabled = true; // 버튼 비활성화
	        return;
	    }   
	    
	    fetch("/check_id.do?user_id=" + encodeURIComponent(userId))
	        .then(response => response.text())
	        .then(result => {
	            if (result === "OK") {
	                msg.textContent = "사용할 수 있는 아이디입니다.";
	                msg.style.color = "#9C6B4F";
	                submitBtn.disabled = false; // 버튼 활성화
	            } else {
	                msg.textContent = "이미 사용 중인 아이디입니다.";
	                msg.style.color = "#AC1515";
	                submitBtn.disabled = true; // 버튼 비활성화
	            }
	        })
	        .catch(err => {
	            msg.textContent = "서버 오류. 다시 시도해주세요.";
	            msg.style.color = "red";
	            submitBtn.disabled = true; // 버튼 비활성화
	        });
	}
</script>
</body>
</html>