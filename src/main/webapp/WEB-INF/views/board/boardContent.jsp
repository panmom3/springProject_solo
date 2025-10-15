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
					<td colspan="3" style="min-height:200px">${fn:replace(vo.content, newLine, "<br/>")}</td>
				</tr>
			</tbody>
		</table>
		<div class="floatbox btn_group clearfix">
			<div class="floatleft">
				<input type="button" value="돌아가기" class="btn type1 small">
			</div>
			<div class="floatright">
				<input type="button" value="수정" class="btn type2 small">
				<input type="button" value="삭제" class="btn type3 small">
			</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>