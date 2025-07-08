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
			<td>이름</td>
			<td>설명</td>
			<td>등록일</td>
			<td>이미지</td>
			<td>상태 관리</td>
		</tr>
		<c:if test="${not empty list}">
			<c:forEach var="row" items="${list}">
				<tr>
					<td>${row.badge_id}</td>
					<td>${row.name}</td>
					<td>${row.description}</td>
					<td><fmt:formatDate value="${row.reg_date}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td align="center"><img src="/resources/badge_img/${row.img}"
						width="50px" height="50px"></td>
					<td>
						<button class="edit-button" data-badge-id="${row.badge_id}"
							data-name="${row.name}" data-description="${row.description}"
							data-reg-date="${row.reg_date}"	data-img="${row.img}">수정</button>
						<button class="delete-button" data-badge-id="${row.badge_id}">삭제</button>
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
					<a href="badge_list.do?page=${i}">[${i}]</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</div>
	<button id="addBadgeButton">추가하기</button>
	<div id="overlay" class="overlay"></div>

	<%@ include file="badge_reg.jsp"%>
	<%@ include file="badge_edit.jsp"%>

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

					function openEditPopup(badgeId, location, name, price,
							description, img, detail_img) {
						$('#edit_popup').show();
						$('#overlay').show();
						$('#edit_popup_badge_id').val(badgeId);
						$('#edit_popup_name').val(name);
						$('#edit_popup_description').val(description);
						$('#edit_popup_img').val('');
					}

					function closeEditPopup() {
						$('#edit_popup').hide();
						$('#overlay').hide();
					}

					function badge_delete(badge_id) {
						if (confirm("명패를 삭제하시겠습니까?")) {
							window.location.href = "badge_delete.do?badge_id="
									+ badge_id;
						}
					}

					$('#addBadgeButton').on('click', openRegPopup);
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
						const badgeId = $(this).data('badge-id');
						badge_delete(badgeId);
					});
				});
	</script>
</body>
</html>