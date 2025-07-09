<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="edit_popup" class="popup">
	<h3>설화 수정</h3>
	<form action="legend_update.do" method="post"
		enctype="multipart/form-data">
		<div class="form-item">
			<label for="edit_popup_title">설화 제목</label> <input type="text"
				id="edit_popup_title" name="title" required />
		</div>

		<div class="form-item">
			<label for="edit_popup_location">지역 입력</label> <input type="text"
				id="edit_popup_location" name="location" required />
		</div>

		<div class="form-item">
			<label for="edit_popup_content">설화 내용</label>
			<textarea id="edit_popup_content" name="story" rows="4" required></textarea>
		</div>

		<div class="form-item">
			<label for="edit_popup_source">설화 출처</label> <input type="text"
				id="edit_popup_source" name="source" required />
		</div>

		<div class="form-item">
			<label for="edit_popup_img">대표 이미지</label> <input type="file"
				id="edit_popup_img" name="imgFile" accept="image/*" />
			<!-- 현재 이미지 출력 -->
			<div id="current_image_container" style="display: none;">
				<label>현재 이미지: <span id="current_image_name"></span></label> <img id="current_image" src="" alt="설화 이미지"
					width="100" />
			</div>
		</div>

		<div class="form-item">
			<label for="edit_popup_tts_audio">오디오 파일</label> <input type="file"
				id="edit_popup_tts_audio" name="ttsAudioFile" accept="audio/*" />
			<div id="current_tts_audio_container" style="display: none;">
				<label>현재 오디오: <span id="current_tts_audio_name"></span></label> <img id="current_tts_audio" src=""
					alt="오디오 파일" width="100" />
			</div>
		</div>

		<input type="hidden" id="edit_popup_legend_id" name="legend_id" />

		<button type="submit" class="button">수정</button>
		<button type="button" class="button close-edit-popup">닫기</button>
	</form>
</div>