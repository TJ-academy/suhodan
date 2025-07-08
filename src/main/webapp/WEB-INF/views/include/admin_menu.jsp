<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<a href="/" style="display:inline-block; vertical-align:middle; text-align: left;">
  <img src="../../resources/images/설화수 로고.png" alt="설화수 로고" style="width:200px; height:auto;" />
</a>

<a href="/admin/member_list.do">회원 관리</a> |
<a href="/admin/legend_list.do">설화 관리</a> |
<a href="/admin/reward_list.do">리워드 관리</a> |
<a href="/admin/goods_list.do">굿즈 관리</a> |
<a href="/admin/badge_list.do">명패 관리</a> |
<a href="#">통계 관리</a> |

<div style="text-align:right;">
	<c:choose>
		<c:when test="${sessionScope.user_id == null}">
			<a href="login.do">로그인</a> |
			<a href="join.do">회원가입</a>
		</c:when>
		<c:otherwise>
			${sessionScope.name}님이 로그인중입니다.
			<a href="/logout.do">로그아웃</a> |
		</c:otherwise>
	</c:choose>
</div>
<hr>