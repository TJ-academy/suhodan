<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <meta charset="UTF-8">
  <title>후원 결제</title>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js" integrity="sha512-bLT0Qm9VnAYZDflyKcBaQ2gg0hSYNQrJ8RilYldYQ1FxQYoCLtUjuuRuZo+fjqhx/qtq/1itJ0C2ejDxltZVFg==" crossorigin="anonymous" type="text/javascript"></script>
  <script src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js" type="text/javascript"></script>
  <link rel="stylesheet" href="/css/donation_pay.css">
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
      <td><input type="number" id="direct_amount_input" placeholder="직접 입력"></td> 
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
    <input type="checkbox"> (선택) 이메일로 기부내역을 받겠습니다.
  </div>
  <button class="next_btn" onclick="requestPay()">결제하기</button>
</div>

<script>
  // 페이지 로드 시, 기본 금액 선택 표시 (10000원)
  $(document).ready(function() {
    // 테이블의 10,000원 td를 찾아서 selected-amount 클래스 추가
    $('.amount-table td[data-amount="10000"]').addClass('selected-amount');
    // 실제 결제 금액 input에도 초기값 설정 (JSP value="10000"과 동일하게)
    $('#amount_for_payment').val(10000);
  });

  // td 클릭 이벤트 핸들러
  $('.amount-table td').on('click', function() {
    // 모든 td에서 selected-amount 클래스 제거
    $('.amount-table td').removeClass('selected-amount');
    // 클릭된 td에 selected-amount 클래스 추가
    $(this).addClass('selected-amount');

    // 직접 입력 input 초기화 및 비활성화
    $('#direct_amount_input').val('').prop('readonly', true);

    // 클릭된 td의 data-amount 값을 amount_for_payment input에 설정
    const selectedAmount = $(this).data('amount');
    if (selectedAmount) { // data-amount가 있는 경우 (고정 금액 버튼)
      $('#amount_for_payment').val(selectedAmount);
    } else { // 직접 입력 칸을 클릭한 경우 (data-amount가 없는 경우)
      $('#direct_amount_input').prop('readonly', false).focus(); // 직접 입력 활성화 및 포커스
      $('#amount_for_payment').val(0); // 직접 입력이 선택되면 일단 0으로 설정
    }
  });

  // 직접 입력 input 값 변경 이벤트 핸들러
  $('#direct_amount_input').on('input', function() {
    // 직접 입력 시 모든 td에서 selected-amount 클래스 제거
    $('.amount-table td').removeClass('selected-amount');
    
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

  function requestPay() {
	  let money = document.getElementById("amount_for_payment").value;
	  let check1 = document.getElementById("check1");
	  let check2 = document.getElementById("check2");
	  if (money == 0 || money == null) {
	    alert("금액을 선택해주세요.");
	    return;
	  } else if (!check1.checked || !check2.checked) {
	    alert("필수사항에 동의해주세요.");
	    return;
	  }

	  IMP.init("imp58115315");
	  IMP.request_pay({
	    pg: "kakaopay.TC0ONETIME", // 연동된 PG사와 CID 참고
	    pay_method: "card",
	    merchant_uid: "donation_" + new Date().getTime(),
	    name: "${dto.title}",
	    amount: document.getElementById("amount_for_payment").value, // 변경된 부분: amount -> amount_for_payment
	    buyer_email: document.getElementById("buyer_email").value,
	    buyer_name: document.getElementById("buyer_name").value,
	  }, function(rsp) {
	    if (rsp.success) {
	      alert("결제가 완료되었습니다. 영수증 ID: " + rsp.imp_uid);

	      // 서버로 결제 정보 전송
	      fetch("/donation/payment/verify.do", {
	        method: "POST",
	        headers: {
	          "Content-Type": "application/json"
	        },
	        credentials: "include",
	        body: JSON.stringify({
	          content_id: ${dto.content_id},
	          amount: document.getElementById("amount_for_payment").value, // 변경된 부분: amount -> amount_for_payment
	          buyer_name: document.getElementById("buyer_name").value,
	          buyer_email: document.getElementById("buyer_email").value,
	          imp_uid: rsp.imp_uid,
	          merchant_uid: rsp.merchant_uid,
	          payment_method: rsp.pay_method,
	          status: "완료" // 성공 시 '완료'
	        })
	      }).then(res => res.json())
	      .then(data => {
	        if (data.result === "success") {
	          // 5만원 이상 결제 후 뱃지 발급 시 메시지
	          if (data.badge) {
	            alert(data.badge); // "서천군 뱃지가 발급되었습니다." 팝업
	          } else {
	            alert("후원이 정상적으로 처리되었습니다.");
	          }
	          location.href = "/donation/list.do";
	        } else {
	          alert("서버 저장 중 오류 발생");
	        }
	      });
	    } else {
	      alert("결제 실패: " + rsp.error_msg);
	    }
	  });
	}


</script>
</body>
</html>
