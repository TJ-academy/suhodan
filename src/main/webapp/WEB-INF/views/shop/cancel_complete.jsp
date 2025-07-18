<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>환불 요청 완료</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
<style>
:root {
  --primary-color: #5D4037;
  --secondary-color: #8D6E63;
  --accent-color: #D7CCC8;
  --light-bg: #EFEBE9;
  --text-dark: #3E2723;
  --text-light: #795548;
  --white: #FFFFFF;
  --success-color: #4CAF50;
}

body {
  background-color: var(--light-bg);
  font-family: 'Noto Sans KR', sans-serif;
  margin: 0;
  padding: 0;
  line-height: 1.6;
}

.container {
  max-width: 720px;
  margin: 50px auto;
  background-color: var(--white);
  border-radius: 16px;
  padding: 40px;
  box-shadow: 0 8px 24px rgba(0,0,0,0.08);
  position: relative;
  overflow: hidden;
}

.container::before {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 8px;
  background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
}

.title {
  font-size: 28px;
  color: var(--primary-color);
  font-weight: 700;
  margin-bottom: 30px;
  text-align: center;
  position: relative;
  padding-bottom: 15px;
}

.title::after {
  content: "";
  position: absolute;
  bottom: 0;
  left: 50%;
  transform: translateX(-50%);
  width: 80px;
  height: 3px;
  background-color: var(--accent-color);
}

.refund-info {
  margin: 30px 0;
  padding: 25px;
  background-color: rgba(215, 204, 200, 0.2);
  border-radius: 12px;
  border-left: 4px solid var(--secondary-color);
}

.refund-info div {
  display: flex;
  justify-content: space-between;
  font-size: 17px;
  color: var(--text-dark);
  margin-bottom: 12px;
  padding: 8px 0;
}

.refund-info div span:first-child {
  font-weight: 500;
  color: var(--text-light);
}

.refund-info div span:last-child {
  font-weight: 600;
  color: var(--primary-color);
}

.canceled-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 20px;
  margin: 20px 0;
  background-color: var(--white);
  border-radius: 10px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.05);
  border: 1px solid rgba(141, 110, 99, 0.1);
}

.item-left {
  display: flex;
  flex-direction: column;
  flex-grow: 1;
}

.item-name {
  font-weight: 600;
  color: var(--text-dark);
  font-size: 16px;
  margin-bottom: 8px;
  display: flex;
  align-items: center;
}

.item-name::before {
  content: "✓";
  color: var(--success-color);
  margin-right: 8px;
  font-size: 18px;
}

.item-desc {
  font-size: 14px;
  color: var(--text-light);
  line-height: 1.5;
}

.btn-container {
  text-align: center;
  margin-top: 40px;
}

.btn {
  display: inline-block;
  min-width: 180px;
  padding: 14px 28px;
  background-color: var(--primary-color);
  color: var(--white);
  border: none;
  border-radius: 30px;
  text-align: center;
  font-size: 16px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 4px 12px rgba(93, 64, 55, 0.2);
}

.btn:hover {
  background-color: var(--secondary-color);
  transform: translateY(-2px);
  box-shadow: 0 6px 16px rgba(93, 64, 55, 0.3);
}

/* 반응형 디자인 */
@media (max-width: 768px) {
  .container {
    margin: 20px;
    padding: 25px;
  }
  
  .title {
    font-size: 24px;
  }
  
  .refund-info, .canceled-item {
    padding: 15px;
  }
}
</style>
</head>
<body>
<%@ include file="../include/menu.jsp" %>

<div class="container">
  <div class="title">환불 요청이 완료되었습니다</div>

  <div class="refund-info">
    <div>
      <span>환불 예정 금액</span>
      <span><fmt:formatNumber value="${dto.order_amount}" pattern="#,###"/>원</span>
    </div>
  </div>

  <div class="canceled-item">
    <div class="item-left">
      <div class="item-name">주문 번호 | ${dto.order_id}</div>
      <div class="item-desc">${dto.refund_bank} | ${dto.refund_account}</div>
    </div>
  </div>

  <div class="btn-container">
    <button class="btn" onclick="location.href='/orders/list.do'">주문 목록으로 돌아가기</button>
  </div>
</div>

</body>
</html>