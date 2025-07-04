<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div id="edit_popup" class="popup">
    <h3>설화 수정</h3>
    <form action="legend_update.do" method="post" enctype="multipart/form-data">
        <div class="form-item">
            <label for="title">설화 제목</label>
            <input type="text" id="title" name="title" value="${title}" required />
        </div>

        <div class="form-item">
            <label for="location">지역 입력</label>
            <input type="text" id="location" name="location" value="${location}" required />
        </div>

        <div class="form-item">
            <label for="content">설화 내용</label>
            <textarea id="content" name="story" rows="4" required>${story}</textarea>
        </div>
        
        <div class="form-item">
            <label for="content">설화 출처</label>
            <input type="text" id="source" name="source" value="${source}" required />
        </div>
        
        <div class="form-item">
            <label for="img">이미지 업로드</label>
            <input type="file" id="img" name="img" accept="image/*" />
        </div>

        <div class="form-item">
            <label for="tts_audio">TTS 오디오</label>
            <input type="file" id="tts_audio" name="tts_audio" accept="audio/*" />
        </div>
        
        <input type="hidden" id="legend_id" name="legend_id" />
        
        <button type="submit" class="button">수정</button>
        <button type="button" class="button" onclick="closeEditPopup()">닫기</button>
    </form>
</div>
