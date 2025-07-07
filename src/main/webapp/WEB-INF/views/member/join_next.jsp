<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 입력</title>
<link rel="stylesheet" href="/css/join_next.css">
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<%
	String user_id = request.getParameter("user_id");
	String passwd = request.getParameter("passwd");
%>
<p class="join_text">회원가입</p>
<div class="join_box">
  <div class="join_container d-flex justify-content-center">
	<form method="post" action="/insert.do">
		<input type="hidden" name="user_id" value="<%=user_id%>">
		<input type="hidden" name="passwd" value="<%=passwd%>">
	
		<label>이름</label>
		<div class="input-group">
			<input type="text" name="name" style="width:337px;" required>
		</div>
	
		<label>주소</label>
		<div class="input-group">
			<input type="text" name="address" style="width: 337px;"required>
		</div>
		
		<label>성별</label>
		<div class="input-group">
			<input type="radio" name="gender" value="m" id="gender-m" 
		style="margin-left: 20px;" required>
			<label for="gender-m">&nbsp;&nbsp;남</label>
			<input type="radio" name="gender" value="w" id="gender-w"
			style="margin-left: 40px;">
			<label for="gender-w">&nbsp;&nbsp;여</label>
		</div>
	
		<label>생년월일</label><br>
		 <select id="birth_year" 
		 style="width: 103px; border-color:#C4C4C4; border-radius: 10px; height:46px; margin-right: 5px;" required>
		  <option value=""></option>
		  <% for (int i = 1950; i <= 2025; i++) { %>
		    <option value="<%= i %>"><%= i %></option>
		  <% } %>
		</select><span style="margin-right: 10px;">년</span>
		<select id="birth_month" style="width: 64px; border-color:#C4C4C4; border-radius: 10px; height:46px;  margin-right: 5px;" required>
		  <option value=""></option>
		  <% for (int i = 1; i <= 12; i++) { %>
		    <option value="<%= i %>"><%= i %></option>
		  <% } %>
		</select><span style="margin-right: 10px;">월</span>
		<select id="birth_day" style="width: 64px; border-color:#C4C4C4; border-radius: 10px; height:46px;  margin-right: 5px;" required>
		  <option value=""></option>
		  <% for (int i = 1; i <= 31; i++) { %>
		    <option value="<%= i %>"><%= i %></option>
		  <% } %>
		</select>일
		<br><br>
	
		<input type="hidden" name="birth" id="birth">
		<button type="submit" id="submitBtn" disabled>저장하기 ✔</button>
	</form>
  </div>
</div>

<script>
	function updateBirth() {
		const year = document.getElementById("birth_year").value;
		const month = document.getElementById("birth_month").value;
		const day = document.getElementById("birth_day").value;

		if (year && month && day) {
			const formattedMonth = month.toString().padStart(2, '0');
			const formattedDay = day.toString().padStart(2, '0');
			document.getElementById("birth").value = year+"-"+formattedMonth+"-"+formattedDay;
		} else {
			document.getElementById("birth").value = "";
		}
		checkFormValid();
	}

	function checkFormValid() {
		const name = document.querySelector('input[name="name"]').value.trim();
		const gender = document.querySelector('input[name="gender"]:checked');
		const year = document.getElementById("birth_year").value;
		const month = document.getElementById("birth_month").value;
		const day = document.getElementById("birth_day").value;

		const submitBtn = document.getElementById("submitBtn");

		if (name !== "" && gender && year && month && day) {
			submitBtn.disabled = false;
		} else {
			submitBtn.disabled = true;
		}
	}

	window.onload = function () {
		document.getElementById("birth_year").addEventListener("change", updateBirth);
		document.getElementById("birth_month").addEventListener("change", updateBirth);
		document.getElementById("birth_day").addEventListener("change", updateBirth);

		document.querySelector('input[name="name"]').addEventListener("input", checkFormValid);
		document.querySelectorAll('input[name="gender"]').forEach(el => {
			el.addEventListener("change", checkFormValid);
		});
	};
</script>
</body>
</html>
