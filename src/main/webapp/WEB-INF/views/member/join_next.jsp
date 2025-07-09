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
			<input type="text" name="address1" id="address1" style="width: 337px;" required readonly>
			<button type="button" onclick="findPostcode()" class="search_btn" style="border-radius:0 15px 15px 0;">우편번호 검색</button>
			<br>
			<input type="text" name="address2" id="address2" placeholder="상세 주소를 입력하세요." style="width: 337px; border-radius:10px;" required>
			<input type="hidden" name="address" id="fullAddress">
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

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
	
	function findPostcode() {
	    new daum.Postcode({
	      oncomplete: function(data) {
	    	// 각 주소의 노출 규칙에 따라 주소를 조합한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var addr = ''; // 주소 변수
			var extraAddr = ''; // 참고항목 변수
			
			//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = '(' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("address2").value = extraAddr;
            
            } else {
                document.getElementById("address2").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById("address1").value = "(" + data.zonecode+ ") " + addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("address2").focus();
	      }
	    }).open();
	  }
</script>
</body>
</html>