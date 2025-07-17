<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>내 주문 목록</title>
    <style>
        body {
            background-color: #f9f6f0;
            font-family: 'Noto Sans KR', sans-serif;
            color: #3a3a3a;
            margin: 0;
            padding: 0;
        }
        .order_con {
            width: 860px;
            background: #F5F1EB;
            border-radius: 20px;
            margin: 30px auto;
            border: 2px solid #D8C2A6;
            padding: 30px 40px;
            box-sizing: border-box;
            box-shadow: 0 4px 10px rgba(216, 194, 166, 0.3);
        }
        .header-bar {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }
        .header-bar a img {
            display: block;
            margin-right: 15px;
            cursor: pointer;
        }
        .header-bar img.icon {
            margin-right: 10px;
        }
        .header-bar span {
            font-size: 22px;
            font-weight: 700;
            color: #2E2E2E;
            line-height: 1.2;
        }
        hr.divider {
            border: none;
            border-top: 2px solid #D7AB72;
            margin: 15px 0 25px 0;
        }
        .order-group {
            background-color: #fcfcfc;
            border-radius: 15px;
            padding: 25px 30px;
            margin-bottom: 30px;
            box-shadow: 2px 2px 10px rgba(0,0,0,0.08);
            border: 1px solid #ddd;
        }
        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 18px;
        }
        .order-date {
            font-size: 24px;
            font-weight: 700;
            color: #504848;
            position: relative;
        }
        .order-number {
            font-size: 13px;
            color: #7a7a7a;
            font-weight: 400;
            margin-left: 12px;
        }
        .order-status {
            font-size: 14px;
            font-weight: 600;
            color: #ff9800;
        }
        .order-status.completed {
            color: #4CAF50;
        }
        .pay-method {
            font-size: 14px;
            color: #555;
            margin-right: 10px;
        }
        .order-items {
            display: flex;       /* 가로 나란히 */
            flex-wrap: wrap;     /* 줄 바꿈 가능 */
            gap: 20px;           /* 상품들 사이 간격 */
        }
        .order-item {
            flex: 0 0 48%;       /* 한 줄에 2개씩 */
            display: flex;
            background: #fff;
            border-radius: 15px;
            box-shadow: 1px 1px 6px rgba(0,0,0,0.05);
            padding: 15px;
            align-items: center;
            gap: 15px;
            box-sizing: border-box;
        }
        .order-item img {
            width: 112px;
            height: 112px;
            object-fit: cover;
            border-radius: 15px;
            flex-shrink: 0;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }
        .item-info {
            font-size: 15px;
            color: #3a3a3a;
            line-height: 1.4;
        }
        .item-info div {
            margin-bottom: 6px;
        }
        .item-info .product-name {
            font-weight: 600;
            font-size: 16px;
            margin-bottom: 8px;
            color: #2e2e2e;
        }
        .item-info .quantity,
        .item-info .unit-price,
        .item-info .total-price {
            font-weight: 400;
            color: #666;
        }
        .btn_wrap {
        	display: flex;
        	justify-content: center;
        	margin-top: 10px;
        }
        .cancle_btn {
        	background: #E6AA3A;
        	color: white;
        	width: 50%;
        	height: 50px;
        	border-radius: 20px;
        	border-style: none;
        }
        .cancle_btn:hover {
        	background: #AB501F;
        }
    </style>
</head>
<body>
<%@ include file="../../include/menu.jsp" %>

<div class="order_con">
    <div class="header-bar">
        <a href="/mypage">
            <img src="/resources/images/back.png" width="15" alt="뒤로가기" />
        </a>
        <img src="/resources/suhodan_images/icon/clipboard.png" width="30" alt="주문내역 아이콘" class="icon" />
        <span>주문내역</span>
    </div>
    <hr class="divider" />

    <c:choose>
        <c:when test="${not empty orders}">
            <c:set var="prevOrderId" value="-1" />

            <c:forEach var="orderItem" items="${orders}" varStatus="status">
                <c:if test="${orderItem.ORDER_ID != prevOrderId}">
                    <c:if test="${prevOrderId != -1}">
                        </div> <!-- order-items 닫기 -->   
                        <div class="btn_wrap">
	                        <button class="cancle_btn">주문취소</button>
                        </div>  
                        </div> <!-- order-group 닫기 -->
                        <hr class="divider" />
                    </c:if>
                    <div class="order-group">
                        <div class="order-header">
                            <div class="order-date">
                                <fmt:formatDate value="${orderItem.ORDER_DATE}" pattern="yyyy-MM-dd"/>
                                <span class="order-number">(주문 번호 : ${orderItem.ORDER_ID})</span>
                            </div>
                            <div>
                                <span class="pay-method">${orderItem.PAY_METHOD}</span> |
                                <strong class="order-status ${orderItem.ORDER_STATUS ne '결제진행중' ? 'completed' : ''}">
                                    ${orderItem.ORDER_STATUS}
                                </strong>
                            </div>
                        </div>
                        <div class="order-items">
                </c:if>

                <div class="order-item">
                    <img src="/resources/goods_img/${orderItem.IMG}" alt="${orderItem.PRODUCT_NAME}" />
                    <div class="item-info">
                        <div class="product-name">${orderItem.PRODUCT_NAME}</div>
                        <div class="quantity">수량: ${orderItem.QUANTITY}</div>
                        <div class="unit-price">단가: <fmt:formatNumber value="${orderItem.UNIT_PRICE}" type="currency" currencySymbol="₩"/></div>
                        <div class="total-price">총 가격: <fmt:formatNumber value="${orderItem.QUANTITY * orderItem.UNIT_PRICE}" type="currency" currencySymbol="₩"/></div>
                    </div>
                </div>

                <c:set var="prevOrderId" value="${orderItem.ORDER_ID}" />

                <c:if test="${status.last}">
                        </div> <!-- order-items 닫기 -->
                        <div class="btn_wrap">
	                        <button class="cancle_btn">주문취소</button>
                        </div> 
                    </div> <!-- order-group 닫기 -->
                </c:if>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <p>아직 주문 내역이 없어요! 😢 다시 주문해주떼염!</p>
        </c:otherwise>
    </c:choose>
</div>

</body>
</html>