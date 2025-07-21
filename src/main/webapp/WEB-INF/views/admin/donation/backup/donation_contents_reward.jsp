<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="edit_reward_popup" class="popup">
	<h3>기부 프로젝트 수정</h3>
	<form action="donation_contents_reward_update.do" method="post"
		enctype="multipart/form-data"> 

		<div class="form-item">
			<label for="edit_popup_rewardaname">만오천냥 리워드</label>
		</div>
		<div class="input-container">
			<input type="text" id="edit_popup_rewardaname" name="rewardaname" required />
			<img src="/resources/images/search-icon.png" id="edit_find_reward_button_1"
				class="search-icon" alt="Search" />
		</div>

		<div class="form-item">
            <label for="edit_popup_rewardbname">삼만냥 리워드</label>
        </div>
        <div class="input-container">
            <input type="text" id="edit_popup_rewardbname" name="rewardbname" />
            <img src="/resources/images/search-icon.png" id="edit_find_reward_button_2" class="search-icon" alt="Search" />
        </div>

        <div class="form-item">
            <label for="edit_popup_rewardcname">오만냥 리워드</label>
        </div>
        <div class="input-container">
            <input type="text" id="edit_popup_rewardcname" name="rewardcname" />
            <img src="/resources/images/search-icon.png" id="edit_find_reward_button_3" class="search-icon" alt="Search" />
        </div>

        <div class="form-item">
            <label for="edit_popup_rewarddname">십만냥 리워드</label>
        </div>
        <div class="input-container">
            <input type="text" id="edit_popup_rewarddname" name="rewarddname" />
            <img src="/resources/images/search-icon.png" id="edit_find_reward_button_4" class="search-icon" alt="Search" />
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
        openFindRewardPopup('edit_popup_rewardaname', 'findRewardPopup1');
    });
    document.getElementById('edit_find_reward_button_2').addEventListener('click', function() {
        openFindRewardPopup('edit_popup_rewardbname', 'findRewardPopup2');
    });
    document.getElementById('edit_find_reward_button_3').addEventListener('click', function() {
        openFindRewardPopup('edit_popup_rewardcname', 'findRewardPopup3');
    });
    document.getElementById('edit_find_reward_button_4').addEventListener('click', function() {
        openFindRewardPopup('edit_popup_rewarddname', 'findRewardPopup4');
    });
</script>