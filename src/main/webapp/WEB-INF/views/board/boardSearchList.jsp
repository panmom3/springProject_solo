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
	<title>커뮤니티(검색)</title>
	<script>
	'use strict';
	
	function pageSizeCheck() {
		let pageSize = $("#pageSize").val();
		location.href = "boardList?pageSize="+pageSize;
	}
	
	</script>
</head>
<body id="sub" class="sub">
<div id="wrapper">
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<div id="container">
		<jsp:include page="/WEB-INF/views/include/header.jsp">
  		<jsp:param name="bgImage" value="sub_visual.png"/>
  		<jsp:param name="siteTitle" value="커뮤니티"/>
  		<jsp:param name="subTitle" value="커뮤니티 검색 페이지입니다."/>
		</jsp:include>
		<div class="wrap clearfix">
			<main id="colgroup" class="colgroup">
				<article>
					<div id="contents">
						<div class="p-wrap">
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
								<div class="col-9 col-sm-24 small">
									<p class="warning type1 margin_0"><em class="em_b_blue">${pageVO.searchStr}</em>(으)로 <em class="em_b_red">${pageVO.searchString}</em>를 검색한 결과 <em class="em_b_blue">${fn:length(vos)}</em>건이 검색되었습니다.</p>
								</div>
								<div class="col-15 col-sm-24 right">
									<a href="boardList" class="btn type2 small">돌아가기</a>
								</div>
							</div>
							<!-- 게시판테이블 -->
							<div class="table-responsive">
								<table class="p-table" data-breakpoint="760">
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
												<c:if test="${vo.openSw == 'NO'}">
													<c:if test="${sMid != vo.mid && sLevel != 0}"><font color="red">(비밀글)</font></c:if>
													<c:if test="${sMid == vo.mid || sLevel == 0}">
														<a href="boardContent?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}&boardFlag=search">
															<c:if test="${sLevel == 0}"><font color="red">(비밀글)</font></c:if>${vo.title}
														</a>
												 		<c:if test="${vo.hour_diff <= 24}"><span class="p-icon p-icon__new">새글</span></c:if>
											 		</c:if>
											 	</c:if>
											 	<c:if test="${vo.openSw != 'NO'}">
													<a href="boardContent?idx=${vo.idx}&boardFlag=search&search=${search}&searchString=${searchString}">${vo.title}</a>
											 		<c:if test="${vo.hour_diff <= 24}"><span class="p-icon p-icon__new">새글</span></c:if>
											 	</c:if>
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
							<!-- 블록페이지 시작 -->
							<div class="p-pagination justify-content-center">
								<div class="p-page">
									<span class="p-page__control">
								  	<c:if test="${pag > 1}"><a href="boardList?pag=1&pageSize=${pageVO.pageSize}" class="p-page__link prev-end">첫페이지</a></c:if>
								  	<c:if test="${curBlock > 0}"><a href="boardList?pag=${(curBlock-1)*blockSize + 1}&pageSize=${pageSize}" class="p-page__link prev-one">이전블록</a></c:if>
								  </span>
								  <span class="p-page__link-group">
									  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}" varStatus="st">
									  	<c:if test="${i <= totPage && i == pag}"><a href="boardList?pag=${i}&pageSize=${pageSize}" class="p-page__link active">${i}</a></c:if>
									  	<c:if test="${i <= totPage && i != pag}"><a href="boardList?pag=${i}&pageSize=${pageSize}" class="p-page__link">${i}</a></c:if>
									  </c:forEach>
								  </span>
								  <span class="p-page__control">
								  	<c:if test="${curBlock < lastBlock}"><a href="boardList?pag=${(curBlock+1)*blockSize + 1}&pageSize=${pageSize}" class="p-page__link next-one">다음블록</a></c:if>
								  	<c:if test="${pag < totPage}"><a href="boardList?pag=${totPage}&pageSize=${pageSize}" class="p-page__link next-end">마지막페이지</a></c:if>
									</span>
								</div>
							</div>
						</div>
					</div><!-- //#contents -->
				</article>
			</main>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</div>
</body>
</html>