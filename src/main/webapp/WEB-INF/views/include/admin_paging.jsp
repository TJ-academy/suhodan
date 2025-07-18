<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="pagination">
	<c:choose>
		<c:when test="${currentPage > 1}">
			<c:url var="prevPageLink" value="">
				<c:choose>
					<c:when test="${currentCategory == 'admin_goods'}">
						<c:set var="baseUrl" value="goods_list.do" />
					</c:when>
					<c:when test="${currentCategory == 'admin_order'}">
						<c:set var="baseUrl" value="order_list.do" />
					</c:when>
					<c:when test="${currentCategory == 'admin_member'}">
						<c:set var="baseUrl" value="member_list.do" />
					</c:when>
					<c:when test="${currentCategory == 'admin_legend'}">
						<c:set var="baseUrl" value="legend_list.do" />
					</c:when>
					<c:when test="${currentCategory == 'admin_donation'}">
						<c:set var="baseUrl" value="donation_list.do" />
					</c:when>
					<c:when test="${currentCategory == 'admin_badge'}">
						<c:set var="baseUrl" value="badge_list.do" />
					</c:when>
					<c:when test="${currentCategory == 'admin_user_badge'}">
						<c:set var="baseUrl" value="user_badge_list.do" />
					</c:when>
					<c:when test="${currentCategory == 'admin_reward'}">
						<c:set var="baseUrl" value="reward_list.do" />
					</c:when>
					<c:when test="${currentCategory == 'admin_reward_find_goods'}">
						<c:set var="baseUrl" value="reward_find_goods.do" />
					</c:when>
					<c:otherwise>
						<c:set var="baseUrl" value="#" />
						<%-- 정의되지 않은 카테고리를 위한 대체 URL --%>
					</c:otherwise>
				</c:choose>
				<c:param name="page" value="${currentPage - 1}" />
				<c:param name="searchType" value="${searchType}" />
				<c:param name="searchKeyword" value="${searchKeyword}" />
				<c:param name="sortBy" value="${sortBy}" />
				<c:param name="sortOrder" value="${sortOrder}" />
				<c:param name="targetInputId" value="${targetInputId}" />
			</c:url>
			<a href="${prevPageLink}" id="prev-page">&lt; 이전</a>
		</c:when>
		<c:otherwise>
			<span id="prev-page-disabled">&lt; 이전</span>
		</c:otherwise>
	</c:choose>

	<c:forEach var="i" begin="1" end="${totalPage}">
		<c:url var="pageLink" value="">
			<c:choose>
				<c:when test="${currentCategory == 'admin_goods'}">
					<c:set var="baseUrl" value="goods_list.do" />
				</c:when>
				<c:when test="${currentCategory == 'admin_order'}">
					<c:set var="baseUrl" value="order_list.do" />
				</c:when>
				<c:when test="${currentCategory == 'admin_member'}">
					<c:set var="baseUrl" value="member_list.do" />
				</c:when>
				<c:when test="${currentCategory == 'admin_legend'}">
					<c:set var="baseUrl" value="legend_list.do" />
				</c:when>
				<c:when test="${currentCategory == 'admin_donation'}">
					<c:set var="baseUrl" value="donation_list.do" />
				</c:when>
				<c:when test="${currentCategory == 'admin_badge'}">
					<c:set var="baseUrl" value="badge_list.do" />
				</c:when>
				<c:when test="${currentCategory == 'admin_user_badge'}">
					<c:set var="baseUrl" value="user_badge_list.do" />
				</c:when>
				<c:when test="${currentCategory == 'admin_reward'}">
					<c:set var="baseUrl" value="reward_list.do" />
				</c:when>
				<c:when test="${currentCategory == 'admin_reward_find_goods'}">
					<c:set var="baseUrl" value="reward_find_goods.do" />
				</c:when>
				<c:otherwise>
					<c:set var="baseUrl" value="#" />
					<%-- 정의되지 않은 카테고리를 위한 대체 URL --%>
				</c:otherwise>
			</c:choose>
			<c:param name="page" value="${i}" />
			<c:param name="searchType" value="${searchType}" />
			<c:param name="searchKeyword" value="${searchKeyword}" />
			<c:param name="sortBy" value="${sortBy}" />
			<c:param name="sortOrder" value="${sortOrder}" />
			<c:param name="targetInputId" value="${targetInputId}" />
		</c:url>
		<c:choose>
			<c:when test="${i == currentPage}">
				<strong id="current-page">[${i}]</strong>
			</c:when>
			<c:otherwise>
				<a href="${pageLink}" id="page-${i}">[${i}]</a>
			</c:otherwise>
		</c:choose>
	</c:forEach>

	<c:choose>
		<c:when test="${currentPage < totalPage}">
			<c:url var="nextPageLink" value="">
				<c:choose>
					<c:when test="${currentCategory == 'admin_goods'}">
						<c:set var="baseUrl" value="goods_list.do" />
					</c:when>
					<c:when test="${currentCategory == 'admin_order'}">
						<c:set var="baseUrl" value="order_list.do" />
					</c:when>
					<c:when test="${currentCategory == 'admin_member'}">
						<c:set var="baseUrl" value="member_list.do" />
					</c:when>
					<c:when test="${currentCategory == 'admin_legend'}">
						<c:set var="baseUrl" value="legend_list.do" />
					</c:when>
					<c:when test="${currentCategory == 'admin_donation'}">
						<c:set var="baseUrl" value="donation_list.do" />
					</c:when>
					<c:when test="${currentCategory == 'admin_badge'}">
						<c:set var="baseUrl" value="badge_list.do" />
					</c:when>
					<c:when test="${currentCategory == 'admin_user_badge'}">
						<c:set var="baseUrl" value="user_badge_list.do" />
					</c:when>
					<c:when test="${currentCategory == 'admin_reward'}">
						<c:set var="baseUrl" value="reward_list.do" />
					</c:when>
					<c:when test="${currentCategory == 'admin_reward_find_goods'}">
						<c:set var="baseUrl" value="reward_find_goods.do" />
					</c:when>
					<c:otherwise>
						<c:set var="baseUrl" value="#" />
						<%-- 정의되지 않은 카테고리를 위한 대체 URL --%>
					</c:otherwise>
				</c:choose>
				<c:param name="page" value="${currentPage + 1}" />
				<c:param name="searchType" value="${searchType}" />
				<c:param name="searchKeyword" value="${searchKeyword}" />
				<c:param name="sortBy" value="${sortBy}" />
				<c:param name="sortOrder" value="${sortOrder}" />
				<c:param name="targetInputId" value="${targetInputId}" />
			</c:url>
			<a href="${nextPageLink}" id="next-page">다음 &gt;</a>
		</c:when>
		<c:otherwise>
			<span id="next-page-disabled">다음 &gt;</span>
		</c:otherwise>
	</c:choose>
</div>