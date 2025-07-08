<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="../../include/menu.jsp" %>

<style>
 .container {
    position: relative;
    width: 893px;
    height: 644px;
    margin: 0 auto; /* 가로 가운데 정렬 */
    /* 세로 중앙 정렬을 위해 아래와 같이 할 수도 있음 */
    top: 50%;
    transform: translateY(-50%);
    position: absolute;
    left: 50%;
    transform: translate(-50%, -50%);
  }

  .rectangle {
    width: 893px;
    height: 644px;
    background-color: #F5F1EB;
    border: 1.67px solid #D8C2A6;
    border-radius: 16.65px;
    position: relative;
  }

  .image {
    position: absolute;
    top: 20px; /* 이미지가 사각형 위에서 20px 내려온 위치 */
    left: 46px; /* 이미지가 사각형 왼쪽에서 46px 떨어진 위치 */
    width: 801px;
    height: 604px;
  }
</style>

<div class="container">
	<div class="rectangle"></div>
	<img class="image" src="../../resources/images/설화수 수호수.png" alt="설화수 수호수">
</div>
</body>
</html>