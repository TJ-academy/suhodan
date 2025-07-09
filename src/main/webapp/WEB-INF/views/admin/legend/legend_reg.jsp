<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="reg_popup" class="popup">
	<h3>설화 등록</h3>
	<form action="legend_insert.do" method="post"
		enctype="multipart/form-data">
		<div class="form-item">
			<label for="reg_popup_title">설화 제목</label> <input type="text"
				id="reg_popup_title" name="title" required />
		</div>

		<div class="form-item">
			<label for="reg_popup_location">지역 입력</label> <input type="text"
				id="reg_popup_location" name="location" required />
		</div>

		<div class="form-item">
			<label for="reg_popup_content">설화 내용</label>
			<textarea id="reg_popup_content" name="story" rows="4" required></textarea>
		</div>

		<div class="form-item">
			<label for="reg_popup_source">설화 출처</label> <input type="text"
				id="reg_popup_source" name="source" required />
		</div>

		<div class="form-item">
			<label for="reg_popup_img">이미지 업로드</label> <input type="file"
				id="reg_popup_img" name="imgFile" accept="image/*" />
		</div>

		<div class="form-item">
			<label for="reg_popup_tts_audio">TTS 오디오</label> <input type="file"
				id="reg_popup_tts_audio" name="ttsAudioFile" accept="audio/*" />
		</div>

		<button type="submit" class="button">등록</button>
		<button type="button" class="button close-reg-popup">닫기</button>
		<%-- 닫기 버튼 class 추가 --%>
	</form>
</div>
<%-- legend_reg.jsp 내용 끝 --%>