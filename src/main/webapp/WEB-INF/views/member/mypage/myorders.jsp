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
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
        .order-item {
            flex: 0 0 48%;
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
        .action_btn {
            background: #FFFFFF;
            color: black;
            width: 50%;
            height: 50px;
            border-radius: 20px;
            border: 1px solid #BABABA;
        }
        .action_btn:hover {
            border: 3px solid black;
        }
        .action_text {
            text-align: center;
            background: #FFF1DB;
            padding: 10px;
            color: black;
            font-weight: bold;
            margin-top: 10px;
        }
        
        .noorder {
            text-align: center;
            align-items: center;
            margin-top: 110px;
            margin-bottom: 100px;
        }
        
        .noorder p {
            font-size: 19px;
            color: #504848;
        }
    </style>
    <script>
        function orderCancel(order_id) {
            if(confirm("주문을 취소하시겠습니까?")) {
                location.href='/orders/cancel.do?order_id='+order_id;
            }
        }
        
        function refundRequest(order_id) {
            if(confirm("환불 신청을 하시겠습니까?")) {
                location.href='/orders/refund.do?order_id='+order_id;
            }
        }
        
        function selectDel(order_id) {
            order_id = order_id;
            location.href = '/orders/delivery_detail.do?order_id='+order_id;
        }
    </script>
</head>
<body>
<c:if test="${param.message == 'success_cancel'}">
    <script>
        alert("주문이 정상적으로 취소되었습니다.");
    </script>
</c:if>

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
            <c:set var="prevOrderStatus" value="" />

            <c:forEach var="orderItem" items="${orders}" varStatus="status">
                <c:if test="${orderItem.ORDER_ID != prevOrderId}">
                    <c:if test="${prevOrderId != -1}">
                        </div> <!-- order-items 닫기 -->
                        <c:choose>
                            <c:when test="${prevOrderStatus eq '결제진행중'}">
                                <div class="btn_wrap">
                                    <button class="action_btn"
                                    onclick="orderCancel(${prevOrderId})">주문취소</button>
                                </div>
                            </c:when>
                            <c:when test="${prevOrderStatus eq '배송준비중' or prevOrderStatus eq '배송중'}">
                                <div class="btn_wrap">
                                    <button class="action_btn" onclick="selectDel(${prevOrderId})">배송조회</button>
                                </div>
                            </c:when>
                            <c:when test="${prevOrderStatus eq '환불완료'}">
                                <p class="action_text">환불이 완료되었습니다.</p>
                            </c:when>
                            <c:when test="${prevOrderStatus eq '배송완료'}">
                                <p class="action_text">배송이 완료되었습니다.</p>
                            </c:when>
                            <c:when test="${prevOrderStatus eq '환불요청'}">
                                <p class="action_text">환불 요청 중인 주문 건입니다.</p>
                            </c:when>
                            <c:otherwise>
                                <div class="btn_wrap">
                                    <button class="action_btn" onclick="refundRequest(${prevOrderId})">
                                        환불요청
                                    </button>
                                </div>
                            </c:otherwise>
                        </c:choose>
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
                    <c:set var="prevOrderId" value="${orderItem.ORDER_ID}" />
                    <c:set var="prevOrderStatus" value="${orderItem.ORDER_STATUS}" />
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

                <c:if test="${status.last}">
                        </div> <!-- order-items 닫기 -->
                        <c:choose>
                            <c:when test="${prevOrderStatus eq '결제진행중'}">
                                <div class="btn_wrap">
                                    <button class="action_btn"
                                    onclick="orderCancel(${prevOrderId})">주문취소</button>
                                </div>
                            </c:when>
                            <c:when test="${prevOrderStatus eq '배송준비중' or prevOrderStatus eq '배송중'}">
                                <div class="btn_wrap">
                                    <button class="action_btn" onclick="selectDel(${prevOrderId})">배송조회</button>
                                </div>
                            </c:when>
                            <c:when test="${prevOrderStatus eq '환불완료'}">
                                <p class="action_text">환불이 완료되었습니다.</p>
                            </c:when>
                            <c:when test="${prevOrderStatus eq '배송완료'}">
                                <p class="action_text">배송이 완료되었습니다.</p>
                            </c:when>
                            <c:when test="${prevOrderStatus eq '환불요청'}">
                                <p class="action_text">환불 요청 중인 주문 건입니다.</p>
                            </c:when>
                            <c:otherwise>
                                <div class="btn_wrap">
                                    <button class="action_btn" onclick="refundRequest(${prevOrderId})">
                                        환불요청
                                    </button>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div> <!-- order-group 닫기 -->
                </c:if>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="noorder">
                <p>주문 내역이 없습니다.</p>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- 페이지네이션 추가 -->
    <div style="text-align:center; margin-top: 30px; font-weight: 600; user-select:none;">
        <c:set var="startPage" value="${(currentPage - 1) / 5 * 5 + 1}" />
        <c:set var="endPage" value="${startPage + 4}" />
        <c:if test="${endPage > totalPages}">
            <c:set var="endPage" value="${totalPages}" />
        </c:if>

        <!-- 이전 버튼 -->
        <c:if test="${currentPage > 1}">
            <a href="${baseUrl}?page=${currentPage - 1}" style="margin: 0 10px; text-decoration:none; color: black;">&lt;</a>
        </c:if>
        <c:if test="${currentPage == 1}">
            <span style="margin: 0 10px; color: #ccc;">&lt;</span>
        </c:if>

        <!-- 페이지 번호 -->
        <c:forEach begin="${startPage}" end="${endPage}" var="i">
            <c:choose>
                <c:when test="${i == currentPage}">
                    <span style="margin: 0 6px; color: #E6AA3A; font-weight: 700;">${i}</span>
                </c:when>
                <c:otherwise>
                    <a href="${baseUrl}?page=${i}" style="margin: 0 6px; color: black; text-decoration:none;">${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <!-- 다음 버튼 -->
        <c:if test="${currentPage < totalPages}">
            <a href="${baseUrl}?page=${currentPage + 1}" style="margin: 0 10px; text-decoration:none; color: black;">&gt;</a>
        </c:if>
        <c:if test="${currentPage == totalPages}">
            <span style="margin: 0 10px; color: #ccc;">&gt;</span>
        </c:if>
    </div>
</div>
</body>
</html>
