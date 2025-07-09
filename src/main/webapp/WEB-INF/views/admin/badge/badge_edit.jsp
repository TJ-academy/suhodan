<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="edit_popup" class="popup">
	<h3>명패 수정</h3>
	<form action="badge_update.do" method="post"
		enctype="multipart/form-data">
		<div class="form-item">
			<label for="edit_popup_name">명패 이름</label> <input type="text"
				id="edit_popup_name" name="name" required />
		</div>
		
		<div class="form-item">
			<label for="edit_popup_description">설명</label>
			<textarea id="edit_popup_description" name="description" rows="4" required></textarea>
		</div>

		<div class="form-item">
			<label for="edit_popup_img">이미지</label>
			<input type="file" id="edit_popup_img" name="imgFile" accept="image/*" />
			<!-- 현재 이미지 출력 -->
			<div id="current_image_container" style="display:none;">
				<label>현재 이미지: <span id="current_image_name"></span></label>
				<img id="current_image" src="" alt="배지 이미지" width="100" />
			</div>
		</div>

		<input type="hidden" id="edit_popup_badge_id" name="badge_id" />

		<button type="submit" class="button">수정</button>
		<button type="button" class="button close-edit-popup">닫기</button>
	</form>
</div>