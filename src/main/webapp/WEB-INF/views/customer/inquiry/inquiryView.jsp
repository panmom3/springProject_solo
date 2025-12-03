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
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="" />
  <meta name="author" content="" />
  <jsp:include page="/WEB-INF/views/include/sub.jsp" />
	<title>문의내용보기</title>
	<script>
	'use strict';
	
	function updateCheck() {
		var ans = confirm("수정하시겠습니까?");
		if(!ans) return false;
		else location.href="${ctp}/customer/inquiry/inquiryUpdate?idx=${vo.idx}&pag=${pag}";
	}
	
	function deleteCheck() {
		var ans = confirm("삭제하시겠습니까?");
		if(!ans) return false;
		else location.href="${ctp}/customer/inquiry/inquiryDelete?idx=${vo.idx}&fSName=${vo.FSName}";
	}
	</script>
</head>
<body id="sub" class="sub">
<div id="wrapper">
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<div id="container">
		<jsp:include page="/WEB-INF/views/include/header.jsp">
  		<jsp:param name="bgImage" value="sub_visual.png"/>
  		<jsp:param name="siteTitle" value="문의내용보기"/>
  		<jsp:param name="subTitle" value=""/>
		</jsp:include>
		<div class="wrap clearfix">
			<main id="colgroup" class="colgroup">
				<article>
					<div id="contents">
						<table class="table type2">
							<caption>1:1문의 상세보기</caption>
							<colgroup>
								<col class="w20p"/>	
								<col class="w30p"/>	
								<col class="w20p"/>	
								<col class="w30p"/>	
							</colgroup>
							<tbody>
								<tr>
									<th scope="row">제목</th>
									<td colspan="3">${vo.title}</td>
								</tr>
								<tr>
									<th scope="row">문의유형</th>
									<td>${vo.part}</td>
									<th scope="row">작성일</th>
									<td>${fn:substring(vo.WDate,0,10)}</td>
								</tr>
								<tr>
									<td colspan="4">
										<c:if test="${!empty vo.FSName}">
									    <c:set var="ext" value="${fn:toLowerCase(fn:substringAfterLast(vo.FSName, '.'))}" />
									    <c:set var="imgExt" value="jpg,png,gif" />
									
									    <c:if test="${fn:contains(imgExt, ext)}">
									        <img src="${ctp}/data/inquiry/${vo.FSName}" width="400px"><br/>
									    </c:if>
									
									    <c:if test="${!fn:contains(imgExt, ext)}">
									        <a href="${ctp}/data/inquiry/${vo.FSName}" download>📄 ${vo.FSName}</a><br/>
									    </c:if>
										</c:if>
										<br/>
										<p>${fn:replace(vo.content,newLine,"<br/>")}<br/></p>
									</td>
								</tr>
							</tbody>
						</table>
						
						<!-- 관리자가 답변을 달았을때는 현재글을 수정/삭제 처리 못하도록 하고 있다. -->
						<div class="row margin_t_50 margin_b_50">
							<div class="col-12 left">
								<input type="button" value="목록" onclick="location.href='${ctp}/customer/inquiry/inquiryList?pag=${pag}'" class="btn medium type2" />
							</div>
							<c:if test="${empty reVO.reContent}">
								<div class="col-12 right">
									<input type="button" value="수정" onclick="updateCheck()" class="btn medium type1" />
									<input type="button" value="삭제" onclick="deleteCheck()" class="btn medium type3" />
								</div>	
							</c:if>
						</div>

						<!-- 관리자가 답변을 달았을때 보여주는 구역 -->
						<c:if test="${!empty reVO.reContent}">
							<form name="replyForm">
								<label for="reContent">관리자 답변</label>
								<textarea name="reContent" rows="5"  id="reContent" readonly="readonly" class="p-input">${reVO.reContent}</textarea>
							</form>
						</c:if>
					</div><!-- //#contents -->
				</article>
			</main>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</div>
</body>
</html>