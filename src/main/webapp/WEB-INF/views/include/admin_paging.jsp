<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="pagination">
	<!-- 이전 버튼 -->
	<c:choose>
		<c:when test="${currentPage > 1}">
			<a
				href="${currentCategory == 'admin_goods' ? 'goods_list.do' : 
            currentCategory == 'admin_member' ? 'member_list.do' : 
            currentCategory == 'admin_legend' ? 'legend_list.do' : 
            currentCategory == 'admin_donation' ? 'donation_list.do' : 
            currentCategory == 'admin_badge' ? 'badge_list.do' : ''}?page=${currentPage-1}"
				id="prev-page">&lt; 이전</a>
			<!-- '이전' 버튼 -->
		</c:when>
		<c:otherwise>
			<span id="prev-page-disabled">&lt; 이전</span>
			<!-- 비활성화된 '이전' 버튼 -->
		</c:otherwise>
	</c:choose>

	<!-- 페이지 번호들 -->
	<c:forEach var="i" begin="1" end="${totalPage}">
		<c:choose>
			<c:when test="${i == currentPage}">
				<strong id="current-page">[${i}]</strong>
				<!-- 현재 페이지 강조 -->
			</c:when>
			<c:otherwise>
				<a
					href="${currentCategory == 'admin_goods' ? 'goods_list.do' : 
            currentCategory == 'admin_member' ? 'member_list.do' : 
            currentCategory == 'admin_legend' ? 'legend_list.do' : 
            currentCategory == 'admin_donation' ? 'donation_list.do' : 
            currentCategory == 'admin_badge' ? 'badge_list.do' : ''}?page=${i}"
					id="page-${i}">[${i}]</a>
				<!-- 페이지 링크 -->
			</c:otherwise>
		</c:choose>
	</c:forEach>

	<!-- 다음 버튼 -->
	<c:choose>
		<c:when test="${currentPage < totalPage}">
            <<a
				href="${currentCategory == 'admin_goods' ? 'goods_list.do' : 
            currentCategory == 'admin_member' ? 'member_list.do' : 
            currentCategory == 'admin_legend' ? 'legend_list.do' : 
            currentCategory == 'admin_donation' ? 'donation_list.do' : 
            currentCategory == 'admin_badge' ? 'badge_list.do' : ''}?page=${currentPage+1}"
				id="next-page">다음 &gt;</a>
			<!-- '다음' 버튼 -->
		</c:when>
		<c:otherwise>
			<span id="next-page-disabled">다음 &gt;</span>
			<!-- 비활성화된 '다음' 버튼 -->
		</c:otherwise>
	</c:choose>
</div>
