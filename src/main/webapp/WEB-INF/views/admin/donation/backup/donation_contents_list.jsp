<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기부 프로젝트 관리</title>
<link rel="stylesheet" href="/css/admin.css">
<link rel="stylesheet" href="/css/popup.css">
</head>
<body>
	<%@ include file="../../include/admin_menu.jsp"%>
	<h2>기부 프로젝트 관리</h2>
    <button class="add-btn" id="addButton">추가하기</button>
    <br>

	<div align="right">총 ${totalCount}개의 내역이 조회되었습니다.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    <div class="search-box">
        <form method="get" action="donation_contents_list.do">
            <select name="searchType">
                <option value="title" ${searchType == 'title' ? 'selected' : ''}>제목</option>
                <option value="content" ${searchType == 'content' ? 'selected' : ''}>내용</option>
				<option value="location" ${searchType == 'location' ? 'selected' : ''}>지역</option>
            </select>
            <input type="text" name="searchKeyword" value="${searchKeyword}" />
            <select name="sortBy">
                <option value="target_amount" ${sortBy == 'target_amount' ? 'selected' : ''}>목표금액</option>
				<option value="start_date" ${sortBy == 'start_date' ? 'selected' : ''}>시작일자</option>
				<option value="end_date" ${sortBy == 'end_date' ? 'selected' : ''}>종료일자</option>
				<option value="created_at" ${sortBy == 'created_at' ? 'selected' : ''}>등록일자</option>
            </select>
            <select name="sortOrder">
                <option value="asc" ${sortOrder == 'asc' ? 'selected' : ''}>오름차순</option>
                <option value="desc" ${sortOrder == 'desc' ? 'selected' : ''}>내림차순</option>
            </select>
            <button type="submit">검색</button>
        </form>
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
					<td><fmt:formatNumber value="${row.target_amount / 10000}"
							pattern="#,###" />만원</td>
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
						<button class="edit-reward-button" data-content-id="${row.content_id}"
						data-rewardaname="${row.rewardaname}" data-rewardbname="${row.rewardbname}"
						data-rewardcname="${row.rewardcname}" data-rewarddname="${row.rewarddname}">리워드 관리</button>
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
	<%@ include file="../../include/admin_paging.jsp"%>
	<div id="overlay" class="overlay"></div>

	<%@ include file="donation_contents_reg.jsp"%>
	<%@ include file="donation_contents_edit.jsp"%>
	<%@ include file="donation_contents_reward.jsp"%>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		$(document).ready(
				function() {
					function openRegPopup() {
						$('#reg_popup').show();
						$('#overlay').show();
						
						$('#reg_popup_title').val('테스트 프로젝트 제목');
						$('#reg_popup_content').val('테스트 내용');
						$('#reg_popup_target_amount').val('1300000');
						$('#reg_popup_start_date').val('2025-07-17');
						$('#reg_popup_end_date').val('2025-08-17');
						$('#reg_popup_location').val('테스트');
						
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
					
					function openEditRewardPopup(contentId, rewardAName, rewardBName, rewardCName, rewardDName) {
						$('#edit_reward_popup').show();
						$('#overlay').show();
						$('#edit_popup_content_id').val(contentId);
						
						$('#edit_popup_rewardaname').val(rewardAName);
						$('#edit_popup_rewardbname').val(rewardBName);
						$('#edit_popup_rewardcname').val(rewardCName);
						$('#edit_popup_rewarddname').val(rewardDName);
						
					}

					function closeEditRewardPopup() {
						$('#edit_reward_popup').hide();
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
					$('table').on('click', '.edit-reward-button', function() {
						const contentId = $(this).data('content-id');
						const rewardAName = $(this).data('rewardaname');
						const rewardBName = $(this).data('rewardbname');
						const rewardCName = $(this).data('rewardcname');
						const rewardDName = $(this).data('rewarddname');
						openEditRewardPopup(contentId, rewardAName, rewardBName, rewardCName, rewardDName);
					});

					$('table').on('click', '.delete-button', function() {
						const contentId = $(this).data('content-id');
						donation_contents_delete(contentId);
					});
				});
	</script>
</body>
</html>