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
			<label for="edit_popup_img">이미지 업로드</label> <input type="file"
				id="edit_popup_img" name="img" accept="image/*"
				onchange="previewImage(event)" /> <br /> <img id="imagePreview"
				src="" alt="이미지 미리보기"
				style="max-width: 200px; display: none; margin-top: 10px;" />
		</div>

		<div class="form-item">
			<label for="edit_popup_tts_audio">TTS 오디오</label> <input type="file"
				id="edit_popup_tts_audio" name="tts_audio" accept="audio/*"
				onchange="previewAudio(event)" /> <br />
			<audio id="audioPreview" controls
				style="display: none; margin-top: 10px;">
				<source id="audioSource" type="audio/mp3">
				Your browser does not support the audio element.
			</audio>
			<button type="button" id="playButton" style="display: none;"
				onclick="playAudio()">🔊</button>
		</div>

		<input type="hidden" id="edit_popup_legend_id" name="legend_id" />

		<button type="submit" class="button">수정</button>
		<button type="button" class="button close-edit-popup">닫기</button>
		<%-- 닫기 버튼 class 추가 --%>
	</form>
</div>

<script>
	// 이미지 미리보기 함수
	function previewImage(event) {
		const file = event.target.files[0];
		const reader = new FileReader();

		reader.onload = function(e) {
			const imagePreview = document.getElementById('imagePreview');
			imagePreview.src = e.target.result; // 파일의 URL을 미리보기 이미지에 설정
			imagePreview.style.display = 'block'; // 이미지 미리보기 표시
		}

		if (file) {
			reader.readAsDataURL(file); // 파일을 DataURL로 읽어 들여 이미지 미리보기 생성
		}
	}

	// 오디오 미리듣기 함수
	function previewAudio(event) {
		const file = event.target.files[0];
		const audioPreview = document.getElementById('audioPreview');
		const audioSource = document.getElementById('audioSource');
		const playButton = document.getElementById('playButton');

		if (file) {
			const audioUrl = URL.createObjectURL(file); // 오디오 파일 URL 생성
			audioSource.src = audioUrl; // 오디오 소스에 URL 할당
			audioPreview.style.display = 'block'; // 오디오 미리듣기 표시
			playButton.style.display = 'inline'; // 재생 버튼 표시
		}
	}

	// 오디오 재생 함수
	function playAudio() {
		const audioPreview = document.getElementById('audioPreview');
		audioPreview.play(); // 오디오 미리듣기 시작
	}
</script>