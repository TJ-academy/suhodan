<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
</head>
<body>
<%@ include file="../../include/menu.jsp" %>
<h2>마이페이지 - 개인 정보 수정</h2>
<br>
<form action="/mypage/update.do" method="post">
<table border="0" width="500px">
	<tr>
		<td>이름</td>
		<td><input name="name" value="${dto.name}"></td>
	</tr>
	<tr>
		<td>아이디</td>
		<td>
			${dto.user_id}
			<input type="hidden" name="user_id" value="${dto.user_id}"/>
		</td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td><input type="password" name="passwd"></td>
	</tr>

	<tr>
		<td>성별</td>
		<td>
			<input type="radio" name="gender" value="m" id="gender-m"
				<c:if test="${dto.gender == 'm'}">checked</c:if>
			/>
			<label for="gender-m">남자</label>
			<input type="radio" name="gender" value="w" id="gender-w" 
				<c:if test="${dto.gender == 'w'}">checked</c:if>
			/>
			<label for="gender-w">여자</label>
		</td>
	</tr>
	<tr>
		<td>생년월일</td>
		<td><input type="date" name="birth" value="<fmt:formatDate value='${dto.birth}' pattern='yyyy-MM-dd' />" /></td>
	</tr>
	<tr>
		<td>주소</td>
		<td>
			<input type="text" name="address1" id="address1" style="width: 337px;" required readonly>
			<button type="button" onclick="findPostcode()" style="width: 136px;">우편번호 검색</button>
			<br>
			<input type="text" name="address2" id="address2" placeholder="상세 주소를 입력하세요." style="width: 337px;" required>
			<input type="hidden" name="address" id="fullAddress">
		</td>
	</tr>
	<tr>
		<td>가입 날짜</td>
		<td><fmt:formatDate value="${dto.join_date}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
	</tr>
</table>
<br>
<c:if test="${not empty message}">
	<p style="color:red;">${message}</p>
</c:if>
<button type="submit">저장하기</button>
<button type="button" onclick="location.href='/mypage'">뒤로가기</button>
</form>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
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