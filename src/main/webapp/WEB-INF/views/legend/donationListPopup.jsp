<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="donation-list">
    <c:choose>
        <c:when test="${not empty donationList}">
            <ul class="donation-ul">
                <c:forEach var="item" items="${donationList}">
                    <li>
                        <a href="/donation/detail/${item.contentId}" target="_blank">
                            ${item.donationTitle}
                        </a>
                        <span class="donation-location">(${item.donationLocation})</span>
                    </li>
                </c:forEach>
            </ul>
        </c:when>
        <c:otherwise>
            <p>'${location}' 지역에는 현재 등록된 기부 콘텐츠가 없습니다.</p>
        </c:otherwise>
    </c:choose>
</div>

<style>
.donation-list {
    max-height: 300px;
    overflow-y: auto;
    padding: 10px;
    margin-top: 15px;
    border-radius: 8px;
    background-color: #f8eee4;
	border: 1px solid #d7c4b0;
}

.donation-ul {
    list-style: none;
    padding: 0;
    margin: 0;
}

.donation-ul li {
    padding: 10px 0;
    border-bottom: 1px solid #D8C2A6;
    font-size: 16px;
}

.donation-ul li:last-child {
    border-bottom: none;
}

.donation-ul a {
    text-decoration: none;
    color: #848282;
    font-weight: bold;
    transition: color 0.2s;
}

.donation-ul a:hover {
    color: #2e2e2e;
}

.donation-location {
    color: #B7C9AE;
    margin-left: 5px;
    font-size: 14px;
}
</style>
