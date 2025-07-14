<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="reg_popup" class="popup">
	<h3>리워드 등록</h3>
	<form action="reward_insert.do" method="post"
		enctype="multipart/form-data">
		<div class="form-item">
			<label for="reg_popup_name">이름</label> <input type="text"
				id="reg_popup_name" name="name" required />
		</div>

		<div class="form-item">
			<label for="reg_popup_description">내용</label>
			<textarea id="reg_popup_description" name="description" rows="4"
				required></textarea>
		</div>

		<div class="form-item">
			<label for="reg_popup_price_type">가격 구간</label> <select
				id="reg_popup_price_type" name="price_type" required>
				<option value="a">15,000원 이상 30,000원 미만</option>
				<option value="b">30,000원 이상 50,000원 미만</option>
				<option value="c">50,000원 이상 100,000원 미만</option>
				<option value="d">100,000원 이상</option>
			</select>
		</div>

		<div class="form-item">
			<label for="reg_popup_goods_1">구성상품 1</label>
		</div>
		<div class="input-container">
			<input type="text" id="reg_popup_goods_1" name="goods_1" required />
			<img src="/resources/images/search-icon.png" id="find_goods_button"
				class="search-icon" alt="Search" />
		</div>

		<div class="form-item">
			<label for="reg_popup_goods_2">구성상품 2</label> <input type="text"
				id="reg_popup_goods_2" name="goods_2"
				value="${empty rewardDTO.goods_2 ? '' : rewardDTO.goods_2}" />
		</div>

		<div class="form-item">
			<label for="reg_popup_goods_3">구성상품 3</label> <input type="text"
				id="reg_popup_goods_3" name="goods_3"
				value="${empty rewardDTO.goods_3 ? '' : rewardDTO.goods_3}" />
		</div>

		<div class="form-item">
			<label for="reg_popup_goods_4">구성상품 4</label> <input type="text"
				id="reg_popup_goods_4" name="goods_4"
				value="${empty rewardDTO.goods_4 ? '' : rewardDTO.goods_4}" />
		</div>

		<div class="form-item">
			<label for="reg_popup_img">이미지</label> <input type="file"
				id="reg_popup_img" name="imgFile" accept="image/*" />
		</div>

		<button type="submit" class="button">등록</button>
		<button type="button" class="button close-reg-popup">닫기</button>
	</form>
</div>

<script>
document.getElementById('find_goods_button').addEventListener('click', function() {
    window.open('reward_find_goods.do', 'findGoodsPopup', 'width=600,height=800');
});
</script>