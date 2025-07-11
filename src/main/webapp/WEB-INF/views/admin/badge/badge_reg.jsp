<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="reg_popup" class="popup">
	<h3>명패 등록</h3>
	<form action="badge_insert.do" method="post"
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

		<button type="submit" class="button">등록</button>
		<button type="button" class="button close-reg-popup">닫기</button>
	</form>
</div>