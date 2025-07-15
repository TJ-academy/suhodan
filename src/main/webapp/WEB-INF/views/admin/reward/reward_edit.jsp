<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div id="edit_popup" class="popup">
	<h3>리워드 수정</h3>
	<form action="reward_update.do" method="post"
		enctype="multipart/form-data">
		<div class="form-item">
			<label for="edit_popup_name">리워드명</label> <input type="text"
				id="edit_popup_name" name="name" required />
		</div>

		<div class="form-item">
			<label for="edit_popup_description">설명</label>
			<textarea id="edit_popup_description" name="description" rows="4"
				required></textarea>
		</div>

		<div class="form-item">
			<label for="edit_popup_price_type">가격 구간</label> <select
				id="edit_popup_price_type" name="price_type" required>
				<option value="a" ${edit_popup_price_type == 'a' ? 'selected' : ''}>15,000원
					이상 30,000원 미만</option>
				<option value="b" ${edit_popup_price_type == 'b' ? 'selected' : ''}>30,000원
					이상 50,000원 미만</option>
				<option value="c" ${edit_popup_price_type == 'c' ? 'selected' : ''}>50,000원
					이상 100,000원 미만</option>
				<option value="d" ${edit_popup_price_type == 'd' ? 'selected' : ''}>100,000원
					이상</option>
			</select>
		</div>

		<div class="form-item">
			<label for="edit_popup_goods_1_name">구성상품 1</label>
		</div>
		<div class="input-container">
			<input type="text" id="edit_popup_goods_1_name" name="goods_1_name" required />
			<img src="/resources/images/search-icon.png" id="edit_find_goods_button_1"
				class="search-icon" alt="Search" />
		</div>

		<div class="form-item">
            <label for="edit_popup_goods_2_name">구성상품 2</label>
        </div>
        <div class="input-container">
            <input type="text" id="edit_popup_goods_2_name" name="goods_2_name" />
            <img src="/resources/images/search-icon.png" id="edit_find_goods_button_2" class="search-icon" alt="Search" />
        </div>

        <div class="form-item">
            <label for="edit_popup_goods_3_name">구성상품 3</label>
        </div>
        <div class="input-container">
            <input type="text" id="edit_popup_goods_3_name" name="goods_3_name" />
            <img src="/resources/images/search-icon.png" id="edit_find_goods_button_3" class="search-icon" alt="Search" />
        </div>

        <div class="form-item">
            <label for="edit_popup_goods_4_name">구성상품 4</label>
        </div>
        <div class="input-container">
            <input type="text" id="edit_popup_goods_4_name" name="goods_4_name" />
            <img src="/resources/images/search-icon.png" id="edit_find_goods_button_4" class="search-icon" alt="Search" />
        </div>

		<div class="form-item">
			<label for="edit_popup_img">이미지</label>
			<input type="file" id="edit_popup_img" name="imgFile" accept="image/*" />
			<!-- 현재 이미지 출력 -->
			<div id="current_image_container" style="display:none;">
				<label>현재 이미지: <span id="current_image_name"></span></label>
				<img id="current_image" src="" alt="리워드 이미지" width="100" />
			</div>
		</div>

		<input type="hidden" id="edit_popup_reward_id" name="reward_id" />

		<button type="submit" class="button">수정</button>
		<button type="button" class="button close-edit-popup">닫기</button>
	</form>
</div>

<script>
    // 팝업을 여는 공통 함수
    function openFindGoodsPopup(targetInputId, popupName) {
        window.open('reward_find_goods.do?targetInputId=' + targetInputId, popupName, 'width=600,height=800');
    }

    document.getElementById('edit_find_goods_button_1').addEventListener('click', function() {
        openFindGoodsPopup('edit_popup_goods_1_name', 'findGoodsPopup1');
    });
    document.getElementById('edit_find_goods_button_2').addEventListener('click', function() {
        openFindGoodsPopup('edit_popup_goods_2_name', 'findGoodsPopup2');
    });
    document.getElementById('edit_find_goods_button_3').addEventListener('click', function() {
        openFindGoodsPopup('edit_popup_goods_3_name', 'findGoodsPopup3');
    });
    document.getElementById('edit_find_goods_button_4').addEventListener('click', function() {
        openFindGoodsPopup('edit_popup_goods_4_name', 'findGoodsPopup4');
    });
</script>