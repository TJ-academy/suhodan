<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="edit_popup" class="popup">
	<h3>상품 수정</h3>
	<form action="goods_update.do" method="post"
		enctype="multipart/form-data">
		<div class="form-item">
			<label for="edit_popup_location">지역</label> <input type="text"
				id="edit_popup_location" name="location" required />
		</div>

		<div class="form-item">
			<label for="edit_popup_name">상품명</label> <input type="text"
				id="edit_popup_name" name="name" required />
		</div>

		<div class="form-item">
			<label for="edit_popup_price">가격</label>
			<div class="price-container">
				<input type="number" id="edit_popup_price" name="price" required />
				<span class="currency">원</span>
			</div>
		</div>

		<div class="form-item">
			<label for="edit_popup_description">설명</label>
			<textarea id="edit_popup_description" name="description" rows="4"
				required></textarea>
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

		<div class="form-item">
			<label for="edit_popup_detail_img">상세 이미지</label> <input type="file"
				id="edit_popup_detail_img" name="detailImgFile" accept="image/*" />
			<!-- 현재 이미지 출력 -->
			<div id="current_detail_image_container" style="display: none;">
				<label>현재 상세 이미지: <span id="current_detail_image_name"></span></label>
				<img id="current_detail_image" src="" alt="상품 상세 이미지" width="100" />
			</div>
		</div>

		<input type="hidden" id="edit_popup_goods_id" name="goods_id" />

		<button type="submit" class="button">수정</button>
		<button type="button" class="button close-edit-popup">닫기</button>
	</form>
</div>