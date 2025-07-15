<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 설화 보기</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="/css/legendList.css">
</head>
<body>
	<%@ include file="../include/menu.jsp"%>

	<div class="outer-box">
	<button class="back-button" onclick="history.back();">
		<img src="/resources/images/back.png" alt="뒤로가기 아이콘">
	</button>
	<!-- 상단 로고 및 제목 -->
	<div class="list">
		<img src="/resources/images/logo_no_text.png" alt="로고">
		<h2>전체 설화 보기</h2>
	</div>
		
	<form method="get" action="/legend/legend.do" class="search-bar">
		<select name="search_option" class="search_style">
			<option value="all" ${search_option == 'all' ? 'selected' : ''}>전체</option>
			<option value="loca" ${search_option == 'loca' ? 'selected' : ''}>지역</option>
			<option value="con" ${search_option == 'con' ? 'selected' : ''}>내용</option>
		</select>
		<input type="text" name="search_keyword" placeholder="검색어를 입력해주세요." value="${search_keyword}">
		<button type="submit">
			<img src="/resources/images/search-icon.png" alt="검색">
		</button>
	</form>

	<!-- 카드 리스트 -->
	<div class="card-grid">
		<c:forEach var="row" items="${list}">
			<div class="legend-card">
				<!-- 날짜 -->
				<div class="legend-data">
					<fmt:formatDate value="${row.reg_date}" pattern="yyyy.MM.dd" />
				</div>
	
				<!-- 이미지: DB에서 가져온 이미지 경로 -->
				<div class="image-container">
					<img src="../../resources/legend_img/${row.img}" alt="설화 이미지"> <a
						href="/legend/detail/${row.legend_id}">
						<button class="hover-button">자세히 보기</button>
					</a>
				</div>
	
				<!-- 텍스트 콘텐츠 -->
				<div class="legend-content">
					<c:set var="mainArea" value="${fn:split(row.location, ' ')[0]}" />
					<c:set var="subArea" value="${fn:split(row.location, ' ')[1]}" />
					<div class="legend-location">
						<span style="font-weight: normal;">${mainArea}</span> <span
							style="font-weight: bold;"> ${subArea}</span>
					</div>
					<div class="legend-title">${row.title}</div>
					<div class="legend-desc">
						<c:out value="${row.story}" />
					</div>
				</div>
			</div>
		</c:forEach>
	</div> 
	<!-- 페이지네이션 부분 -->
	 <div style="text-align: center; margin-top: 20px;">
	   <c:if test="${currentPage > 1}">
	     <button onclick="location.href='?page=${currentPage - 1}&search_option=${search_option}&search_keyword=${search_keyword}'" class="page_btn">이전</button>
	   </c:if>	
	   <c:if test="${currentPage < totalPage}">
	     <button onclick="location.href='?page=${currentPage + 1}&search_option=${search_option}&search_keyword=${search_keyword}'" class="page_btn">다음</button>
	   </c:if>
	 </div>
</div>

</body>
</html>