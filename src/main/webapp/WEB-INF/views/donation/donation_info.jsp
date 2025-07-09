<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.info_container {
		width: 841px;
		height: auto;
		background: #F5F1EB;
		margin: 0 auto;
		border-radius: 20px;
		border-color: #D8C2A6;
		margin-top: 50px;
		padding: 40px;
	}
	.img_style {
		text-align: center;
	}
	.text_style {
		font-size: 17px;
		text-align: center;
		color: #2E2E2E;
		margin: 20px 0 40px 0;
	}
	.checkbox_con {
		text-align:center;
	}
	.next_btn {
		width: 474px;
		height: 68px;
		border-radius: 20px;
		background: #9C6B4F;
		color: white;
		font-size: 24px;
		text-align: center;
		font-weight: 700;
		line-height: 60px;
		display: block;
		margin: 0 auto;
		margin-top: 30px;
		border-color: #9C6B4F;
	}
	.next_btn:hover {
		background: #5E2200;
	}
</style>
</head>
<body>
<%@include file="../include/menu.jsp" %>
<div class="info_container">
	<div class="img_style">
		<img src="../../resources/images/tree.PNG" width="110px" height="83px">
	</div>
	<p class="text_style">
		<strong>기부 진행 전 반드시 확인해 주세요</strong><br>
	   《설화守》는 2025 K-디지털 트레이닝 해커톤 프로젝트의 일환으로 제작된<br>
	    비영리 체험형 웹서비스입니다.<br>
		본 플랫폼을 통해 이루어지는 모든 기부 행위는 실제 금전 거래가 아닌 가상 기부 흐름 체험으로 간주됩니다.<br>
		<br>
		<strong>📌주요 안내사항</strong><br>
		º 본 플랫폼은 실제 공익단체나 기부단체가 아닌 개인 개발팀 프로젝트입니다.<br>
		º 현금영수증, 기부금 영수증, 세금공제 등은 발급되지 않습니다.<br>
		º 기부 후에는 환불이 불가능하며, 기부 내역은 실물 경제에 영향을 미치지 않습니다.<br>
		º 사용자가 입력한 기부 금액 및 정보는 서비스 체험 목적의 데이터로만 활용됩니다.<br>
		º 해당 내용에 동의하지 않을 경우 기부 기능을 이용하실 수 없습니다.<br>
	</p>
	<div class="checkbox_con">
		<input type="checkbox"> <strong>(필수) 위 내용을 충분히 이해하였으며, 기부 흐름 체험에 동의합니다.</strong><br>
		<input type="checkbox"> (선택) 기부 후기 알림 수신에 동의합니다.<br>
		<button class="next_btn" onclick="goDonate(${content_id})">다음으로</button>
	</div>
</div>
<script>
	function goDonate(contentId) {
		location.href = '/donation/pay.do?content_id=' + contentId;
	}
</script>
</body>
</html>