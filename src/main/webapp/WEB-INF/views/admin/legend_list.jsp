<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>설화 관리</title>
    <style>
        /* 팝업 스타일 */
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
        // 팝업 열기, 닫기 함수
        function openPopup() {
            document.getElementById('reg_popup').style.display = 'block';
            document.getElementById('overlay').style.display = 'block';
        }

        function closePopup() {
            document.getElementById('reg_popup').style.display = 'none';
            document.getElementById('overlay').style.display = 'none';
        }

        function openEditPopup(legendId, title, location, story, img, tts_audio) {
            document.getElementById('edit_popup').style.display = 'block';
            document.getElementById('overlay').style.display = 'block';
            document.getElementById('legend_id').value = legendId;
            document.getElementById('title').value = title;
            document.getElementById('location').value = location;
            document.getElementById('content').value = story;
            document.getElementById('img').value = img;  // 이미지 URL 표시용
            document.getElementById('tts_audio').value = tts_audio;  // 오디오 URL 표시용
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
<%@ include file="../include/admin_menu.jsp" %>
    <div>
        <h2>설화 관리</h2>
        <a href="tts_form.do">TTS 생성</a>
    </div>

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
                <td><fmt:formatDate value="${row.reg_date}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                <td>${row.img}</td>
                <td>${row.tts_audio}</td>
                <td>
                    <button onclick="openEditPopup(${row.legend_id}, '${row.title}', '${row.location}', '${row.story}', '${row.img}', '${row.tts_audio}')">수정</button>
                    <button onclick="legend_delete(${row.legend_id})">삭제</button>
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
                    <a href="legend_list.do?page=${i}">[${i}]</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </div>
    
    <button onclick="openPopup()">추가하기</button>
    <div id="overlay" class="overlay" onclick="closePopup()"></div>

    <!-- 팝업 포함 -->
    <%@ include file="legend_reg.jsp" %>
    <%@ include file="legend_edit.jsp" %>

</body>
</html>
