<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <meta charset="UTF-8">
  <title>후원 결제</title>
<!-- 제이쿼리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js" integrity="sha512-bLT0Qm9VnAYZDflyKcBaQ2gg0hSYNQrJ8RilYldYQ1FxQYoCLtUjuuRuZo+fjqhx/qtq/1itJ0C2ejDxltZVFg==" crossorigin="anonymous" type="text/javascript"></script>
<!-- 아임포트 -->
<script src ="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js" type="text/javascript"></script></head>
<body>
  <%@ include file="../include/menu.jsp" %>
  <h2>${dto.title} 후원하기</h2>
  <p>후원 캠페인: ${dto.title}</p>
  <p>후원 금액: <input type="number" id="amount" value="10000"> 원</p>
  <p>기부자 이름: <input type="text" id="buyer_name" value="${sessionScope.name}"></p>
  <p>이메일: <input type="text" id="buyer_email" placeholder="test@example.com"></p>
  <button onclick="requestPay()">결제하기</button>

  <script>
    function requestPay() {
      IMP.init("imp58115315");
      IMP.request_pay({
        pg: "kakaopay.TC0ONETIME", // 연동된 PG사와 CID 참고
        pay_method: "card",
        merchant_uid: "donation_" + new Date().getTime(),
        name: "${dto.title}",
        amount: document.getElementById("amount").value,
        buyer_email: document.getElementById("buyer_email").value,
        buyer_name: document.getElementById("buyer_name").value,
      }, function (rsp) {
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
   		      amount: document.getElementById("amount").value,
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
   		        alert("후원이 정상적으로 처리되었습니다.");
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
