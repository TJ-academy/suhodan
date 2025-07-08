<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="reg_popup" class="popup">
	<h3>상품 등록</h3>
	<form action="goods_insert.do" method="post"
		enctype="multipart/form-data">
		<div class="form-item">
			<label for="reg_popup_location">지역 입력</label> <input type="text"
				id="reg_popup_location" name="location" required />
		</div>

		<div class="form-item">
			<label for="reg_popup_name">이름</label> <input type="text"
				id="reg_popup_name" name="name" required />
		</div>

		<div class="form-item">
			<label for="reg_popup_price">가격</label> <input type="text"
				id="reg_popup_price" name="price" required />
		</div>
		
		<div class="form-item">
			<label for="reg_popup_description">내용</label>
			<textarea id="reg_popup_description" name="description" rows="4" required></textarea>
		</div>

		<div class="form-item">
			<label for="reg_popup_img">대표 이미지</label> <input type="file"
				id="reg_popup_img" name="imgFile" accept="image/*" />
		</div>

		<div class="form-item">
			<label for="reg_popup_detail_img">상세 이미지</label> <input type="file"
				id="reg_popup_detail_img" name="detailImgFile" accept="image/*" />
		</div>

		<button type="submit" class="button">등록</button>
		<button type="button" class="button close-reg-popup">닫기</button>
	</form>
</div>