<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>설화 관리</title>
<link rel="stylesheet" href="/css/admin.css">
<link rel="stylesheet" href="/css/popup.css">
</head>
<body>
	<%@ include file="../../include/admin_menu.jsp"%>
	<h2>설화 관리</h2>
    <button class="add-btn" id="addButton">추가하기</button>
    <br>

    <div class="search-box">
        <form method="get" action="legend_list.do">
            <select name="searchType">
                <option value="title" ${searchType == 'title' ? 'selected' : ''}>제목</option>
				<option value="location" ${searchType == 'location' ? 'selected' : ''}>지역</option>
				<option value="story" ${searchType == 'story' ? 'selected' : ''}>내용</option>
            </select>
            <input type="text" name="searchKeyword" value="${searchKeyword}" />
            <button type="submit">검색</button>
        </form>
    </div>
	<br>
	
	<table border="1" width="700px">
		<tr>
			<td>No.</td>
			<td>제목</td>
			<td>지역</td>
			<td>등록일</td>
			<td>배경이미지</td>
			<td>TTS 등록</td>
			<td>상태 관리</td>
		</tr>
		<c:if test="${not empty list}">
			<c:forEach var="row" items="${list}">
				<tr>
					<td>${row.legend_id}</td>
					<td>${row.title}</td>
					<td>${row.location}</td>
					<td><fmt:formatDate value="${row.reg_date}"
							pattern="yyyy-MM-dd" /></td>
					<td>${row.img}</td>
					<td>${row.tts_audio}</td>
					<td>
						<%-- 수정 버튼: onclick 대신 class와 data-* 속성 사용 --%>
						<button class="edit-button" data-legend-id="${row.legend_id}"
							data-title="${row.title}" data-location="${row.location}"
							data-story="${row.story}" data-img="${row.img}"
							data-tts-audio="${row.tts_audio}" data-source="${row.source}">수정</button>
						<%-- source 데이터 추가 --%>
						<button class="delete-button" data-legend-id="${row.legend_id}">삭제</button>
						<%-- 삭제 버튼도 class 사용 --%>
					</td>
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${empty list}">
			<tr>
				<td colspan="7" align="center">검색 결과가 없습니다.</td>
			</tr>
		</c:if>
	</table>
	<%@ include file="../../include/admin_paging.jsp"%>
	<div id="overlay" class="overlay"></div>

	<%@ include file="legend_reg.jsp"%>
	<%@ include file="legend_edit.jsp"%>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
        $(document).ready(function() {

            function openRegPopup() {
                $('#reg_popup').show();
                $('#overlay').show();
                $('#reg_popup_title').val('');
                $('#reg_popup_location').val('');
                $('#reg_popup_content').val('');
                $('#reg_popup_source').val('');
                $('#reg_popup_img').val(''); // 파일 입력 필드 초기화
                $('#reg_popup_tts_audio').val(''); // 파일 입력 필드 초기화
            }

            // 팝업 닫기 (등록) 함수
            function closeRegPopup() {
                $('#reg_popup').hide();
                $('#overlay').hide();
            }

            // 팝업 열기 (수정) 함수
            function openEditPopup(legendId, title, location, story, source, img, tts_audio) {
                $('#edit_popup').show();
                $('#overlay').show();
                
                // 수정 팝업 필드에 값 설정
                $('#edit_popup_legend_id').val(legendId);
                $('#edit_popup_title').val(title);
                $('#edit_popup_location').val(location);
                $('#edit_popup_content').val(story);
                $('#edit_popup_source').val(source); // source 값 설정
                
                // 파일 입력 필드는 보안상 값 설정이 불가능하므로 비워둡니다.
                $('#edit_popup_img').val(''); 
                $('#edit_popup_tts_audio').val(''); 
                // 참고: 현재 이미지/TTS 오디오 파일명을 표시하려면 팝업 내에 별도의 텍스트 요소를 추가해야 합니다.
                
                if (img) {
					$('#current_image_container').show();  // 기존 이미지 컨테이너를 보이게 함
					$('#current_image').attr('src', '/resources/legend_img/' + img);  // 기존 이미지 경로 설정
					$('#current_image_name').text(img);  // 파일명 텍스트로 설정
				} else {
					$('#current_image_container').hide();  // 이미지가 없다면 숨김
				}
                
                if (tts_audio) {
					$('#current_tts_audio_container').show();  // 기존 이미지 컨테이너를 보이게 함
					$('#current_tts_audio').attr('src', '/resources/legend_tts/' + tts_audio);  // 기존 이미지 경로 설정
					$('#current_tts_audio_name').text(tts_audio);  // 파일명 텍스트로 설정
				} else {
					$('#current_tts_audio_container').hide();  // 이미지가 없다면 숨김
				}
            }

            // 팝업 닫기 (수정) 함수
            function closeEditPopup() {
                $('#edit_popup').hide();
                $('#overlay').hide();
            }

            // 설화 삭제 함수
            function legend_delete(legend_id) {
                if (confirm("설화를 삭제하시겠습니까?")) {
                    window.location.href = "legend_delete.do?legend_id=" + legend_id;
                }
            }

            //--- 이벤트 리스너 연결 ---//

            // 1. '추가하기' 버튼 클릭 시 등록 팝업 열기
            $('#addButton').on('click', openRegPopup);

            // 2. 오버레이 클릭 시 모든 팝업 닫기
            $('#overlay').on('click', function() {
                closeRegPopup();
                closeEditPopup();
            });

            // 3. 등록 팝업의 '닫기' 버튼 클릭 시 팝업 닫기
            $('.close-reg-popup').on('click', closeRegPopup);

            // 4. 수정 팝업의 '닫기' 버튼 클릭 시 팝업 닫기
            $('.close-edit-popup').on('click', closeEditPopup);

            // 5. '수정' 버튼 클릭 시 수정 팝업 열고 데이터 채우기
            // 동적으로 추가되는 행에 대해서도 동작하도록 .on() 메서드의 위임(delegation) 사용을 권장합니다.
            // 여기서는 테이블에 직접 바인딩하여 유연성을 높입니다.
            $('table').on('click', '.edit-button', function() {
                // data-* 속성에서 값을 가져옵니다.
                const legendId = $(this).data('legend-id');
                const title = $(this).data('title');
                const location = $(this).data('location');
                const story = $(this).data('story');
                const img = $(this).data('img');
                const tts_audio = $(this).data('tts-audio');
                const source = $(this).data('source'); // data-source 값 가져오기

                // openEditPopup 함수 호출하여 데이터 전달
                openEditPopup(legendId, title, location, story, source, img, tts_audio);
            });

            // 6. '삭제' 버튼 클릭 시 설화 삭제
            $('table').on('click', '.delete-button', function() {
                const legendId = $(this).data('legend-id');
                legend_delete(legendId);
            });
        });
    </script>
</body>
</html>