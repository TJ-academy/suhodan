<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>리워드 검색</title>
    <link rel="stylesheet" href="/css/admin.css">
    <link rel="stylesheet" href="/css/popup.css">
</head>
<body>
    <h2>리워드 검색</h2>
    <button class="cls-btn" id="closeButton">닫기</button>
    <br>

    <div class="search-box">
        <form method="get" action="donation_content_find_reward.do">
        	<input type="hidden" name="targetInputId" value="${targetInputId}" />
            <select name="searchType">
                <option value="name" ${searchType == 'name' ? 'selected' : ''}>상품명</option>
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
			<td>이름</td>
			<td>금액 구간</td>
			<td>구성상품 1</td>
			<td>구성상품 2</td>
			<td>구성상품 3</td>
			<td>구성상품 4</td>
        </tr>
        <c:if test="${not empty list}">
            <c:forEach var="row" items="${list}">
                <tr>
                    <td><input type="radio" name="reward_select" value="${row.reward_id}" class="reward-radio" /></td>
                    <td>${row.reward_id}</td>
					<td>${row.name}</td>
					<td><c:choose>
							<c:when test="${row.price_type == 'a'}">만오천냥</c:when>
							<c:when test="${row.price_type == 'b'}">삼만냥</c:when>
							<c:when test="${row.price_type == 'c'}">오만냥</c:when>
							<c:when test="${row.price_type == 'd'}">십만냥</c:when>
						</c:choose></td>
					<td>${empty row.goods_1_name ? '' : row.goods_1_name}</td>
					<td>${empty row.goods_2_name ? '' : row.goods_2_name}</td>
					<td>${empty row.goods_3_name ? '' : row.goods_3_name}</td>
					<td>${empty row.goods_4_name ? '' : row.goods_4_name}</td>
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
            var targetInputId = '${targetInputId}';

            $('#selectButton').on('click', function() {
                var selectedRewardId = $('input[name="reward_select"]:checked').val();
                var selectedRewardName = $('input[name="reward_select"]:checked').closest('tr').find('td').eq(2).text(); // 3번째 td (이름) 가져오기
                if (selectedRewardId) {
                    if (targetInputId) { 
                        opener.$('#' + targetInputId).val(selectedRewardName); // 동적으로 ID 사용!
                    } else {
                        opener.$('#reg_popup_rewarda_name').val(selectedRewardName); // 기본값으로 goods_1에 넣기
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
