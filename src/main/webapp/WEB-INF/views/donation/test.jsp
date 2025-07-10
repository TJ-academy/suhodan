<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 뱃지 발급 모달 -->
<div id="badgeModal" style="
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 360px;
  padding: 40px 30px;
  background: #f9f4ef;
  border-radius: 20px;
  box-shadow: 0 8px 20px rgba(0,0,0,0.15);
  font-family: '맑은 고딕', sans-serif;
  color: #7a5a44;
  text-align: center;
  white-space: normal;
  word-break: keep-all;
  z-index: 1000;
">
  <p style="font-size: 24px; font-weight: 700; margin-bottom: 20px;">
    기부가 완료되었습니다.
  </p>
  <p style="font-size: 16px; margin-bottom: 8px;">
    뱃지가 발급되었습니다.
  </p>
  <p style="font-size: 16px; margin-bottom: 24px;">
    당신은 분명 이 설화의 수호자입니다!
  </p>
  <p style="font-size: 14px; color: #a89a8f; margin-bottom: 32px;">
    *뱃지는 [나의 수호수]에서 확인할 수 있습니다.
  </p>
  <button style="
    background-color: #9c6b4f;
    color: white;
    border: none;
    border-radius: 12px;
    padding: 12px 60px;
    font-size: 16px;
    cursor: pointer;
    transition: background-color 0.3s ease;
  " onmouseover="this.style.backgroundColor='#7a5238'" onmouseout="this.style.backgroundColor='#9c6b4f'">
    확인
  </button>
</div>

</body>
</html>