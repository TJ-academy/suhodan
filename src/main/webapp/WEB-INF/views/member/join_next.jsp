<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 입력</title>
</head>
<body>
<%
	String user_id = request.getParameter("user_id");
	String passwd = request.getParameter("passwd");
%>
<form method="post" action="/insert.do">
	<input type="hidden" name="user_id" value="<%=user_id%>">
	<input type="hidden" name="passwd" value="<%=passwd%>">

	<label>이름</label><br>
	<input type="text" name="name" required><br>

	<label>주소</label><br>
	<input type="text" name="address" required><br>

	<label>성별</label><br>
	<input type="radio" name="gender" value="m" id="gender-m" required>
	<label for="gender-m">남</label>
	<input type="radio" name="gender" value="w" id="gender-w">
	<label for="gender-w">여</label><br>

	<label>생년월일</label><br>
	<input type="date" name="birth" required />
	<%-- <select id="birth_year" required>
	  <option value="">년</option>
	  <% for (int i = 1950; i <= 2025; i++) { %>
	    <option value="<%= i %>"><%= i %></option>
	  <% } %>
	</select>
	<select id="birth_month" required>
	  <option value="">월</option>
	  <% for (int i = 1; i <= 12; i++) { %>
	    <option value="<%= i %>"><%= i %></option>
	  <% } %>
	</select>
	<select id="birth_day" required>
	  <option value="">일</option>
	  <% for (int i = 1; i <= 31; i++) { %>
	    <option value="<%= i %>"><%= i %></option>
	  <% } %>
	</select> --%>
	<br><br>

	<input type="hidden" name="birth" id="birth">
	<button type="submit">저장하기</button>
</form>

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
	}

	window.onload = function () {
		document.getElementById("birth_year").addEventListener("change", updateBirth);
		document.getElementById("birth_month").addEventListener("change", updateBirth);
		document.getElementById("birth_day").addEventListener("change", updateBirth);
	};
</script>
</body>
</html>
