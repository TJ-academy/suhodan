<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String amountParam = request.getParameter("amount");
    int amount = 0;
    if (amountParam != null && !amountParam.isEmpty()) {
        try {
            amount = Integer.parseInt(amountParam);
        } catch (NumberFormatException e) {
            amount = 0;
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>리워드 선택</title>
  <link rel="stylesheet" href="/css/reward_select.css">
  <style>
body {
	background-color: #fdf4ec;
	font-family: 'Noto Sans KR', sans-serif;
	margin: 0;
	padding: 0;
}
.outer-box {
	max-width: 1000px;
	margin: 60px auto;
	background-color: #F5F1EB;
	border: 1px solid #D8C2A6;
	border-radius: 20px;
	padding: 50px 60px;
	box-sizing: border-box;
}
.logo {
  text-align: center;
  margin-bottom: 20px;
}

.logo-img {
  max-width: 120px; 
  height: auto;     
}
    .title {
      text-align: center;
      font-size: 22px;
      margin-bottom: 20px;
      font-weight: bold;
      color: #2E2E2E;
    }
    .highlight {
      color: #9C6B4F;
      font-weight: bold;
    }
    .reward-box {
      border: 1px solid #ccc;
      padding: 20px;
      margin-bottom: 15px;
      border-radius: 12px;
      background-color: white;
    }
    .reward-box.disabled {
      opacity: 0.5;
      pointer-events: none;
    }
    .reward-title {
      font-size: 18px;
      font-weight: bold;
      margin-bottom: 10px;
    }
    .reward-description {
      font-size: 14px;
      color: #444;
    }
    .reward-select-button {
      margin-top: 10px;
      padding: 10px 30px;
      background-color: #9c6b4f;
      color: white;
      border: none;
      border-radius: 8px;
      cursor: pointer;
    }
  </style>
</head>
<body>
<%@ include file="../include/menu.jsp" %>

  <div class="outer-box">
   <div class="logo">
    <img src="/resources/images/logo_no_text.png" alt="로고" class="logo-img">
  </div>
    <div class="title">
      총 <span class="highlight"><%= amount %>원</span>을 후원하신 수호자님!<br>
      리워드를 선택해 주세요!
    </div>

    <!-- 리워드 구간 1 -->
    <div class="reward-box <%= (amount < 15000 || amount >= 30000) ? "disabled" : "" %>">
      <div class="reward-title">15,000원 이상 30,000원 미만 리워드</div>
      <div class="reward-description">설화 스티커 5종 + 엽서 세트</div>
      <button class="reward-select-button" onclick="submitReward('15-30')">선택</button>
    </div>

    <!-- 리워드 구간 2 -->
    <div class="reward-box <%= (amount < 30000 || amount >= 50000) ? "disabled" : "" %>">
      <div class="reward-title">30,000원 이상 50,000원 미만 리워드</div>
      <div class="reward-description">설화 엽서 세트 + 안동사과 2kg + 사과주스 500ml</div>
      <button class="reward-select-button" onclick="submitReward('30-50')">선택</button>
    </div>

    <!-- 리워드 구간 3 -->
    <div class="reward-box <%= (amount < 50000 || amount >= 100000) ? "disabled" : "" %>">
      <div class="reward-title">50,000원 이상 100,000원 미만 리워드</div>
      <div class="reward-description">설화 포스터 + 전통 보자기 + 과일 세트</div>
      <button class="reward-select-button" onclick="submitReward('50-100')">선택</button>
    </div>

    <!-- 리워드 구간 4 -->
    <div class="reward-box <%= (amount < 100000 || amount >= 200000) ? "disabled" : "" %>">
      <div class="reward-title">100,000원 이상 200,000원 미만 리워드</div>
      <div class="reward-description">설화 수호자 박스 (굿즈 풀세트 + 프리미엄 과일)</div>
      <button class="reward-select-button" onclick="submitReward('100-200')">선택</button>
    </div>

    <div style="text-align: center; margin-top: 30px;">
  <button onclick="goToBuyPage()" class="reward-select-button">다음으로</button>
</div>

  </div>

 <script>
  let selectedRewardTier = null;

  function submitReward(tier) {
    selectedRewardTier = tier;
    alert('리워드가 선택되었습니다! 아래 [다음으로] 버튼을 눌러 결제 페이지로 이동해주세요.');
  }

  function goToBuyPage() {
    const amount = <%= amount %>;
    if (!selectedRewardTier) {
      alert("리워드를 먼저 선택해주세요.");
      return;
    }

    // 선택한 리워드와 금액을 쿼리 파라미터로 넘겨줌
    const url = `/donation/buy.do?amount=${amount}&tier=${selectedRewardTier}`;
    window.location.href = url;
  }
</script>
 
</body>
</html>
