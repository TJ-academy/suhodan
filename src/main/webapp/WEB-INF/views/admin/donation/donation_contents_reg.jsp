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
			<label for="reg_popup_rewardaname">만오천냥 리워드</label>
		</div>
		<div class="input-container">
			<input type="text" id="reg_popup_rewardaname" name="rewardaname" required />
			<img src="/resources/images/search-icon.png" id="reg_find_reward_button_1"
				class="search-icon" alt="Search" />
		</div>

		<div class="form-item">
            <label for="reg_popup_rewardbname">삼만냥 리워드</label>
        </div>
        <div class="input-container">
            <input type="text" id="reg_popup_rewardbname" name="rewardbname" />
            <img src="/resources/images/search-icon.png" id="reg_find_reward_button_2" class="search-icon" alt="Search" />
        </div>

        <div class="form-item">
            <label for="reg_popup_rewardcname">오만냥 리워드</label>
        </div>
        <div class="input-container">
            <input type="text" id="reg_popup_rewardcname" name="rewardcname" />
            <img src="/resources/images/search-icon.png" id="reg_find_reward_button_3" class="search-icon" alt="Search" />
        </div>

        <div class="form-item">
            <label for="reg_popup_rewarddname">십만냥 리워드</label>
        </div>
        <div class="input-container">
            <input type="text" id="reg_popup_rewarddname" name="rewarddname" />
            <img src="/resources/images/search-icon.png" id="reg_find_reward_button_4" class="search-icon" alt="Search" />
        </div>

		<div class="form-item">
			<label for="reg_popup_filename">이미지</label> <input type="file"
				id="reg_popup_img" name="file1" accept="image/*" />
		</div>

		<button type="submit" class="button">등록</button>
		<button type="button" class="button close-reg-popup">닫기</button>
	</form>
</div>


<script>
    // 팝업을 여는 공통 함수
    function openFindRewardPopup(targetInputId, popupName) {
        window.open('donation_content_find_reward.do?targetInputId=' + targetInputId, popupName, 'width=600,height=800');
    }

    document.getElementById('reg_find_reward_button_1').addEventListener('click', function() {
        openFindRewardPopup('reg_popup_rewardaname', 'findRewardPopup1');
    });
    document.getElementById('reg_find_reward_button_2').addEventListener('click', function() {
        openFindRewardPopup('reg_popup_rewardbname', 'findRewardPopup2');
    });
    document.getElementById('reg_find_reward_button_3').addEventListener('click', function() {
        openFindRewardPopup('reg_popup_rewardcname', 'findRewardPopup3');
    });
    document.getElementById('reg_find_reward_button_4').addEventListener('click', function() {
        openFindRewardPopup('reg_popup_rewarddname', 'findRewardPopup4');
    });
</script>