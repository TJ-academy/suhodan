<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${dto.title}</title>
<style>
body {
	background-color: #fdf4ec;
	font-family: 'Noto Sans KR', sans-serif;
	margin: 0;
	padding: 0;
}

.outer-box {
	max-width: 1000px;
	margin: 50px auto;
	background-color: #F5F1EB;
	border: 1px solid #D8C2A6;
	border-radius: 20px;
	padding: 50px;
	position: relative;
}

.back-button {
	position: absolute;
	top: 50px; left: 50px;
	display: flex;
	align-items: center;
	background-color: transparent;
	border: none;
	color: #3e2d17;
	font-size: 16px;
	cursor: pointer;
	transform: scaleX(-1);
}

.back-button img {
	width: 15px;
	height: 25px;
	margin-top: 40px;
}

.title {
	font-size: 32px;
	font-weight: bold;
	color: #2E2E2E;
	text-align: center;
	margin-top: 40px;
}

.subtitle {
	font-size: 17px;
	color: #2E2E2E;
	margin-bottom: 50px;
}

.legend-img {
    position: relative;
    width: 100%;
    max-width: 900px;
    height: 500px;  /* 이미지 높이 설정 */
    margin: 90px auto 40px;
    text-align: center;
}

.image-container {
    position: relative;
    width: 100%;
    height: 100%;
}

.legend-img img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

audio {
    position: absolute;
    bottom: 20px; /* 아래에서 20px 떨어지게 설정 */
    right: 20px; /* 오른쪽에서 20px 떨어지게 설정 */
    padding: 10px;
    border-radius: 8px;
}


.divider-line {
	border: none;
	border-top: 2px solid #C4C4C4;
	width: 80%;
	margin: 40px auto 20px;
}

.story {
	font-size: 15px;
	color: #2F2F2F;
	line-height: 1.8;
	text-align: left;
	white-space: pre-line;
}

.btn-donate {
	margin-top: 40px;
	background-color: #D9C2AD;
	color: white;
	border: none;
	padding: 12px 150px;
	font-size: 19px;
	border-radius: 8px;
	cursor: pointer;
	transition: background-color 0.3s ease;
	text-decoration: none;
	display: block;
	width: 50%; /* Adjust the width for better centering */
	margin-left: auto;
	margin-right: auto;
	text-align: center;
}

.btn-donate:hover {
	background-color: #9C6B4F;
}

/* 모달 전체 박스 */

.modal-dialog {
    display: flex;
    align-items: center;
    justify-content: center;
    min-height: 100vh; /* 화면 전체 높이 기준 수직 정렬 */
}

.modal-content {
    background-color: #F5F1EB !important;
    border-radius: 15px !important;
    border: 1px solid #D8C2A6 !important;
    padding: 20px !important;
}


/* 모달 헤더 */
.modal-header {
    background-color: transparent;
    border-bottom: 1px solid #D8C2A6;
    padding-bottom: 10px;
    margin-bottom: 10px;
    justify-content: center;
}

/* 타이틀 텍스트 */
.modal-title {
    font-size: 20px;
    font-weight: 700;
    color: #9C6B4F;
    width: 100%; 
    text-align: center; 
    white-space: nowrap; 
}



/* 모달 하단 버튼 */
.modal-footer {
    border-top: none;
    text-align: center;
    padding-top: 20px;
}

.modal-footer .btn-secondary {
    background-color: #D9C2AD;
    border: none;
    color: white;
    font-size: 16px;
    padding: 10px 30px;
    border-radius: 8px;
    transition: background-color 0.3s ease;
    margin: 0 auto;
}

.modal-footer .btn-secondary:hover {
    background-color: #9C6B4F;
}


</style>
</head>
<body>

<%@ include file="../include/menu.jsp" %>

	<div class="outer-box">
	<button class="back-button" onclick="history.back();">
		<img src="/resources/suhodan_images/icon/arrow_right.png" alt="뒤로가기 아이콘">
	</button>
	<div class="title">${dto.title}</div>

	<div class="legend-img">

    <!-- 배경 이미지 -->
    <div class="image-container">
        <img src="/resources/legend_img/${dto.img}" alt="설화 이미지" onerror="this.onerror=null; this.src='/resources/images/설화수 로고.png';">
        <!-- MP3 아이콘 -->
        <audio controls autoplay>
            <source src="/resources/legend_tts/${dto.tts_audio}" type="audio/mp3">

        </audio>

    </div>
</div>
<hr class="divider-line">
	<!-- 설화 본문 -->
	<div class="story">${dto.story}</div>

	<!--
	<a href="/donation/info/${dto.legend_id}" class="btn-donate">후원하기</a>
	-->
	<!-- 부트스트랩 모달 트리거 버튼 -->
	<!-- data-location 속성에 ${dto.location} 값을 넣어줘서 JavaScript에서 사용할 수 있게 함 -->
	<button type="button" class="btn-donate" data-bs-toggle="modal"
	        data-bs-target="#donationBootstrapModal" data-location="${dto.location}">
	  후원하기
	</button>
</div>
<!-- --- 부트스트랩 모달 HTML 구조 시작 --- -->
<div class="modal fade" id="donationBootstrapModal" tabindex="-1" aria-labelledby="donationModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="donationModalLabel">
        	<!-- 모달 제목도 동적으로 변경될 수 있도록 수정 -->
        	로딩 중..
        </h5>
        
      </div>
      <div class="modal-body" id="modalDonationListContent">
        <!-- 여기에 기부 리스트 내용이 Ajax로 로드될 예정입니다. -->
        <p>내용을 불러오는 중...</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <!-- 필요하다면 여기에 다른 버튼 추가 가능 -->
      </div>
    </div>
  </div>
</div>
<!-- --- 부트스트랩 모달 HTML 구조 끝 --- -->
<script>
// DOMContentLoaded 이벤트는 HTML 문서가 완전히 로드되고 파싱되었을 때 실행됩니다.
// 부트스트랩 JS가 로드된 후에 실행되도록 합니다.
document.addEventListener('DOMContentLoaded', function() {
    // 모달 요소를 가져옵니다.
    const donationModal = document.getElementById('donationBootstrapModal');
    // 모달 바디에 내용을 삽입할 요소를 가져옵니다.
    const modalBodyContent = document.getElementById('modalDonationListContent');
    // 모달 제목 요소를 가져옵니다.
    const modalTitle = document.getElementById('donationModalLabel');

    // 부트스트랩 모달이 열리기 직전(show.bs.modal)에 발생하는 이벤트를 감지합니다.
    donationModal.addEventListener('show.bs.modal', function (event) {
        // 모달을 트리거한 버튼 요소를 가져옵니다. (여기서는 '후원하기' 버튼)
        const button = event.relatedTarget;
        // 버튼의 data-location 속성에서 지역 정보를 추출합니다.
        const legendLocation = button.getAttribute('data-location');

        modalTitle.textContent = legendLocation + '에 필요한 도움이에요.';

        // 모달 내용 영역에 로딩 메시지를 표시합니다.
        modalBodyContent.innerHTML = '<p>내용을 불러오는 중...</p>';

        // Ajax 요청을 수행합니다. (fetch API 사용)
        // **수정된 부분:** 자바스크립트 문자열 연결 방식으로 변경
        fetch('/legend/donationListPopup?location=' + encodeURIComponent(legendLocation))
            .then(response => {
                // 응답이 성공적이지 않으면 에러를 발생시킵니다.
                if (!response.ok) {
                    throw new Error('네트워크 응답이 올바르지 않습니다.');
                }
                // 응답 본문을 텍스트(HTML) 형태로 가져옵니다.
                return response.text();
            })
            .then(html => {
                // 가져온 HTML을 모달 본문에 삽입합니다.
                modalBodyContent.innerHTML = html;
            })
            .catch(error => {
                // 에러 발생 시 콘솔에 로그를 출력하고, 모달에 에러 메시지를 표시합니다.
                console.error('모달 내용을 로드하는 중 오류 발생:', error);
                modalBodyContent.innerHTML = '<p style="color: red;">내용을 불러오지 못했습니다. 다시 시도해주세요.</p>';
            });
    });
});
</script>

</body>
</html>