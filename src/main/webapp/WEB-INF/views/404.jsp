<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 에러 - 페이지를 찾을 수 없습니다</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f2f2f2;
            color: #333;
            text-align: center;
            padding: 50px;
        }

        .error-container {
            background-color: #fff;
            border: 1px solid #ddd;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: 0 auto;
        }

        h1 {
            font-size: 100px;
            color: #f44336;
        }

        h2 {
            font-size: 24px;
            color: #555;
        }

        p {
            font-size: 16px;
            color: #777;
        }

        .btn {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            font-size: 18px;
            border: none;
            border-radius: 5px;
            text-decoration: none;
        }

        .btn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

<div class="error-container">
    <h1>404</h1>
    <h2>페이지를 찾을 수 없습니다</h2>
    <p>요청하신 페이지는 존재하지 않거나 삭제되었습니다. 페이지 주소를 확인해 주세요.</p>
    <a href="/" class="btn">홈으로 돌아가기</a>
</div>

</body>
</html>
