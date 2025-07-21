<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리워드 관리</title>
<link rel="stylesheet" href="/css/admin.css">
<link rel="stylesheet" href="/css/popup.css">
<style>
.container {
  max-width: 1200px;
  padding: 0 40px;
  box-sizing: border-box;
   position: relative;
  left: -450px; /* ← 이걸로 옆으로 이동 */
}

/* 테이블 스타일 개선 */
.container table {
  width: 100%;
  table-layout: fixed;
  word-break: break-word;
  border-collapse: collapse;
}

.container th, .container td {
  word-wrap: break-word;
  white-space: normal;
  padding: 10px;
  text-align: center;
}
.container td button {
  margin: 5px;
  display: inline-block;
}

</style>

</head>
<body>
	<%@ include file="../../include/admin_menu.jsp"%>
	<h2>리워드 관리</h2>
    <button class="add-btn" id="addButton">추가하기</button>
    <br>

	<div align="right">총 ${totalCount}개의 내역이 조회되었습니다.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    <div class="search-box">
        <form method="get" action="member_list.do">
            <select name="searchType">
                <option value="name" ${searchType == 'name' ? 'selected' : ''}>리워드	이름</option>
				<option value="description"	${searchType == 'description' ? 'selected' : ''}>내용</option>
            </select>
            <input type="text" name="searchKeyword" value="${searchKeyword}" />
            <select name="sortBy">
                <option value="price_type" ${sortBy == 'price_type' ? 'selected' : ''}>금액</option>
				<option value="reg_date" ${sortBy == 'reg_date' ? 'selected' : ''}>등록일</option>
            </select>
            <select name="sortOrder">
                <option value="asc" ${sortOrder == 'asc' ? 'selected' : ''}>오름차순</option>
                <option value="desc" ${sortOrder == 'desc' ? 'selected' : ''}>내림차순</option>
            </select>
            <button type="submit">검색</button>
        </form>
    </div>
	<br>
<div class="container">
	<table border="1" >
		<tr>
			<td>No.</td>
			<td>이름</td>
			<td>금액 구간</td>
			<td>구성상품 1</td>
			<td>구성상품 2</td>
			<td>구성상품 3</td>
			<td>구성상품 4</td>
			<td>등록일</td>
			<td>상태 관리</td>
		</tr>
		<c:if test="${not empty list}">
			<c:forEach var="row" items="${list}">
				<tr>
					<td>${row.reward_id}</td>
					<td>${row.name}</td>
					<td><c:choose>
							<c:when test="${row.price_type == 'a'}">15,000원 이상 30,000원 미만</c:when>
							<c:when test="${row.price_type == 'b'}">30,000원 이상 50,000원 미만</c:when>
							<c:when test="${row.price_type == 'c'}">50,000원 이상 100,000원 미만</c:when>
							<c:when test="${row.price_type == 'd'}">100,000원 이상</c:when>
						</c:choose></td>
					<td>${empty row.goods_1_name ? '' : row.goods_1_name}</td>
					<td>${empty row.goods_2_name ? '' : row.goods_2_name}</td>
					<td>${empty row.goods_3_name ? '' : row.goods_3_name}</td>
					<td>${empty row.goods_4_name ? '' : row.goods_4_name}</td>
					<td><fmt:formatDate value="${row.reg_date}"
							pattern="yyyy-MM-dd" /></td>
					<td>
						<button class="edit-button" data-reward-id="${row.reward_id}"
							data-name="${row.name}" data-description="${row.description}"
							data-price-type="${row.price_type}" data-img="${row.img}"
							data-goods-1="${row.goods_1}" data-goods-2="${row.goods_2}"
							data-goods-3="${row.goods_3}" data-goods-4="${row.goods_4}"
							data-goods-1-name="${row.goods_1_name}" data-goods-2-name="${row.goods_2_name}"
							data-goods-3-name="${row.goods_3_name}" data-goods-4-name="${row.goods_4_name}">수정</button>
						<button class="delete-button" data-reward-id="${row.reward_id}">삭제</button>
					</td>
				</tr>
			</c:forEach>
		</c:if>
		 <c:if test="${empty list}">
            <tr>
                <td colspan="6" align="center">검색 결과가 없습니다.</td>
            </tr>
        </c:if>
	</table>
	</div> 
	<%@ include file="../../include/admin_paging.jsp"%>

	<div id="overlay" class="overlay"></div>

	<%@ include file="reward_reg.jsp"%>
	<%@ include file="reward_edit.jsp"%>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
        $(document).ready(function() {
            function openRegPopup() {
                $('#reg_popup').show();
                $('#overlay').show();
                $('#reg_popup_name').val('');
                $('#reg_popup_description').val('');
                $('#reg_popup_price_type').val('');
                $('#reg_popup_goods_1_name').val('');
                $('#reg_popup_goods_2_name').val('');
                $('#reg_popup_goods_3_name').val('');
                $('#reg_popup_goods_4_name').val('');
                $('#reg_popup_img').val('');
            }

            function closeRegPopup() {
                $('#reg_popup').hide();
                $('#overlay').hide();
            }

            function openEditPopup(rewardId, name, description, priceType, goods1Name, goods2Name, goods3Name, goods4Name, img) {
                $('#edit_popup').show();
                $('#overlay').show();
                $('#edit_popup_reward_id').val(rewardId);
                $('#edit_popup_name').val(name);
                $('#edit_popup_description').val(description);
                $('#edit_popup_price_type').val(priceType);
                $('#edit_popup_goods_1_name').val(goods1Name);
                $('#edit_popup_goods_2_name').val(goods2Name);
                $('#edit_popup_goods_3_name').val(goods3Name);
                $('#edit_popup_goods_4_name').val(goods4Name);
                $('#edit_popup_img').val('');

                if (img) {
                    $('#current_image_container').show();
                    $('#current_image').attr('src', '/resources/reward_img/' + img);
                    $('#current_image_name').text(img);
                } else {
                    $('#current_image_container').hide();
                }
            }

            function closeEditPopup() {
                $('#edit_popup').hide();
                $('#overlay').hide();
            }

            function reward_delete(reward_id) {
                if (confirm("리워드을 삭제하시겠습니까?")) {
                    window.location.href = "reward_delete.do?reward_id=" + reward_id;
                }
            }

            $('#addButton').on('click', openRegPopup);
            $('#overlay').on('click', function() {
                closeRegPopup();
                closeEditPopup();
            });
            $('.close-reg-popup').on('click', closeRegPopup);
            $('.close-edit-popup').on('click', closeEditPopup);
            $('table').on('click', '.edit-button', function() {
                const rewardId = $(this).data('reward-id');
                const name = $(this).data('name');
                const priceType = $(this).data('price-type');
                const description = $(this).data('description');
                const goods1 = $(this).data('goods-1');
                const goods2 = $(this).data('goods-2');
                const goods3 = $(this).data('goods-3');
                const goods4 = $(this).data('goods-4');
                const goods1Name = $(this).data('goods-1-name');
                const goods2Name = $(this).data('goods-2-name');
                const goods3Name = $(this).data('goods-3-name');
                const goods4Name = $(this).data('goods-4-name');
                const img = $(this).data('img');
                openEditPopup(rewardId, name, description, priceType, goods1Name, goods2Name, goods3Name, goods4Name, img);
            });

            $('table').on('click', '.delete-button', function() {
                const rewardId = $(this).data('reward-id');
                reward_delete(rewardId);
            });
        });
    </script>
</body>
</html>
