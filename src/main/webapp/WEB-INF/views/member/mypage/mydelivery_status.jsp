<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>배송 상세정보</title>
    <style>
    body {
    background-color: #f9f6f0;
    font-family: 'Noto Sans KR', sans-serif;
    color: #3a3a3a;
    margin: 0;
    padding: 0;
}
.del_con {
    width: 860px;
    background: #F5F1EB;
    border-radius: 20px;
    margin: 30px auto;
    border: 2px solid #D8C2A6;
    padding: 30px 40px;
    box-sizing: border-box;
    box-shadow: 0 4px 10px rgba(216, 194, 166, 0.3);
}
.status-bar { 
    display: flex;
    justify-content: space-between;
    margin-bottom: 25px;
    font-weight: 600;
    color: #7a7a7a;
    font-size: 14px;
}
.status-bar .active { 
    color: #D7AB72;
    font-weight: 700;
}
.order-list {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
    margin-top: 30px; 
}
.order-card {
    background: #fff;
    border-radius: 15px;
    box-shadow: 2px 2px 10px rgba(0,0,0,0.08);
    border: 1px solid #ddd;
    width: calc(50% - 10px);
    padding: 15px;
    box-sizing: border-box;
    display: flex;
    gap: 15px;
    align-items: center;
}
.order-card img {
    width: 80px;
    height: 80px;
    border-radius: 15px;
    object-fit: cover;
    box-shadow: 0 2px 6px rgba(0,0,0,0.1);
    flex-shrink: 0;
}
.order-info {
    flex: 1;
    font-size: 14px;
    color: #3a3a3a;
    line-height: 1.4;
}
.order-info .date {
    font-weight: 600;
    margin-bottom: 6px;
    color: #504848;
}
.order-info .desc {
    color: #7a7a7a;
    margin-bottom: 4px;
}
.order-info .quantity-price {
    font-weight: 600;
    color: #504848;
}
.btn-back {
    display: block;
    width: 120px;
    margin: 30px auto 0 auto;
    padding: 12px 0;
    background-color: #D8C2A6;
    color: #504848;
    border: none;
    border-radius: 15px;
    font-weight: 700;
    cursor: pointer;
    box-shadow: 0 3px 6px rgba(216, 194, 166, 0.6);
    transition: background-color 0.3s ease;
}
.btn-back:hover {
    background-color: #BFA66A;
    color: white;
}

/* --- 프로그레스 바 관련 CSS --- */
.progress-container {
    display: flex;
    justify-content: space-between;
    position: relative; 
    margin-bottom: 30px;
    padding: 0 10px; 
    margin-top: 40px; 
}

.progress-line {
    position: absolute; 
    top: 50%; 
    left: 10px; 
    right: 10px; 
    height: 4px;
    background: #ddd; 
    transform: translateY(-50%); 
    z-index: 1; 
    border-radius: 2px;
}

.progress-line.active {
    background: #4C6B3C; 
    position: absolute; 
    top: 50%; 
    left: 10px; 
    height: 4px; 
    transform: translateY(-50%); 
    z-index: 2; 
    border-radius: 2px; 
    transition: width 0.5s ease-in-out; 
}


.progress-step {
    position: relative;
    z-index: 3; 
    width: 24px;
    height: 24px;
    background: #ddd;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 12px;
    color: #7a7a7a;
    font-weight: 600;
    border: 2px solid #ddd; /* 테두리 추가 */
    box-sizing: border-box; /* 패딩/테두리 포함 크기 계산 */
}
.progress-step.active {
    background: #4C6B3C; /* 활성화된 점 색상 - 이미지에 보이는 색으로 변경 */
    color: white;
    border-color: #4C6B3C; /* 활성화된 점 테두리 색상 */
}
.progress-labels {
    display: flex;
    justify-content: space-between;
    margin-top: 8px;
    font-size: 14px;
    color: #7a7a7a;
    font-weight: 600;
    padding: 0 5px;
}
.progress-labels .active {
    color: #4C6B3C; 
    font-weight: 700;
}
    </style>
</head>
<body>

<%
    java.util.Date today = new java.util.Date();
    pageContext.setAttribute("todayDate", today);

    java.util.Calendar cal = java.util.Calendar.getInstance();
    int dayOfWeek = cal.get(java.util.Calendar.DAY_OF_WEEK);
    String[] days = {"일", "월", "화", "수", "목", "금", "토"};
    String todayWeek = days[dayOfWeek - 1];
%>

<%@ include file="../../include/menu.jsp" %>
<div class="del_con">
    <div>
        <img src="/resources/images/back.png" width="15" style="margin-bottom: 10px;" onclick="history.back()">
        <span style="font-size: 25px; color: #4C6B3C; font-weight: bold; margin-left: 20px;">
            <fmt:formatDate value="${todayDate}" pattern="M/d" /> (<%= todayWeek %>)
        </span>
        <span style="font-size: 25px; font-weight:bold;">
            ${deldetails[0].ORDER_STATUS} 이에요
        </span>
    </div>

    <!-- 진행 바 -->
    <div class="progress-container">
        <!-- 배경 라인 -->
        <div class="progress-line"></div>

        <!-- 활성화된 라인 -->
        <c:choose>
            <c:when test="${deldetails[0].ORDER_STATUS == '배송준비중'}">
                <div class="progress-line active" style="width:33%;"></div>
            </c:when>
            <c:when test="${deldetails[0].ORDER_STATUS == '배송중'}">
                <div class="progress-line active" style="width:66%;"></div>
            </c:when>
            <c:when test="${deldetails[0].ORDER_STATUS == '배송완료'}">
                <div class="progress-line active" style="width:100%;"></div>
            </c:when>
            <c:otherwise>
                <div class="progress-line" style="width:0%;"></div>
            </c:otherwise>
        </c:choose>

        <!-- 진행 단계 점 -->
        <c:choose>
            <c:when test="${deldetails[0].ORDER_STATUS == '배송 준비' or deldetails[0].ORDER_STATUS == '배송 중' or deldetails[0].ORDER_STATUS == '배송 완료'}">
                <div class="progress-step active">1</div>
            </c:when>
            <c:otherwise>
                <div class="progress-step">1</div>
            </c:otherwise>
        </c:choose>

        <c:choose>
            <c:when test="${deldetails[0].ORDER_STATUS == '배송 중' or deldetails[0].ORDER_STATUS == '배송 완료'}">
                <div class="progress-step active">2</div>
            </c:when>
            <c:otherwise>
                <div class="progress-step">2</div>
            </c:otherwise>
        </c:choose>

        <c:choose>
            <c:when test="${deldetails[0].ORDER_STATUS == '배송 완료'}">
                <div class="progress-step active">3</div>
            </c:when>
            <c:otherwise>
                <div class="progress-step">3</div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- 라벨 -->
    <div class="progress-labels">
        <c:choose>
            <c:when test="${deldetails[0].ORDER_STATUS == '배송 준비' or deldetails[0].ORDER_STATUS == '배송 중' or deldetails[0].ORDER_STATUS == '배송 완료'}">
                <span class="active">배송 준비</span>
            </c:when>
            <c:otherwise><span>배송 준비</span></c:otherwise>
        </c:choose>

        <c:choose>
            <c:when test="${deldetails[0].ORDER_STATUS == '배송 중' or deldetails[0].ORDER_STATUS == '배송 완료'}">
                <span class="active">배송 중</span>
            </c:when>
            <c:otherwise><span>배송 중</span></c:otherwise>
        </c:choose>

        <c:choose>
            <c:when test="${deldetails[0].ORDER_STATUS == '배송 완료'}">
                <span class="active">배송 완료</span>
            </c:when>
            <c:otherwise><span>배송 완료</span></c:otherwise>
        </c:choose>
    </div>

    <!-- 배송 상세 정보 -->
    <c:choose>
        <c:when test="${empty deldetails}">
            <p>배송 정보가 없습니다.</p>
        </c:when>
        <c:otherwise>
            <div class="order-list">
                <c:forEach var="item" items="${deldetails}">
                    <div class="order-card">
                        <img src="/resources/goods_img/${item.IMG}" />
                        <div class="order-info">
                            <div class="date">${item.ORDER_DATE}</div>
                            <div class="desc">${item.PRODUCT_NAME} | ${item.QUANTITY}개</div>
                            <div class="quantity-price">
	                            <fmt:formatNumber value="${item.UNIT_PRICE}" />원
                            </div>
                            
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

    <button class="btn-back" onclick="history.back()">뒤로 가기</button>
</div>

</body>
</html>
