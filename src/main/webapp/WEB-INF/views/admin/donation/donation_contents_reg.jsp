<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="reg_popup" class="popup">
	<h3>기부 프로젝트 등록</h3>
	<form action="donation_contents_insert.do" method="post"
		enctype="multipart/form-data">
		<div class="form-item">
			<label for="reg_popup_title">제목</label> <input type="text"
				id="reg_popup_title" name="title" required />
		</div>
		
		<div class="form-item">
			<label for="reg_popup_content">내용</label>
			<textarea id="reg_popup_content" name="content" rows="4" required></textarea>
		</div>

		<label for="reg_popup_target_amount">목표 금액</label>
			<div class="price-container">
				<input type="number" id="reg_popup_target_amount"
					name="target_amount" required /> <span class="currency">원</span>
			</div>
		
		<div class="form-item">
			<label for="reg_popup_start_date">시작일</label> <input type="date"
				id="reg_popup_start_date" name="start_date" required />
		</div>
		 
		 <div class="form-item">
			<label for="reg_popup_end_date">마감일</label> <input type="date"
				id="reg_popup_end_date" name="end_date" required />
		</div>
		
		<div class="form-item">
			<label for="reg_popup_location">지역</label> <input type="text"
				id="reg_popup_location" name="location" required />
		</div>

		<div class="form-item">
			<label for="reg_popup_filename">이미지</label> <input type="file"
				id="reg_popup_img" name="file1" accept="image/*" />
		</div>

		<button type="submit" class="button">등록</button>
		<button type="button" class="button close-reg-popup">닫기</button>
	</form>
</div>