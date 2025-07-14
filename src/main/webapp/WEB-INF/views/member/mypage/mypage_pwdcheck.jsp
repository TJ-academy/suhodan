<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주소 변경</title>

<style>
	.title {
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
	
	.title-text {
		font-size: 21px;
		font-weight: bold;
		color: #504848;
	}
</style>

<script>
$(function() {
	$("#btnPwdCheck").click(function() {
		const passwd=$("#passwd").val();
		if(passwd=="") {
			alert("비밀번호를 입력하세요.");
			$("#passwd").focus();
			return;
		}
		document.form1.action="/mypage/pwdcheck.do";
		document.form1.submit();
	})
})
</script>
</head>
<body>
<%@ include file="../include/menu.jsp" %>

<div>
    <div class=title>
    	<!-- 뒤로가기 버튼 -->
		<button class="back-icon" onclick="location.href='/mypage'"></button>
		<img src="/resources/suhodan_images/icon/edit.png" alt="수정 아이콘">
		<span class="title-text">비밀번호 확인</span>
    </div>

    <form name="form1" method="post" action="/mypage/pwdchecking">
        <input type="password" id="passwd" name="passwd" placeholder="비밀번호 입력" />
        <button type="button" id="btnPwdCheck">확인</button>
    </form>
</div>
</body>
</html>