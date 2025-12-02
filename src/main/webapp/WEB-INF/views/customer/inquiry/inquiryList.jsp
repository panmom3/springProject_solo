<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
	<title>1:1문의하기</title>
</head>
<body id="sub" class="sub">
<div id="wrapper">
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<div id="container">
		<jsp:include page="/WEB-INF/views/include/header.jsp">
  		<jsp:param name="bgImage" value="sub_visual.png"/>
  		<jsp:param name="siteTitle" value="1:1문의하기"/>
  		<jsp:param name="subTitle" value=""/>
		</jsp:include>
		<div class="wrap clearfix">
			<main id="colgroup" class="colgroup">
				<article>
					<div id="contents">
						<!-- <h3>1:1 문의</h3> -->
						<p class="warning type1 margin_b_5">평일 10:00~17:00, <em class="em_red">공휴일 / 주말</em> 문의는 평일 업무시간 내에 순차적으로 답변 진행됩니다 .</p>
						<div class="table_scroll">
							<table class="table">
								<caption>1:1문의 - 유형,제목,문의자,작성일,답변상태 순으로 제공</caption>
								<colgroup>
									<col class="w15p">
									<col />
									<col class="w15p">
									<col class="w15p">
									<col class="w15p">
								</colgroup>
								<thead>
									<tr>
										<th scope="col">유형</th>
										<th scope="col">제목</th>
										<th scope="col">문의자</th>
										<th scope="col">작성일</th>
										<th scope="col">답변상태</th>
									</tr>
								</thead>
								<tbody>
								<c:if test="${empty vos}">
									<tr>
										<td colspan="5" class="text-center">
											1:1문의 내역이 존재하지 않습니다.
										</td>
									</tr>
								</c:if>
								<c:if test="${!empty vos}">
									<c:forEach var="vo" items="${vos}">
									<tr>
										<td>${vo.part}</td>
										<td class="text_left"><a href="#">${vo.title}</a></td>
										<td>${vo.mid}</td>
										<td>${fn:substring(vo.WDate,0,10)}</td>
										<td>
											<c:if test="${vo.reply=='답변대기중'}">
												<span class="btn small type3">${vo.reply}</span>
											</c:if>
											<c:if test="${vo.reply=='답변완료'}">
												<span class="btn small type1">${vo.reply}</span>
											</c:if>
										</td>
									</tr>
									</c:forEach>
								</c:if>
								</tbody>
							</table>
						</div>
						<!-- 블록페이지 시작 -->
						<div class="p-pagination justify-content-center">
							<div class="p-page">
								<span class="p-page__control">
							  	<c:if test="${pageVO.pag > 1}"><a href="boardList?pag=1&pageSize=${pageVO.pageSize}" class="p-page__link prev-end">첫페이지</a></c:if>
							  	<c:if test="${pageVO.curBlock > 0}"><a href="boardList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}" class="p-page__link prev-one">이전블록</a></c:if>
							  </span>
							  <span class="p-page__link-group">
								  <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}" varStatus="st">
								  	<c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><a href="boardList?pag=${i}&pageSize=${pageVO.pageSize}" class="p-page__link active">${i}</a></c:if>
								  	<c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><a href="boardList?pag=${i}&pageSize=${pageVO.pageSize}" class="p-page__link">${i}</a></c:if>
								  </c:forEach>
							  </span>
							  <span class="p-page__control">
							  	<c:if test="${pageVO.curBlock < pageVO.lastBlock}"><a href="boardList?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}" class="p-page__link next-one">다음블록</a></c:if>
							  	<c:if test="${pageVO.pag < pageVO.totPage}"><a href="boardList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}" class="p-page__link next-end">마지막페이지</a></c:if>
								</span>
							</div>
						</div>
						<!-- 블록페이지 끝 -->
						<div class="btn_area text_right">
							<input type="button" onclick="location.href='${ctp}/customer/inquiry/inquiryInput?pag=${pageVO.pag}'" value="1:1 문의하기" class="btn type1 medium" />
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