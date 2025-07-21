<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>굿즈 검색</title>
    <link rel="stylesheet" href="/css/find_popup.css">
</head>
<body>
    <h2>상품 검색</h2>
    <button class="cls-btn" id="closeButton">닫기</button>
    <br>

    <div class="search-box">
        <form method="get" action="reward_find_goods.do">
        	<input type="hidden" name="targetInputId" value="${targetInputId}" />
            <select name="searchType">
                <option value="name" ${searchType == 'name' ? 'selected' : ''}>상품명</option>
				<option value="description"	${searchType == 'description' ? 'selected' : ''}>설명</option>
				<option value="location" ${searchType == 'location' ? 'selected' : ''}>지역</option>
            </select>
            <input type="text" name="searchKeyword" value="${searchKeyword}" />
            <button type="submit">검색</button>
        </form>
    </div>
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
    <%@ include file="../../include/admin_paging.jsp"%>
    
    <button id="selectButton">선택</button>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            // Controller에서 전달받은 targetInputId 값을 JavaScript 변수로 가져오기
            var targetInputId = '${targetInputId}'; // JSP EL을 사용하여 값 가져오기

            // 선택된 상품의 goods_id를 원래 input 영역에 전달
            $('#selectButton').on('click', function() {
                var selectedGoodsId = $('input[name="goods_select"]:checked').val();
                var selectedGoodsName = $('input[name="goods_select"]:checked').closest('tr').find('td').eq(3).text(); // 3번째 td (이름) 가져오기
                if (selectedGoodsId) {
                    if (targetInputId) { // targetInputId가 존재하는지 확인
                        opener.$('#' + targetInputId).val(selectedGoodsName); // 동적으로 ID 사용!
                    } else {
                        // 기본값 또는 에러 처리 (만약 targetInputId가 없는 경우)
                        opener.$('#reg_popup_goods_1_name').val(selectedGoodsName); // 기본값으로 goods_1에 넣기
                    }
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
