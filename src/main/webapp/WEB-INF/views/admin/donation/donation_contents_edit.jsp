<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="edit_popup" class="popup">
	<h3>기부 프로젝트 수정</h3>
	<form action="donation_contents_update.do" method="post"
		enctype="multipart/form-data"> 
<!-- <form action="donation_contents_update.do" method="post"> -->		
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
			<label for="edit_popup_rewarda_name">만오천냥 리워드</label>
		</div>
		<div class="input-container">
			<input type="text" id="edit_popup_rewarda_name" name="rewarda_name" required />
			<img src="/resources/images/search-icon.png" id="edit_find_reward_button_1"
				class="search-icon" alt="Search" />
		</div>

		<div class="form-item">
            <label for="edit_popup_rewardb_name">삼만냥 리워드</label>
        </div>
        <div class="input-container">
            <input type="text" id="edit_popup_rewardb_name" name="rewardb_name" />
            <img src="/resources/images/search-icon.png" id="edit_find_reward_button_2" class="search-icon" alt="Search" />
        </div>

        <div class="form-item">
            <label for="edit_popup_rewardc_name">오만냥 리워드</label>
        </div>
        <div class="input-container">
            <input type="text" id="edit_popup_rewardc_name" name="rewardc_name" />
            <img src="/resources/images/search-icon.png" id="edit_find_reward_button_3" class="search-icon" alt="Search" />
        </div>

        <div class="form-item">
            <label for="edit_popup_rewardd_name">십만냥 리워드</label>
        </div>
        <div class="input-container">
            <input type="text" id="edit_popup_rewardd_name" name="rewardd_name" />
            <img src="/resources/images/search-icon.png" id="edit_find_reward_button_4" class="search-icon" alt="Search" />
        </div>
        
		<div class="form-item">
			<label for="edit_popup_filename">이미지</label> 
			<input type="file"
				id="edit_popup_filename" name="file1" accept="image/*" />
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

<script>
    // 팝업을 여는 공통 함수
    function openFindRewardPopup(targetInputId, popupName) {
        window.open('donation_content_find_reward.do?targetInputId=' + targetInputId, popupName, 'width=600,height=800');
    }

    document.getElementById('edit_find_reward_button_1').addEventListener('click', function() {
        openFindRewardPopup('edit_popup_rewarda_name', 'findRewardPopup1');
    });
    document.getElementById('edit_find_reward_button_2').addEventListener('click', function() {
        openFindRewardPopup('edit_popup_rewardb_name', 'findRewardPopup2');
    });
    document.getElementById('edit_find_reward_button_3').addEventListener('click', function() {
        openFindRewardPopup('edit_popup_rewardc_name', 'findRewardPopup3');
    });
    document.getElementById('edit_find_reward_button_4').addEventListener('click', function() {
        openFindRewardPopup('edit_popup_rewardd_name', 'findRewardPopup4');
    });
</script>