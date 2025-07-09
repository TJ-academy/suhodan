<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>굿즈 관리</title>
<link rel="stylesheet" href="/css/admin.css">
<link rel="stylesheet" href="/css/popup.css">
</head>
<body>
	<%@ include file="../../include/admin_menu.jsp"%>
	<h2>굿즈 관리</h2>
	<table border="1" width="700px">
		<tr>
			<td>No.</td>
			<td>지역</td>
			<td>이름</td>
			<td>금액</td>
			<td>등록일</td>
			<td>이미지</td>
			<td>상태 관리</td>
		</tr>
		<c:if test="${not empty list}">
			<c:forEach var="row" items="${list}">
				<tr>
					<td>${row.goods_id}</td>
					<td>${row.location}</td>
					<td>${row.name}</td>
					<td>${row.price}</td>
					<td><fmt:formatDate value="${row.reg_date}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td>${row.img}</td>
					<td>
						<%-- 수정 버튼: onclick 대신 class와 data-* 속성 사용 --%>
						<button class="edit-button" data-goods-id="${row.goods_id}"
							data-location="${row.location}" data-name="${row.name}"
							data-price="${row.price}" data-img="${row.img}"
							data-detail-img="${row.detail_img}">수정</button>
						<button class="delete-button" data-goods-id="${row.goods_id}">삭제</button>
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
	<div>
		<c:forEach var="i" begin="1" end="${totalPage}">
			<c:choose>
				<c:when test="${i == currentPage}">
					<strong>[${i}]</strong>
				</c:when>
				<c:otherwise>
					<a href="goods_list.do?page=${i}">[${i}]</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</div>
	<button id="addGoodsButton">추가하기</button>
	<div id="overlay" class="overlay"></div>
	
	<%@ include file="goods_reg.jsp"%>
	<%@ include file="goods_edit.jsp"%>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
        $(document).ready(function() {
            function openRegPopup() {
                $('#reg_popup').show();
                $('#overlay').show();
                $('#reg_popup_location').val('');
                $('#reg_popup_name').val('');
                $('#reg_popup_price').val('');
                $('#reg_popup_description').val('');
                $('#reg_popup_img').val('');
                $('#reg_popup_detail_img').val('');
            }
            
            function closeRegPopup() {
                $('#reg_popup').hide();
                $('#overlay').hide();
            }

            function openEditPopup(goodsId, location, name, price, description, img, detail_img) {
                $('#edit_popup').show();
                $('#overlay').show();
                $('#edit_popup_goods_id').val(goodsId);
                $('#edit_popup_location').val(location);
                $('#edit_popup_name').val(name);
                $('#edit_popup_price').val(price);
                $('#edit_popup_img').val('');
                $('#edit_popup_detail_img').val('');
                
                if (img) {
					$('#current_image_container').show();  // 기존 이미지 컨테이너를 보이게 함
					$('#current_image').attr('src', '/resources/goods_img/' + img);  // 기존 이미지 경로 설정
					$('#current_image_name').text(img);  // 파일명 텍스트로 설정
				} else {
					$('#current_image_container').hide();  // 이미지가 없다면 숨김
				}
                
                if (detail_img) {
					$('#current_detail_image_container').show();  // 기존 이미지 컨테이너를 보이게 함
					$('#current_detail_image').attr('src', '/resources/goods_detail_img/' + detail_img);  // 기존 이미지 경로 설정
					$('#current_detail_image_name').text(detail_img);  // 파일명 텍스트로 설정
				} else {
					$('#current_detail_image_container').hide();  // 이미지가 없다면 숨김
				}       
                
            }

            function closeEditPopup() {
                $('#edit_popup').hide();
                $('#overlay').hide();
            }

            function goods_delete(goods_id) {
                if (confirm("상품을 삭제하시겠습니까?")) {
                    window.location.href = "goods_delete.do?goods_id=" + goods_id;
                }
            }

            $('#addGoodsButton').on('click', openRegPopup);
            $('#overlay').on('click', function() {
                closeRegPopup();
                closeEditPopup();
            });
            $('.close-reg-popup').on('click', closeRegPopup);
            $('.close-edit-popup').on('click', closeEditPopup);
            $('table').on('click', '.edit-button', function() {
                const goodsId = $(this).data('goods-id');
                const location = $(this).data('location');
                const name = $(this).data('name');
                const price = $(this).data('price');
                const description = $(this).data('description');
                const img = $(this).data('img');
                const detail_img = $(this).data('detail_img');
                openEditPopup(goodsId, location, name, price, description, img, detail_img);
            });

            $('table').on('click', '.delete-button', function() {
                const goodsId = $(this).data('goods-id');
                goods_delete(goodsId);
            });
        });
    </script>
</body>
</html>