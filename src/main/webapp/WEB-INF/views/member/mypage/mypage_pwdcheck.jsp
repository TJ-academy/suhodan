<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주소 변경</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<style>
	.container {
		position: relative;
		width: 500px !important;
        margin: 47px auto;
        padding: 40px;
        background-color: #F5F1EB;
		border: 1.67px solid #D8C2A6;
		border-radius: 16.65px;
        text-align: center;
	}
	
	.title {
		align-items: center;
		display: flex;
		gap: 10px;
		margin: 20px;
		margin-top: 0px;
		margin-bottom: 10px;
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
		
	.message {
		color: #E64B4E;
		margin: 10px;
		margin-bottom: 20px;
		/* margin-left:30px;
		text-align: left; */
	}
	
	.pwdcheck input {
		font-size: 18px;
		color: #000000;
		width: 290px;
		border-radius: 16.65px;
	    border: 1px solid #C4C4C4;
	    background-color: #FFFFFF;
	    padding: 10px 10px;
	    margin-right: 20px;
	}
	
	.pwdcheck input:focus {
		border: 1px solid #9C6B4F;
		outline: none;
	}
	
	.pwdcheck button {
		background-color: #9C6B4F;
	    color: white;
	    width: 100px;
	    border: 1px solid #9C6B4F;
	    padding: 10px 10px;
	    border-radius: 16.65px;
	    font-size: 18px;
	    cursor: pointer;
	}
</style>

<script>
$(function() {
	$("#passwd").focus();
	
	$("#btnPwdCheck").click(function() {
		const passwd=$("#passwd").val();
		if(passwd=="") {
			alert("비밀번호를 입력하세요.");
			$("#passwd").focus();
			return;
		}
		document.form1.action="/mypage/pwdcheck.do";
		document.form1.submit();
	});
});
</script>
</head>
<body>
<%@ include file="../../include/menu.jsp" %>

<div class="container">
    <div class="title">
    	<!-- 뒤로가기 버튼 -->
		<button class="back-icon" onclick="location.href='/mypage'"></button>
		<img src="/resources/suhodan_images/icon/edit.png" alt="수정 아이콘">
		<span class="title-text">비밀번호 확인</span>
    </div>
    
    <div class="message">
    	<c:if test="${not empty message}">
			${message}
		</c:if>
		<c:if test="${empty message}">
			&nbsp;
		</c:if>
	</div>
	
	<div class="pwdcheck">
	    <form name="form1" method="post" action="/mypage/pwdcheck.do">
	        <input type="password" id="passwd" name="passwd" placeholder="비밀번호 입력"  />
	        <button type="button" id="btnPwdCheck">확인</button>
	    </form>
    </div>
</div>
</body>
</html>