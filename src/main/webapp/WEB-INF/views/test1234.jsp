<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>전화번호 인증</title>
</head>
<body>
	<h2>전화번호 인증</h2>

	<label for="phoneNumber">전화번호:</label>
	<input type="text" id="phoneNumber" placeholder="예: +821012345678" style="width:200px;"> <button onclick="send()">인증 코드 보내기</button>

	<br>
	<br>

	<label for="verificationCode">인증 코드:</label>
	<input type="text" id="verificationCode" placeholder="인증 코드 입력" style="width:200px;">

	<button onclick="verify()">인증 확인</button>

	<script>
    // 인증 코드 보내기
function send() {
    const phoneNumber = document.getElementById("phoneNumber").value.trim(); // 공백 제거

    if (!phoneNumber) {
        alert("전화번호를 입력해주세요.");
        return;
    }

    fetch('/mypage/phone/send.do', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            phoneNumber: phoneNumber // 객체 형태로 전송
        })
    })
    .then(response => {
        if (!response.ok) {
            // 서버에서 200 OK가 아닌 상태 코드를 반환할 경우
            return response.json().then(errorData => {
                throw new Error(errorData.message || '서버 오류 발생');
            });
        }
        return response.json();
    })
    .then(data => {
        alert(data.message); // 서버에서 보낸 메시지 출력 (예: "인증 코드가 발송되었습니다.")
    })
    .catch(error => {
        console.error('Error sending verification code:', error);
        alert('오류 발생: ' + error.message);
    });
}

// 인증 코드 확인
function verify() {
    const phoneNumber = document.getElementById("phoneNumber").value.trim(); // 공백 제거
    const code = document.getElementById("verificationCode").value.trim(); // 공백 제거

    if (!phoneNumber || !code) {
        alert("전화번호와 인증 코드를 모두 입력해주세요.");
        return;
    }

    fetch('/mypage/phone/verify.do', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            phoneNumber: phoneNumber, // 객체 형태로 전송
            code: code
        })
    })
    .then(response => {
        if (!response.ok) {
            return response.json().then(errorData => {
                throw new Error(errorData.message || '서버 오류 발생');
            });
        }
        return response.json();
    })
    .then(data => {
        alert(data.message); // 서버에서 보낸 메시지 출력
        if (data.status === 'success') {
            // 인증 성공 시 추가 로직 (예: 페이지 이동 또는 UI 변경)
            console.log("인증 성공!");
        }
    })
    .catch(error => {
        console.error('Error verifying code:', error);
        alert('오류 발생: ' + error.message);
    });
}
    </script>
</body>
</html>