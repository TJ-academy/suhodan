<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="edit_popup" class="popup">
	<h3>명패 수정</h3>
	<form action="badge_update.do" method="post"
		enctype="multipart/form-data">
		<div class="form-item">
			<label for="reg_popup_name">명패 이름</label> <input type="text"
				id="reg_popup_name" name="name" required />
		</div>
		
		<div class="form-item">
			<label for="reg_popup_description">설명</label>
			<textarea id="reg_popup_description" name="description" rows="4" required></textarea>
		</div>

		<div class="form-item">
			<label for="reg_popup_img">이미지</label> <input type="file"
				id="reg_popup_img" name="imgFile" accept="image/*" />
		</div>

		<input type="hidden" id="edit_popup_badge_id" name="badeg_id" />

		<button type="submit" class="button">수정</button>
		<button type="button" class="button close-edit-popup">닫기</button>
	</form>
</div>