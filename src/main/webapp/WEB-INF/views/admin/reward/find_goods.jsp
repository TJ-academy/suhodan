<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>굿즈 검색</title>
    <link rel="stylesheet" href="/css/admin.css">
    <link rel="stylesheet" href="/css/popup.css">
</head>
<body>
    <div class="header-container">
        <h2>상품 검색</h2>
        <button id="closeButton">닫기</button>
    </div>
    <br>
    
    <form method="get" action="reward_find_goods.do">
        <label for="searchType">검색 기준</label>
        <select name="searchType">
            <option value="name" ${searchType == 'name' ? 'selected' : ''}>상품명</option>
            <option value="description" ${searchType == 'description' ? 'selected' : ''}>설명</option>
            <option value="location" ${searchType == 'location' ? 'selected' : ''}>지역</option>
        </select>
        <label for="searchKeyword">검색어</label>
        <input type="text" name="searchKeyword" value="${searchKeyword}" />
        <button type="submit">검색</button>
    </form>
    <br>
    
    <table border="1" width="700px">
        <tr>
            <td>선택</td>
            <td>No.</td>
            <td>지역</td>
            <td>이름</td>
            <td>금액</td>
            <td>이미지</td>
        </tr>
        <c:if test="${not empty list}">
            <c:forEach var="row" items="${list}">
                <tr>
                    <td><input type="radio" name="goods_select" value="${row.goods_id}" class="goods-radio" /></td>
                    <td>${row.goods_id}</td>
                    <td>${row.location}</td>
                    <td>${row.name}</td>
                    <td><fmt:formatNumber value="${row.price}" pattern="#,###" />원</td>
                    <td><img src="/resources/goods_img/${row.img}" width="50" height="50" /></td>
                </tr>
            </c:forEach>
        </c:if>
        <c:if test="${empty list}">
            <tr>
                <td colspan="6" align="center">검색 결과가 없습니다.</td>
            </tr>
        </c:if>
    </table>
    
    <button id="selectButton">선택</button>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            // 선택된 상품의 goods_id를 원래 input 영역에 전달
            $('#selectButton').on('click', function() {
                var selectedGoodsId = $('input[name="goods_select"]:checked').val();
                
                if (selectedGoodsId) {
                    // 부모 창의 input 필드에 값을 전달
                    opener.$('#reg_popup_goods_1').val(selectedGoodsId); // 여기서 #reg_popup_goods_1은 원래의 input 필드입니다.
                    window.close(); // 팝업 닫기
                } else {
                    alert('상품을 선택하세요.');
                }
            });

            // 팝업창 닫기
            $('#closeButton').on('click', function() {
                window.close();
            });
        });
    </script>
</body>
</html>
