<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="edit_popup" class="popup">
	<h3>기부 프로젝트 수정</h3>
	<form action="donation_contents_update.do" method="post"
		enctype="multipart/form-data">
		<div class="form-item">
			<label for="edit_popup_title">제목</label> <input type="text"
				id="edit_popup_title" name="title" required />
		</div>

		<div class="form-item">
			<label for="edit_popup_content">내용</label>
			<textarea id="edit_popup_content" name="content" rows="4" required></textarea>
		</div>

		<div class="form-item">
			<label for="edit_popup_target_amount">목표 금액</label>
			<div class="price-container">
				<input type="number" id="edit_popup_target_amount"
					name="target_amount" required /> <span class="currency">원</span>
			</div>
		</div>

		<div class="form-item">
			<label for="edit_popup_start_date">시작일</label> <input type="date"
				id="edit_popup_start_date" name="start_date" required />
		</div>

		<div class="form-item">
			<label for="edit_popup_end_date">마감일</label> <input type="date"
				id="edit_popup_end_date" name="end_date" required />
		</div>

		<div class="form-item">
			<label for="edit_popup_location">지역</label> <input type="text"
				id="edit_popup_location" name="location" required />
		</div>
		<div class="form-item">
			<label for="edit_popup_filename">이미지</label> <input type="file"
				id="edit_popup_filename" name="File1" accept="image/*" />
			<!-- 현재 이미지 출력 -->
			<div id="current_image_container" style="display: none;">
				<label>현재 이미지: <span id="current_image_name"></span></label> <img
					id="current_image" src="" alt="기부 이미지" width="100" />
			</div>
		</div>

		<input type="hidden" id="edit_popup_content_id" name="content_id" />

		<button type="submit" class="button">수정</button>
		<button type="button" class="button close-edit-popup">닫기</button>
	</form>
</div>