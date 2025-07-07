<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
$(function() {
	$("#btnLogin").click(function() {
		const userid=$("#userid").val();
		const passwd=$("#passwd").val();
		if(userid=="") {
			alert("아이디를 입력하세요.");
			$("#userid").focus();
			return;
		}
		if(passwd=="") {
			alert("비밀번호를 입력하세요.");
			$("#passwd").focus();
			return;
		}
		document.form1.action="/login_check.do";
		document.form1.submit();
	});
});
</script>
<link rel="stylesheet" href="/css/login.css">
</head>
<body>
<%@ include file="../include/menu.jsp" %>

<p class="login_text">로그인</p>
<div class="login_box">
  <div class="login_container">
    <form name="form1" method="post">
      <label for="userid">아이디를 입력하세요.</label>
      <input type="text" id="userid" name="user_id" autocomplete="username" />

      <label for="passwd">비밀번호를 입력하세요.</label>
      <input type="password" id="passwd" name="passwd" autocomplete="current-password" />

      <button type="button" id="btnLogin">로그인</button>

      <c:if test="${message == 'error'}">
        <div class="message error">아이디 또는 비밀번호가 일치하지 않습니다.</div>
      </c:if>
      <c:if test="${message == 'logout'}">
        <div class="message logout">로그아웃되었습니다.</div>
      </c:if>
      <c:if test="${param.message == 'nologin'}">
        <div class="message nologin">로그인 하신 후 사용하세요.</div>
      </c:if>

      <div class="signup-link" onclick="location.href='/join.do'">회원가입</div>
    </form>
  </div>
</div>

</body>
</html>