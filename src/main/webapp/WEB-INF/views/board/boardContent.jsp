<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=Edge" />
  <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, maximum-scale=2.0, minimum-scale=1.0, user-scalable=yes" />
  <meta name="description" content="" />
  <meta name="author" content="" />
  <jsp:include page="/WEB-INF/views/include/sub.jsp" />
	<title>커뮤니티-상세보기</title>
	<script>
		'use strict';
		
		// 게시글 삭제처리
		function deleteCheck() {
			let ans = confirm("현재 게시글을 삭제하시겠습니까?");
			if(ans) location.href="boardDelete?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}";
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/header.jsp">
  <jsp:param name="bgImage" value="home-bg.jpg"/>
  <jsp:param name="siteTitle" value="커뮤니티"/>
  <jsp:param name="subTitle" value="게시글 상세보기"/>
</jsp:include>
<div class="container px-4 px-lg-5"  style="min-height:500px">
	<div class="p-wrap bbs bbs__form bbs_new_skin">
		<table class="p-table mobile block">
			<caption>글내용보기</caption>
			<colgroup>
				<col class="w20p">
				<col>
			</colgroup>
			<tbody class="p-table--th-left">
				<tr>
					<th>작성자</th>
					<td>${vo.nickName}</td>
					<th>작성일</th>
					<td>${vo.WDate}</td>
				</tr>
				<tr>
					<th>글제목</th>
					<td colspan="3">${vo.title}</td>
				</tr>
				<tr>
					<th>글내용</th>
					<td colspan="3">${fn:replace(vo.content, newLine, "<br/>")}</td>
				</tr>
			</tbody>
		</table>
		<div class="floatbox btn_group clearfix">
			<div class="floatleft">
				<input type="button" value="돌아가기" onclick="location.href='boardList?pag=${pag}&pageSize=${pageSize}';" class="btn type1 medium">
			</div>
			<div class="floatright">
			<c:if test="${sMid == vo.mid || sLevel == 0}">
				<c:if test="${sMid == vo.mid}">
					<input type="button" value="수정" onclick="location.href='boardUpdate?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}';" class="btn type2 medium">
				</c:if>
				<input type="button" value="삭제" onclick="deleteCheck()" class="btn type3 medium">
			</c:if>
			</div>
		</div>
		<%-- 디버깅용: 세션 값 확인 --%>
		<p>sMid: ${sMid}</p>
		<p>sLevel: ${sLevel}</p>
		<!-- 이전글/다음글 -->
		<div class="bbsmovebox">
			<div class="move_item prev clearfix">
				<div class="move_title"><em>이전글</em></div>
				<div class="move_text">
					<c:if test="${!empty preVO.title}">
						<a class="move_link" href="boardContent?idx=${preVO.idx}&pag=${pag}&pageSize=${pageSize}">${preVO.title}</a>
					</c:if>
				</div>
				<c:if test="${!empty preVO.title}">
					<div class="move_date">${fn:substring(vo.WDate,0,10)}</div>
				</c:if>
			</div>
			<div class="move_item next clearfix">
				<div class="move_title"><em>다음글</em></div>
				<div class="move_text">
					<c:if test="${!empty nextVO.title}">
						<a class="move_link" href="boardContent?idx=${nextVO.idx}&pag=${pag}&pageSize=${pageSize}">${nextVO.title}</a>
					</c:if>
				</div>
				<c:if test="${!empty nextVO.title}">
					<div class="move_date">${fn:substring(vo.WDate,0,10)}</div>
				</c:if>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>