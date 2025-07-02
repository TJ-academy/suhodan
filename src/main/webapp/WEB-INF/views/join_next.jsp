<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	//이전 페이지 데이터
	String user_id = request.getParameter("user_id");
	String passwd = request.getParameter("passwd");
%>
<form method="post" action="/insert.do">
	<input type="hidden" name="user_id" value="<%=user_id%>">
	<input type="hidden" name="passwd" value="<%=passwd%>">
	
	<label>이름</label><br>
	<input type="text" name="name"><br>
	
	<label>주소</label><br>
	<input type="text" name="address"><br>
	
	<label>성별</label><br>
	<input type="radio" name="gender" value="m" id="gender-m">
	<label for="gender-m">남</label>
	<input type="radio" name="gender" value="w" id="gender-w">
	<label for="gender-w">여</label><br>
	
	<label>생년월일</label><br>
	<input type="hidden" name="birth" id="birth">
	<select id="birth_year">
	  <option value=""></option>
	  <% for (int i = 1950; i <= 2025; i++) { %>
	    <option value="<%= i %>"><%= i %></option>
	  <% } %>
	</select>년
	<select id="birth_month">
	  <option value=""></option>
	  <% for (int i = 1; i <= 12; i++) { %>
	    <option value="<%= i %>"><%= i %></option>
	  <% } %>
	</select>월
	<select id="birth_day">
	  <option value=""></option>
	  <% for (int i = 1; i <= 31; i++) { %>
	    <option value="<%= i %>"><%= i %></option>
	  <% } %>
	</select>일<br>
	
	<p>아이디와 비밀번호는 영문/숫자로 이루어져야 합니다.</p>
	
	<button type="submit">저장하기</button>
</form>
<script>
	function updateBirth() {
	  const year = document.getElementById("birth_year").value;
	  const month = document.getElementById("birth_month").value.padStart(2, '0');
	  const day = document.getElementById("birth_day").value.padStart(2, '0');
	
	  if (year && month && day) {
	    document.getElementById("birth").value = `${year}-${month}-${day}`;
	  } else {
	    document.getElementById("birth").value = "";
	  }
	}
</script>
</body>
</html>