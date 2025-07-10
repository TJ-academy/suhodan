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
	<div class="header-container">
		<h2>기부 관리</h2>
		<button id="addButton">추가하기</button>
	</div>
	<br>
	<table border="1" width="700px">
		<tr>
			<td>No.</td>
			<td>제목</td>
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
					<td><fmt:formatNumber value="${row.target_amount}"
							pattern="#,###" />원</td>
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
							data-title="${row.title}" data-content="${row.content}"
							data-target-amount="${row.target_amount}"
							data-start-date="<fmt:formatDate value="${row.start_date}" pattern="yyyy-MM-dd" />"
							data-end-date="<fmt:formatDate value="${row.end_date}" pattern="yyyy-MM-dd" />"
							data-created-at="${row.created_at}"
							data-location="${row.location}" data-filename="${row.filename}">수정</button>
						<button class="delete-button" data-content-id="${row.content_id}">삭제</button>
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
	<%@ include file="../../include/admin_paging.jsp"%>
	<div id="overlay" class="overlay"></div>

	<%@ include file="donation_contents_reg.jsp"%>
	<%@ include file="donation_contents_edit.jsp"%>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		$(document).ready(
				function() {
					function openRegPopup() {
						$('#reg_popup').show();
						$('#overlay').show();
						
						$('#reg_popup_title').val('');
						$('#reg_popup_content').val('');
						$('#reg_popup_target_amount').val('');
						$('#reg_popup_start_date').val('');
						$('#reg_popup_end_date').val('');
						$('#reg_popup_created_at').val('');
						$('#reg_popup_location').val('');
						$('#reg_popup_filename').val('');
					}

					function closeRegPopup() {
						$('#reg_popup').hide();
						$('#overlay').hide();
					}

					function openEditPopup(contentId, title, content, targetAmount, startDate, endDate, createdAt, location, filename) {
						$('#edit_popup').show();
						$('#overlay').show();
						$('#edit_popup_content_id').val(contentId);
						$('#edit_popup_title').val(title);
						$('#edit_popup_content').val(content);
						$('#edit_popup_target_amount').val(targetAmount);
						$('#edit_popup_start_date').val(startDate);
						$('#edit_popup_end_date').val(endDate);
						$('#edit_popup_created_at').val(createdAt);
						$('#edit_popup_location').val(location);
						$('#edit_popup_filename').val('');
						
						if (filename) {
							$('#current_image_container').show();  // 기존 이미지 컨테이너를 보이게 함
							$('#current_image').attr('src', '/resources/donation_img/' + filename);  // 기존 이미지 경로 설정
							$('#current_image_name').text(filename);  // 파일명 텍스트로 설정
						} else {
							$('#current_image_container').hide();  // 이미지가 없다면 숨김
						}
					}

					function closeEditPopup() {
						$('#edit_popup').hide();
						$('#overlay').hide();
					}

					function donation_contents_delete(content_id) {
						if (confirm("기부 프로젝트를 삭제하시겠습니까?")) {
							window.location.href = "donation_contents_delete.do?content_id="
									+ content_id;
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
						const contentId = $(this).data('content-id');
						const title = $(this).data('title');
						const content = $(this).data('content');
						const targetAmount = $(this).data('target-amount');
						const startDate = $(this).data('start-date');
						const endDate = $(this).data('end-date');
						const createdAt = $(this).data('created-at');
						const location = $(this).data('location');
						const filename = $(this).data('filename');
						openEditPopup(contentId, title, content, targetAmount, startDate, endDate, createdAt, location, filename);
					});

					$('table').on('click', '.delete-button', function() {
						const contentId = $(this).data('content-id');
						donation_contents_delete(contentId);
					});
				});
	</script>
</body>
</html>