<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../include/menu.jsp" %>
<div id="reg_popup" class="popup">
    <h3>설화 등록</h3>
    <form action="legend_insert.do" method="post" enctype="multipart/form-data">
        <div class="form-item">
            <label for="title">설화 제목</label>
            <input type="text" id="title" name="title" required />
        </div>

        <div class="form-item">
            <label for="location">지역 입력</label>
            <input type="text" id="location" name="location" required />
        </div>

        <div class="form-item">
            <label for="content">설화 내용</label>
            <textarea id="content" name="story" rows="4" required></textarea>
        </div>
        
        <div class="form-item">
            <label for="content">설화 출처</label>
            <input type="text" id="source" name="source" required />
        </div>
        
        <div class="form-item">
            <label for="img">이미지 업로드</label>
            <input type="file" id="img" name="img" accept="image/*" />
        </div>

        <div class="form-item">
            <label for="tts_audio">TTS 오디오</label>
            <input type="file" id="tts_audio" name="tts_audio" accept="audio/*" />
        </div>
        
        <button type="submit" class="button">등록</button>
        <button type="button" class="button" onclick="closePopup()">닫기</button>
    </form>
</div>
