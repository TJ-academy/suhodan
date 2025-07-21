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
  <!-- <link rel="stylesheet" href="/css/reward_select.css"> -->
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
      background-color: #D8C2A6;
      color: white;
      border: none;
      border-radius: 8px;
      cursor: pointer;
    }
    .reward-select-button:hover {
    background-color: #9c6b4f;
    }
  </style>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<%-- <% String imp_uid = request.getParameter("imp_uid");%> --%>

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
      <div class="reward-description">${reward_a_name}</div>
      <div class="reward-description">${reward_a_description}</div>
      <button class="reward-select-button" onclick="submitReward('15-30')">선택</button>
    </div>
	
    <!-- 리워드 구간 2 -->
    <div class="reward-box <%= (amount < 30000 || amount >= 50000) ? "disabled" : "" %>">
      <div class="reward-title">30,000원 이상 50,000원 미만 리워드</div>
      <div class="reward-description">${reward_b_name}</div>
      <div class="reward-description">${reward_b_description}</div>
      <button class="reward-select-button" onclick="submitReward('30-50')">선택</button>
    </div>

    <!-- 리워드 구간 3 -->
    <div class="reward-box <%= (amount < 50000 || amount >= 100000) ? "disabled" : "" %>">
      <div class="reward-title">50,000원 이상 100,000원 미만 리워드</div>
      <div class="reward-description">${reward_c_name}</div>
      <div class="reward-description">${reward_c_description}</div>
      <button class="reward-select-button" onclick="submitReward('50-100')">선택</button>
    </div>

    <!-- 리워드 구간 4 -->
    <div class="reward-box <%= (amount < 100000) ? "disabled" : "" %>">
      <div class="reward-title">100,000원 이상 리워드</div>
      <div class="reward-description">${reward_d_name}</div>
      <div class="reward-description">${reward_d_description}</div>
      <button class="reward-select-button" onclick="submitReward('100-')">선택</button>
    </div>

    <div style="text-align: center; margin-top: 30px;">
  <button onclick="goToBuyPage()" class="reward-select-button">다음으로</button>
</div>

  </div>

 <script>
  let selectedRewardTier = null;

  let selectedRewardName = '';
  let selectedRewardDescription = '';
  let selectedRewardId = ''; 
  
  function submitReward(tier) {
    selectedRewardTier = tier;
    alert('리워드가 선택되었습니다! 아래 [다음으로] 버튼을 눌러 결제 페이지로 이동해주세요.');
    
    if (tier === '15-30') {
    	selectedRewardId = "${reward_a_id}"; 
        selectedRewardName = "${reward_a_name}"; // Corrected line
        selectedRewardDescription = "${reward_a_description}"; // Corrected line
    } else if (tier === '30-50') {
    	selectedRewardId = "${reward_b_id}";
        selectedRewardName = "${reward_b_name}"; // Corrected line
        selectedRewardDescription = "${reward_b_description}"; // Corrected line
    } else if (tier === '50-100') {
    	selectedRewardId = "${reward_c_id}";
        selectedRewardName = "${reward_c_name}"; // Corrected line
        selectedRewardDescription = "${reward_c_description}"; // Corrected line
    } else if (tier === '100-') { // Corrected this to '100-' based on your button's onclick
    	selectedRewardId = "${reward_d_id}";
        selectedRewardName = "${reward_d_name}"; // Corrected line
        selectedRewardDescription = "${reward_d_description}"; // Corrected line
    }
  }

  function goToBuyPage() {
    const amount = <%= amount %>;
    const urlParams = new URLSearchParams(window.location.search);
    const imp_uid = urlParams.get('imp_uid');
    if (!selectedRewardTier) {
      alert("리워드를 먼저 선택해주세요.");
      return;
    }

 // URLSearchParams 객체를 사용하여 파라미터 생성
    const params = new URLSearchParams();
    params.append('amount', amount);
    params.append('tier', selectedRewardTier);
    params.append('rewardId', selectedRewardId); // 자동으로 인코딩됩니다.
    params.append('rewardName', selectedRewardName); // 자동으로 인코딩됩니다.
    params.append('rewardDescription', selectedRewardDescription); // 자동으로 인코딩됩니다.
    params.append('imp_uid', imp_uid);

    // 최종 URL 생성
    const url = `/donation/buy.do?` + params.toString();
    window.location.href = url;
  }
</script>
 
</body>
</html>
