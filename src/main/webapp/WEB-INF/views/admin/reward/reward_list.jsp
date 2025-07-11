<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리워드 관리</title>
<link rel="stylesheet" href="/css/admin.css">
<link rel="stylesheet" href="/css/popup.css">
</head>
<body>
	<%@ include file="../../include/admin_menu.jsp"%>
	<div class="header-container">
		<h2>리워드 관리</h2>
		<button id="addButton">추가하기</button>
	</div>
	<br>
	<table border="1" width="700px">
		<tr>
			<td>No.</td>
			<td>이름</td>
			<td>금액 구간</td>
			<td>구성상품 1</td>
			<td>구성상품 2</td>
			<td>구성상품 3</td>
			<td>구성상품 4</td>
			<td>상태 관리</td>
		</tr>
		<c:if test="${not empty list}">
			<c:forEach var="row" items="${list}">
				<tr>
					<td>${row.reward_id}</td>
					<td>${row.name}</td>
					<td><c:choose>
							<c:when test="${row.price_type == 'a'}">15,000원 이상 30,000원 미만</c:when>
							<c:when test="${row.price_type == 'b'}">30,000원 이상 50,000원 미만</c:when>
							<c:when test="${row.price_type == 'c'}">50,000원 이상 100,000원 미만</c:when>
							<c:when test="${row.price_type == 'd'}">100,000원 이상</c:when>
						</c:choose></td>
					<td>${row.goods_1}</td>
					<td>${row.goods_2}</td>
					<td>${row.goods_3}</td>
					<td>${row.goods_4}</td>
					<td>
						<%-- 수정 버튼: onclick 대신 class와 data-* 속성 사용 --%>
						<button class="edit-button" data-reward-id="${row.reward_id}"
							data-name="${row.name}" data-description="${row.description}"
							data-price-type="${row.price_type}" data-img="${row.img}"
							data-goods-1="${row.goods_1}" data-goods-2="${row.goods_2}"
							data-goods-3="${row.goods_3}" data-goods-4="${row.goods_4}">수정</button>
						<button class="delete-button" data-reward-id="${row.reward_id}">삭제</button>
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
	<%@ include file="../../include/admin_paging.jsp"%>

	<div id="overlay" class="overlay"></div>

	<%@ include file="reward_reg.jsp"%>
	<%@ include file="reward_edit.jsp"%>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		$(document)
				.ready(
						function() {
							function openRegPopup() {
								$('#reg_popup').show();
								$('#overlay').show();
								$('#reg_popup_name').val('');
								$('#reg_popup_description').val('');
								$('#reg_popup_price_type').val('');
								$('#reg_popup_goods_1').val('');
								$('#reg_popup_goods_2').val('');
								$('#reg_popup_goods_3').val('');
								$('#reg_popup_goods_4').val('');
								$('#reg_popup_img').val('');
							}

							function closeRegPopup() {
								$('#reg_popup').hide();
								$('#overlay').hide();
							}

							function openEditPopup(rewardId, name, description,
									priceType, goods1, goods2, goods3, goods4,
									img) {

								$('#edit_popup').show();
								$('#overlay').show();
								$('#edit_popup_reward_id').val(rewardId);
								$('#edit_popup_name').val(name);
								$('#edit_popup_description').val(description);
								$('#edit_popup_price_type').val(priceType);
								$('#edit_popup_goods_1').val(goods1);
								$('#edit_popup_goods_2').val(goods2);
								$('#edit_popup_goods_3').val(goods3);
								$('#edit_popup_goods_4').val(goods4);
								$('#edit_popup_img').val('');

								if (img) {
									$('#current_image_container').show(); // 기존 이미지 컨테이너를 보이게 함
									$('#current_image').attr('src',
											'/resources/reward_img/' + img); // 기존 이미지 경로 설정
									$('#current_image_name').text(img); // 파일명 텍스트로 설정
								} else {
									$('#current_image_container').hide(); // 이미지가 없다면 숨김
								}
							}

							function closeEditPopup() {
								$('#edit_popup').hide();
								$('#overlay').hide();
							}

							function reward_delete(reward_id) {
								if (confirm("리워드을 삭제하시겠습니까?")) {
									window.location.href = "reward_delete.do?reward_id="
											+ reward_id;
								}
							}

							$('#addButton').on('click', openRegPopup);
							$('#overlay').on('click', function() {
								closeRegPopup();
								closeEditPopup();
							});
							$('.close-reg-popup').on('click', closeRegPopup);
							$('.close-edit-popup').on('click', closeEditPopup);
							$('table').on(
									'click',
									'.edit-button',
									function() {
										const rewardId = $(this).data(
												'reward-id');
										const name = $(this).data('name');
										const priceType = $(this).data(
												'price-type');
										const description = $(this).data(
												'description');
										const goods1 = $(this).data('goods-1');
										const goods2 = $(this).data('goods-2');
										const goods3 = $(this).data('goods-3');
										const goods4 = $(this).data('goods-4');
										const img = $(this).data('img');
										openEditPopup(rewardId, name,
												description, priceType, goods1,
												goods2, goods3, goods4, img);

									});

							$('table').on(
									'click',
									'.delete-button',
									function() {
										const rewardId = $(this).data(
												'reward-id');
										reward_delete(rewardId);
									});
						});
	</script>
</body>
</html>