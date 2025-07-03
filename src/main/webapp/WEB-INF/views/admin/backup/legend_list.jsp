<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.popup {
	display: none;
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	width: 400px;
	background-color: white;
	padding: 20px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	z-index: 1000;
}

.overlay {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
	z-index: 999;
}

.form-item {
	margin-bottom: 15px;
}

.form-item label {
	display: block;
	margin-bottom: 5px;
}

.form-item input, .form-item textarea {
	width: 100%;
	padding: 8px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

.button {
	padding: 10px 20px;
	background-color: #ff7043;
	color: white;
	border: none;
	cursor: pointer;
	border-radius: 4px;
}

.button:hover {
	background-color: #ff5722;
}
</style>
<script>
function openPopup() {
    document.getElementById('reg_popup').style.display = 'block';
    document.getElementById('overlay').style.display = 'block';
  }

  function closePopup() {
    document.getElementById('reg_popup').style.display = 'none';
    document.getElementById('overlay').style.display = 'none';
  }
  
  function openEditPopup(legendId, title, location, story, img, tts_audio) {
	    // 팝업을 열고
	    document.getElementById('edit_popup').style.display = 'block';
	    document.getElementById('overlay').style.display = 'block';

	    // 팝업 폼을 수정모드로 전환
	    document.getElementById('legend_id').value = legendId;
	    document.getElementById('title').value = title;
	    document.getElementById('location').value = location;
	    document.getElementById('content').value = story;
	    document.getElementById('img').value = img; // 이미지는 URL로만 표시되므로 별도 처리 필요
	    document.getElementById('tts_audio').value = tts_audio; // 오디오 파일도 URL만 표시 가능
	}
  function closeEditPopup() {
	    document.getElementById('edit_popup').style.display = 'none';
	    document.getElementById('overlay').style.display = 'none';
	}
  function legend_delete(legend_id) {
	  if (confirm("설화를 삭제하시겠습니까?")) {
		  location.href = "legend_delete.do?legend_id=" + legend_id;
	  }
  }

</script>
</head>
<body>
	<%@ include file="../include/menu.jsp"%>
	<h2>회원관리</h2>

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
		<c:forEach var="row" items="${list}">
			<tr>
				<td>${row.legend_id}</td>
				<td>${row.title}</td>
				<td>${row.location}</td>
				<td><fmt:formatDate value="${row.reg_date}"
						pattern="yyyy-MM-dd HH:mm:ss" /></td>
				<td>${row.img}</td>
				<td>${row.tts_audio}</td>
				<td>
					<button
						onclick="openEditPopup(${row.legend_id}, '${row.title}', '${row.location}', '${row.story}', '${row.img}', '${row.tts_audio}')">수정</button>
					<button onclick="legend_delete('${row.legend_id}')">삭제</button>
				</td>
			</tr>
		</c:forEach>
	</table>
	<button onclick="openPopup()">추가하기</button>
	<div id="overlay" class="overlay" onclick="closePopup()"></div>

	<div id="reg_popup" class="popup">
		<h3>설화 등록</h3>
		<form action="legend_insert.do" method="post"
			enctype="multipart/form-data">
			<div class="form-item">
				<label for="title">설화 제목</label> <input type="text" id="title"
					name="title" required />
			</div>

			<div class="form-item">
				<label for="location">지역 입력</label> <input type="text" id="location"
					name="location" required />
			</div>

			<div class="form-item">
				<label for="content">설화 내용</label>
				<textarea id="content" name="story" rows="4" required></textarea>
			</div>

			<div class="form-item">
				<label for="img">이미지 업로드</label> <input type="file" id="img"
					name="img" accept="image/*" />
			</div>

			<div class="form-item">
				<label for="tts">TTS 오디오</label> <input type="file" id="tts_audio"
					name="tts_audio" accept="audio/*" />
			</div>
		
			<button type="submit" class="button">등록</button>
			<button type="button" class="button" onclick="closePopup()">닫기</button>
		</form>
	</div>

	<div id="edit_popup" class="popup">
		<h3>설화 수정</h3>
		<form action="legend_update.do" method="post"
			enctype="multipart/form-data">
			<div class="form-item">
				<label for="title">설화 제목</label> <input type="text" id="title"
					name="title" required />
			</div>

			<div class="form-item">
				<label for="location">지역 입력</label> <input type="text" id="location"
					name="location" required />
			</div>

			<div class="form-item">
				<label for="content">설화 내용</label>
				<textarea id="content" name="story" rows="4" required></textarea>
			</div>

			<div class="form-item">
				<label for="img">이미지 업로드</label> <input type="file" id="img"
					name="img" accept="image/*" />
			</div>

			<div class="form-item">
				<label for="tts">TTS 오디오</label> <input type="file" id="tts_audio"
					name="tts_audio" accept="audio/*" />
			</div>
			<input type="hidden" id="legend_id" name="legend_id" />
			<button type="submit" class="button">수정</button>
			<button type="button" class="button" onclick="closePopup()">닫기</button>
		</form>
	</div>
</body>
</html>