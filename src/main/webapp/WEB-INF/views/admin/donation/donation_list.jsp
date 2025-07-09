<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>명패 관리</title>
<link rel="stylesheet" href="/css/admin.css">
<link rel="stylesheet" href="/css/popup.css">
</head>
<body>
	<%@ include file="../../include/admin_menu.jsp"%>
	<h2>명패 관리</h2>
	<table border="1" width="700px">
		<tr>
			<td>No.</td>
			<td>제목</td>
			<td>내용</td>
			<td>목표 금액</td>
			<td>시작일</td>
			<td>마감일</td>
			<td>등록일</td>
			<td>지역</td>
			<td>이미지</td>
			<td>상태 관리</td>
		</tr>
		<c:if test="${not empty list}">
			<c:forEach var="row" items="${list}">
				<tr>
					<td>${row.content_id}</td>
					<td>${row.title}</td>
					<td>${row.content}</td>
					<td><fmt:formatNumber value="${row.target_amount}" pattern="#,###"/>원</td>
					<td><fmt:formatDate value="${row.start_date}"
							pattern="yyyy-MM-dd" /></td>
					<td><fmt:formatDate value="${row.end_date}"
							pattern="yyyy-MM-dd" /></td>
					<td><fmt:formatDate value="${row.created_at}"
							pattern="yyyy-MM-dd" /></td>
					<td>${row.location}</td>
					<td>${row.filename}</td>
					<td>
						<button class="edit-button" data-content-id="${row.content_id}"
							data-title="${row.title}" data-content="${row.content}" data-target-amount="${row.target_amount}"
							data-start-date="${row.start_date}" data-end-date="${row.end_date}"
							data-created-at="${row.created_at}"	data-filename="${row.filename}">수정</button>
						<button class="delete-button" data-content-id="${row.content_id}">삭제</button>
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
					<a href="donation_list.do?page=${i}">[${i}]</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</div>
	<button id="addContentButton">추가하기</button>
	<div id="overlay" class="overlay"></div>

	<%@ include file="donation_reg.jsp"%>
	<%@ include file="donation_edit.jsp"%>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		$(document).ready(
				function() {
					function openRegPopup() {
						$('#reg_popup').show();
						$('#overlay').show();
						$('#reg_popup_name').val('');
						$('#reg_popup_description').val('');
						$('#reg_popup_img').val('');
					}

					function closeRegPopup() {
						$('#reg_popup').hide();
						$('#overlay').hide();
					}

					function openEditPopup(badgeId, name, description, img) {
						$('#edit_popup').show();
						$('#overlay').show();
						$('#edit_popup_badge_id').val(badgeId);
						$('#edit_popup_name').val(name);
						$('#edit_popup_description').val(description);
						$('#edit_popup_img').val('');
						
						if (img) {
							$('#current_image_container').show();  // 기존 이미지 컨테이너를 보이게 함
							$('#current_image').attr('src', '/resources/badge_img/' + img);  // 기존 이미지 경로 설정
							$('#current_image_name').text(img);  // 파일명 텍스트로 설정
						} else {
							$('#current_image_container').hide();  // 이미지가 없다면 숨김
						}
					}

					function closeEditPopup() {
						$('#edit_popup').hide();
						$('#overlay').hide();
					}

					function donation_delete(content_id) {
						if (confirm("기부 프로젝트를 삭제하시겠습니까?")) {
							window.location.href = "donation_delete.do?content_id="
									+ content_id;
						}
					}

					$('#addContentButton').on('click', openRegPopup);
					$('#overlay').on('click', function() {
						closeRegPopup();
						closeEditPopup();
					});
					$('.close-reg-popup').on('click', closeRegPopup);
					$('.close-edit-popup').on('click', closeEditPopup);
					$('table').on('click', '.edit-button', function() {
						const badgeId = $(this).data('badge-id');
						const name = $(this).data('name');
						const description = $(this).data('description');
						const img = $(this).data('img');
						openEditPopup(badgeId, name, description, img);
					});

					$('table').on('click', '.delete-button', function() {
						const contentId = $(this).data('content-id');
						donation_delete(contentId);
					});
				});
	</script>
</body>
</html>