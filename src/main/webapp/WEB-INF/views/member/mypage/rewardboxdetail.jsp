<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>리워드 상세</title>
</head>
<body>

<div class="reward-detail">
    <img src="${reward.thumbnail}" alt="썸네일">
    <p>${reward.region}</p>
    <p>${reward.title}</p>
    <p>${reward.period}</p>
    <p>${reward.detail}</p>
    <p>총 ${reward.amount}원</p>
    
    <div class="reward-items">
        <c:forEach var="item" items="${reward.itemList}">
            <img src="${item.image}" alt="${item.name}">
        </c:forEach>
    </div>

    <button onclick="location.href='badge.do?rewardId=${reward.rewardId}'">명패 보기</button>
    <button onclick="location.href='shipping.do?rewardId=${reward.rewardId}'">배송 조회</button>
</div>

</body>
</html>
