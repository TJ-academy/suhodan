<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>TTS 생성</title>
</head>
<body>
    <h2>음성 생성기</h2>
    <form action="/admin/legend/generate_speech.do" method="post">
        <label for="text">텍스트 입력:</label><br>
        <textarea name="text" id="text" rows="5" cols="50"></textarea><br><br>

        <label for="filename">파일명 (예: hello.mp3):</label><br>
        <input type="text" name="filename" id="filename"><br><br>

        <input type="submit" value="음성 생성">
    </form>
</body>
</html>
