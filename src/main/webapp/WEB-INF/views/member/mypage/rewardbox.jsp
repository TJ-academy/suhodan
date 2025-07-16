<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>리워드함</title>
</head>
<body>

<div class="reward-list">
    <c:forEach var="reward" items="${rewardList}">
        <div class="reward-item" onclick="location.href='rewardDetail.do?rewardId=${reward.rewardId}'">
            <img src="${reward.thumbnail}" alt="썸네일">
            <div>
                <p>${reward.region}</p>
                <p>${reward.title}</p>
                <p>${reward.period}</p>
                <p>총 ${reward.amount}원</p>
            </div>
        </div>
    </c:forEach>
</div>

</body>
</html>
