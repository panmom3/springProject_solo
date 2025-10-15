<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
	<title>소통게시판</title>
	<script>
	'use strict';
	
	function pageSizeCheck() {
		let pageSize = $("#pageSize").val();
		location.href = "boardList?pageSize="+pageSize;
	}
	
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/header.jsp">
  <jsp:param name="bgImage" value="home-bg.jpg"/>
  <jsp:param name="siteTitle" value="커뮤니티"/>
  <jsp:param name="subTitle" value="이지트립 커뮤니티게시판입니다."/>
</jsp:include>
<div class="container px-4 px-lg-5 pb-5">
	<div class="p-wrap bbs bbs__list bbs_new_skin bbs_normal">
		<div class="boardtopbox">
			<i class="icon"></i>
			<div class="box_wrap">
				<div class="box_title">커뮤니티 게시판</div>
				<div class="textbox">
					<p>회원간 소통하는 커뮤니티 게시판입니다.</p>
				</div>
			</div>
		</div>
		<!-- -->
		<div class="row">
			<div class="col-9 col-sm-24 margin_t_10 small">
				<div class="bbs_page">
					<span class="item count">총게시물 : <em>2</em>건</span>
					<span class="item pageSize">페이지
						<select name="pageSize" id="pageSize" onchange="pageSizeCheck()">
							<option ${pageVO.pageSize == 5 ? 'selected' : ''}>5</option>
							<option ${pageVO.pageSize == 10 ? 'selected' : ''}>10</option>
							<option ${pageVO.pageSize == 15 ? 'selected' : ''}>15</option>
							<option ${pageVO.pageSize == 20 ? 'selected' : ''}>20</option>
							<option ${pageVO.pageSize == 30 ? 'selected' : ''}>30</option>
						</select>
					</span>
				</div>
			</div>
			<div class="col-15 col-sm-24 right top_select">
				<form name="searchForm" method="get" action="boardSearchList">
					<select name="search" id="search" class="p-input p-input--auto" title="검색영역선택">
						<option value="title">글제목</option>
						<option value="nickName">글쓴이</option>
						<option value="content">글내용</option>
					</select>
					<input type="text" name="searchString" id="searchString" class="p-input p-input--auto board_search" required />
					<input type="submit" class="p-button primary" value="검색"/>
				</form>
			</div>
		</div>
		<!-- 게시판테이블 -->
		<div class="table-responsive">
			<table class="p-table simple" data-table="rwd" data-tabletype="simple" data-breakpoint="760">
				<caption>커뮤니티 게시판 목록 - 번호, 제목, 작성자, 작성일, 조회수 정보  제공</caption>
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">제목</th>
						<th scope="col">작성자</th>
						<th scope="col">작성일</th>
						<th scope="col">조회수</th>
					</tr>
				</thead>
				<tbody class="text_center">
				<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
				<c:forEach var="vo" items="${vos}" varStatus="st">
					<tr>
						<td><span class="bbs_num">${curScrStartNo}</span></td>
						<td class="p-subject">
							<a href="boardContent?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}">${vo.title}</a>
						 	<c:if test="${vo.hour_diff <= 24}"><span class="p-icon p-icon__new">새글</span></c:if>
						</td>
						<td>${vo.nickName}</td>
						<td>
							<!-- vo.date_diff == 0 오늘작성된글 / == 1 어제작성된글 -->
							${vo.date_diff == 0 ? fn:substring(vo.WDate,11,19) : vo.date_diff == 1 ? vo.WDate : fn:substring(vo.WDate,0,10)}
						</td>
						<td class="hits">${vo.readNum}
							<c:if test="${vo.good > 0}">(${vo.good})</c:if>
						</td>
					</tr>
					<c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
				</c:forEach>
				</tbody>
			</table>
		</div>

		<!-- 블록페이지 시작 
		<div class="pagination justify-content-center">
		  <c:if test="${pageVO.pag > 1}"><a href="boardList?pag=1&pageSize=${pageVO.pageSize}" class="page-item page-link text-decoration-none text-dark link-primary">첫페이지</a></c:if>
		  <c:if test="${pageVO.curBlock > 0}"><a href="boardList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}" class="page-item page-link text-decoration-none text-dark link-primary">이전블록</a></c:if>
		  <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}" varStatus="st">
		  	<c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><a href="boardList?pag=${i}&pageSize=${pageVO.pageSize}" class="page-item page-link active text-decoration-none bg-secondary border-secondary">${i}</a></c:if>
		  	<c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><a href="boardList?pag=${i}&pageSize=${pageVO.pageSize}" class="page-item page-link text-decoration-none text-dark link-primary">${i}</a></c:if>
		  </c:forEach>
		  <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><a href="boardList?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}" class="page-item page-link text-decoration-none text-dark link-primary">다음블록</a></c:if>
		  <c:if test="${pageVO.pag < pageVO.totPage}"><a href="boardList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}" class="page-item page-link text-decoration-none text-dark link-primary">마지막페이지</a></c:if>
		</div>-->
		<!-- 블록페이지 끝 -->
		<div class="text-end mt-5">
			<a href="boardInput" class="btn type1 medium">글쓰기</a>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>