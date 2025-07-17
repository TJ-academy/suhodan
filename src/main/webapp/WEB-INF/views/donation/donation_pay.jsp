<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <meta charset="UTF-8">
  <title>후원 결제</title>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js" integrity="sha512-bLT0Qm9VnAYZDflyKcBaQ2gg0hSYNQrJ8RilYldYQ1FxQYoCLtUjuuRuZo+fjqhx/qtq/1itJ0C2ejDxltZVFg==" crossorigin="anonymous" type="text/javascript"></script>
  <script src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js" type="text/javascript"></script>
  <link rel="stylesheet" href="/css/donation_pay.css">
  <style>
    /* donation_pay.css 에 추가하거나 여기에 직접 넣으세요 */
    /* 모달 오버레이 스타일 */
    .modal-overlay {
      display: none; /* 초기에는 숨김 */
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(0, 0, 0, 0.5); /* 반투명 검정 배경 */
      z-index: 999; /* 모달보다 낮은 z-index */
      justify-content: center; /* flexbox를 사용하여 내부 요소를 중앙에 정렬 */
      align-items: center;   /* flexbox를 사용하여 내부 요소를 중앙에 정렬 */
    }

    /* 뱃지 발급 모달 스타일 */
    #badgeModal {
      /* display: none; */ /* 이 스타일은 modal-overlay에 의해 제어됩니다. */
      position: relative; /* fixed 대신 relative로 두어 flex container에 종속되도록 */
      /* top, left, transform은 modal-overlay의 flexbox로 대체됨 */
      width: 360px;
      padding: 40px 30px;
      background: #F5F1EB;
      border: 1px solid #D8C2A6;
      border-radius: 20px;
      box-shadow: 0 8px 20px rgba(0,0,0,0.15);
      font-family: '맑은 고딕', sans-serif;
      color: #9C6B4F;
      text-align: center;
      white-space: normal;
      word-break: keep-all;
      z-index: 1000; /* 오버레이보다 높은 z-index */
    }

    #badgeModal p {
        margin-bottom: 0; /* 기본 마진 제거 */
    }
    #badgeModal p:nth-child(1) { /* "기부가 완료되었습니다." */
        font-size: 24px;
        font-weight: 700;
        margin-bottom: 20px;
    }
    #badgeModal p:nth-child(2) { /* "뱃지가 발급되었습니다." 또는 동적 메시지 */
        font-size: 16px;
        margin-bottom: 8px;
    }
    #badgeModal p:nth-child(3) { /* "당신은 분명 이 설화의 수호자입니다!" */
        font-size: 16px;
        margin-bottom: 24px;
    }
    #badgeModal p:nth-child(4) { /* "*뱃지는 [나의 수호수]에서 확인할 수 있습니다." */
        font-size: 14px;
        color: #a89a8f;
        margin-bottom: 32px;
    }


    #badgeModal button {
      background-color: #9c6b4f;
      color: white;
      border: none;
      border-radius: 12px;
      padding: 12px 60px;
      font-size: 16px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }
    #badgeModal button:hover {
      background-color: #7a5238; /* onmouseover/onmouseout 대신 hover 사용 */
    }

    /* 모달이 활성화되었을 때 body 스크롤 막기 */
    body.modal-open {
        overflow: hidden;
    }

    /* 금액 선택 테이블 스타일 (기존 CSS에 있을 수 있지만, 여기에 포함) */
    .amount-table {
        width: 100%;
        margin-top: 30px;
        border-collapse: collapse;
    }
    .amount-table td {
        border: 1px solid #D8C2A6;
        padding: 15px 0;
        text-align: center;
        font-size: 18px;
        cursor: pointer;
        background-color: #FFF;
        transition: background-color 0.2s;
    }
    .amount-table td:hover {
        background-color: #F0EADF;
    }
    .amount-table td.selected-amount {
        background-color: #D8C2A6;
        color: #fff;
        font-weight: bold;
    }
    .amount-display-input {
        width: 120px;
        height: 30px;
        border: 1px solid #D8C2A6;
        border-radius: 10px;
        padding: 5px 10px;
        font-size: 20px;
        text-align: right;
        -moz-appearance: textfield; /* Firefox에서 숫자 입력 필드의 스피너 숨기기 */
    }
    .amount-display-input::-webkit-outer-spin-button,
    .amount-display-input::-webkit-inner-spin-button {
        -webkit-appearance: none; /* Chrome, Safari에서 숫자 입력 필드의 스피너 숨기기 */
        margin: 0;
    }
  </style>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<div class="info_container">
  <div class="img_style">
    <img src="../../resources/images/tree.PNG" width="110px" height="83px">
  </div>
  <p style="text-align: center;">
    🎁 15,000원 이상 기부 시, 해당 마을의 특산품과 굿즈를 리워드로 드립니다!
  </p>
  <table class="amount-table">
    <tr>
      <td data-amount="5000">5,000원</td>
      <td data-amount="10000">10,000원</td>
      <td data-amount="15000">15,000원</td>
      <td data-amount="20000">20,000원</td>
    </tr>
    <tr>
      <td data-amount="30000">30,000원</td>
      <td data-amount="50000">50,000원</td>
      <td data-amount="100000">100,000원</td>
      <td id="direct_input_cell"><input type="number" id="direct_amount_input" placeholder="직접 입력"></td>
    </tr>
  </table>
  <p style="text-align: right; margin-top: 20px; font-size: 20px;">
    <input type="number" id="amount_for_payment" class="amount-display-input" readonly> 원
  </p>
  <span style="display:block; text-align: center;">
    <span style="font-size: 20px;">이메일을 입력해주세요.</span>
    <input type="email" id="buyer_email" placeholder="test@example.com"
    style="width:80%; height: 50px; border-radius:20px; text-align:center; margin-top: 10px;">
  </span>
  <input type="hidden" id="buyer_name" value="${sessionScope.name}">
  <div style="text-align:center; margin-top: 30px; font-size: 17px;">
    <input type="checkbox" id="check1"> <strong> (필수) 이 플랫폼은 해커톤 교육 프로젝트이며 실제 후원/기부 단체가 아님을 확인했습니다.</strong><br>
    <input type="checkbox" id="check2"> <strong> (필수) 기부금은 환불되지 않으며, 현금영수증/세금공제는 발급되지 않음을 이해합니다.</strong><br>
    <input type="checkbox" id="email_receipt_checkbox"> (선택) 이메일로 기부내역을 받겠습니다.
  </div>
  <button class="next_btn" onclick="requestPay()">결제하기</button>
</div>

<div id="modalContainer" class="modal-overlay">
  <div id="badgeModal">
    <p>
      기부가 완료되었습니다.
    </p>
    <p id="badgeMessage">
      뱃지가 발급되었습니다.
    </p>
    <p>
      당신은 분명 이 지역의 수호자입니다!
    </p>
    <button onclick="closeBadgeModal()">
      확인
    </button>
  </div>
</div>

<div id="rewardContainer" class="modal-overlay">
  <div id="rewardModal" style="background-color: #F5F1EB; padding: 40px 80px; border-radius: 15px; border: 1px solid #D8C2A6; text-align: center; max-width: 400px;">
    <p style="font-size: 22px; font-weight: bold; color: #9C6B4F;"> 리워드 조건이 충족되었습니다</p>
    <p style="margin-top: 10px; font-size: 16px; color: #2E2E2E;">15,000원 이상 기부로 리워드 수령 조건이 충족되었습니다.<br>지금 리워드를 선택하고 마을의 특산품을 받아 보세요!</p>
    <button onclick="goToReward()" style="margin-top: 20px; background-color: #9c6b4f; color: #fff; border: none; padding: 10px 30px; border-radius: 10px; font-size: 16px;">확인</button>
  </div>
</div>


<script>
  // 페이지 로드 시, 기본 금액 선택 표시 (10000원)
  $(document).ready(function() {
    // 테이블의 10,000원 td를 찾아서 selected-amount 클래스 추가
    $('.amount-table td[data-amount="10000"]').addClass('selected-amount');
    // 실제 결제 금액 input에도 초기값 설정
    $('#amount_for_payment').val(10000);
  });

  // td 클릭 이벤트 핸들러
  $('.amount-table td').on('click', function() {
    // 모든 td에서 selected-amount 클래스 제거
    $('.amount-table td').removeClass('selected-amount');

    // 직접 입력 input 초기화 및 비활성화
    $('#direct_amount_input').val('').prop('readonly', true);

    // 클릭된 td에 selected-amount 클래스 추가
    $(this).addClass('selected-amount');

    // 클릭된 td의 data-amount 값을 amount_for_payment input에 설정
    const selectedAmount = $(this).data('amount');
    if (selectedAmount) { // data-amount가 있는 경우 (고정 금액 버튼)
      $('#amount_for_payment').val(selectedAmount);
    } else { // 직접 입력 칸이 있는 td를 클릭한 경우
        // 직접 입력 input을 활성화하고 포커스
        $('#direct_amount_input').prop('readonly', false).focus();
        // 직접 입력이 선택되면, 실제 결제 금액은 비워둠 (사용자 입력 대기)
        $('#amount_for_payment').val('');
    }
  });

  // 직접 입력 input 값 변경 이벤트 핸들러
  $('#direct_amount_input').on('input', function() {
    // 직접 입력 시, 고정 금액 선택 해제 (CSS 클래스 제거)
    $('.amount-table td').removeClass('selected-amount');
    // 직접 입력 input이 속한 td에 selected-amount 클래스 추가 (선택 상태 유지)
    $(this).closest('td').addClass('selected-amount');

    const directValue = $(this).val();
    if (directValue === "") {
      $('#amount_for_payment').val(0); // 비어있으면 0으로 설정
    } else {
      const parsedValue = parseInt(directValue);
      if (!isNaN(parsedValue)) {
        $('#amount_for_payment').val(parsedValue);
      } else {
        $('#amount_for_payment').val(0); // 유효하지 않은 숫자면 0으로 설정
      }
    }
  });

  // 뱃지 모달을 보여주는 함수
function showBadgeModal(message, callback) {
  const modalContainer = document.getElementById('modalContainer');
  const badgeModal = document.getElementById('badgeModal');
  const body = document.body;

  if (modalContainer && badgeModal && body) {
    // 메시지 적용
    $('#badgeMessage').text(message || "뱃지가 발급되었습니다.");

    modalContainer.style.display = 'flex';
    badgeModal.style.display = 'block';
    body.classList.add('modal-open');

    // 버튼 클릭 시 모달 닫고 콜백 실행
    const confirmBtn = badgeModal.querySelector('button');
    confirmBtn.onclick = function () {
      modalContainer.style.display = 'none';
      badgeModal.style.display = 'none';
      body.classList.remove('modal-open');
      if (callback) callback(); // ✅ 콜백이 있으면 실행
      else location.href = "/donation/list.do";
    };
  }
}

//리워드 모달 열기
  function showRewardModal() {
    document.getElementById("rewardContainer").style.display = "flex";
    document.body.classList.add("modal-open");
  }

  // 리워드 페이지로 이동
function goToReward() {
  const amount = document.getElementById("amount_for_payment").value;
  
//현재 URL에서 content_id를 추출
  const urlParams = new URLSearchParams(window.location.search);
  const contentId = urlParams.get('content_id');

  location.href = "/donation/reward/select.do?amount=" + amount + "&content_id=" + contentId;
}




  function requestPay() {
      let money = parseInt(document.getElementById("amount_for_payment").value); // money를 숫자로 파싱
      let check1 = document.getElementById("check1");
      let check2 = document.getElementById("check2");
      // HTML에서 id="email_receipt_checkbox"로 변경했으므로 여기에 반영
      let emailCheckbox = document.getElementById("email_receipt_checkbox");
      
      
      let buyerEmail = document.getElementById("buyer_email").value.trim(); 
      let buyerName = document.getElementById("buyer_name").value;

      if (isNaN(money) || money <= 0) { // 숫자가 아니거나 0 이하일 경우
          alert("유효한 금액을 선택하거나 입력해주세요.");
          return;
      } else if (!check1.checked || !check2.checked) {
          alert("필수사항에 동의해주세요.");
          return;
      }
      
   // 이메일 수신 체크박스가 선택되었을 때만 이메일 확인
      if (emailCheckbox.checked && !buyerEmail) {
          alert("이메일 주소를 입력해주세요.");
          return;
      }

      IMP.init("imp58115315");
      IMP.request_pay({
          pg: "kakaopay.TC0ONETIME",
          pay_method: "card",
          merchant_uid: "donation_" + new Date().getTime(),
          name: "${dto.title}",
          amount: money, // 이미 숫자로 파싱됨
          buyer_email: document.getElementById("buyer_email").value,
          buyer_name: document.getElementById("buyer_name").value,
      }, function(rsp) {
          if (rsp.success) {
        	  alert("결제가 완료되었습니다. 영수증 ID: " + rsp.imp_uid);
              fetch("/donation/payment/verify.do", {
                  method: "POST",
                  headers: { "Content-Type": "application/json" },
                  credentials: "include",
                  body: JSON.stringify({
                      content_id: ${dto.content_id},
                      amount: money, // 이미 숫자로 파싱됨
                      buyer_name: document.getElementById("buyer_name").value,
                      buyer_email: document.getElementById("buyer_email").value,
                      imp_uid: rsp.imp_uid,
                      merchant_uid: rsp.merchant_uid,
                      payment_method: rsp.pay_method,
                      status: "완료",
                   	  send_email: emailCheckbox.checked // 이메일 보내기 여부
                  })
              }).then(res => res.json())
               .then(data => {
  if (data.result === "success") {

    if (money >= 50000 && data.badge) {
      // 5만원 이상이면 뱃지 → 리워드 순으로
      showBadgeModal(data.badge, () => {
        showRewardModal();
      });

    } else if (money >= 15000) {
      // 1만 5천원 이상이면 일반 메시지 → 리워드
      showBadgeModal("후원해 주셔서 감사합니다.", () => {
        showRewardModal();
      });

    } else {
      // 그 외 금액은 기본 처리
      showBadgeModal("후원해 주셔서 감사합니다.");
    }

  } else {
    showBadgeModal(data.message || "후원 처리 중 오류가 발생했습니다. 다시 시도해주세요.");
  }
})


                .catch(error => {
                    console.error('Fetch error:', error);
                    showBadgeModal("결제 후 정보 저장 중 네트워크 오류가 발생했습니다. 관리자에게 문의해주세요.");
                });
          } else {
              alert("결제 실패: " + rsp.error_msg);
          }
      });
  }
</script>
</body>
</html>