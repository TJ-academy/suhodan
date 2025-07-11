<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="edit_popup" class="popup">
	<h3>리워드 수정</h3>
	<form action="reward_update.do" method="post"
		enctype="multipart/form-data">
		<div class="form-item">
			<label for="edit_popup_name">리워드명</label> <input type="text"
				id="edit_popup_name" name="name" required />
		</div>

		<div class="form-item">
			<label for="edit_popup_description">설명</label>
			<textarea id="edit_popup_description" name="description" rows="4"
				required></textarea>
		</div>

		<div class="form-item">
			<label for="reg_popup_price_type">가격 구간</label> <select
				id="reg_popup_price_type" name="price_type" required>
				<option value="a" ${reg_popup_price_type == 'a' ? 'selected' : ''}>15,000원
					이상 30,000원 미만</option>
				<option value="b" ${reg_popup_price_type == 'b' ? 'selected' : ''}>30,000원
					이상 50,000원 미만</option>
				<option value="c" ${reg_popup_price_type == 'c' ? 'selected' : ''}>50,000원
					이상 100,000원 미만</option>
				<option value="d" ${reg_popup_price_type == 'd' ? 'selected' : ''}>100,000원
					이상</option>
			</select>
		</div>

		<div class="form-item">
			<label for="edit_popup_goods_1">상품 구성1</label> <input type="text"
				id="edit_popup_goods_1" name="goods_1" required />
		</div>

		<div class="form-item">
			<label for="edit_popup_goods_2">상품 구성2</label> <input type="text"
				id="edit_popup_goods_2" name="goods_2" required />
		</div>

		<div class="form-item">
			<label for="edit_popup_goods_3">상품 구성3</label> <input type="text"
				id="edit_popup_goods_3" name="goods_3" required />
		</div>

		<div class="form-item">
			<label for="edit_popup_goods_4">상품 구성4</label> <input type="text"
				id="edit_popup_goods_4" name="goods_4" required />
		</div>

		<div class="form-item">
			<label for="edit_popup_img">대표 이미지</label> <input type="file"
				id="edit_popup_img" name="imgFile" accept="image/*" />
			<!-- 현재 이미지 출력 -->
			<div id="current_image_container" style="display: none;">
				<label>현재 대표 이미지: <span id="current_image_name"></span></label> <img
					id="current_image" src="" alt="상품 대표 이미지" width="100" />
			</div>
		</div>

		<input type="hidden" id="edit_popup_goods_id" name="goods_id" />

		<button type="submit" class="button">수정</button>
		<button type="button" class="button close-edit-popup">닫기</button>
	</form>
</div>