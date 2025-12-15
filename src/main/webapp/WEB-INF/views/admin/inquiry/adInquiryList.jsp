<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
		<meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
		<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
		<link href="${ctp}/css/styles.css" rel="stylesheet" />
		<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <title>관리자페이지</title>
    <script>
    	'use strict';
    
    	function categoryCheck() {
				let part = categoryForm.part.value;
				location.href="${ctp}/admin/inquiry/adInquiryList?part="+part+"&pag=${pageVO.pag}";
			}
    	
    </script>
</head>
<body class="sb-nav-fixed">
<jsp:include page="/WEB-INF/views/include/adtop.jsp" />
<div id="layoutSidenav">
<jsp:include page="/WEB-INF/views/include/adnav.jsp" />
	<div id="layoutSidenav_content">
	    <main>
	        <div class="container-fluid px-4">
	            <h1 class="mt-4">1:1문의 관리</h1>
	            <div class="card mb-4">
	                <div class="card-header">
	                    <i class="fas fa-table me-1"></i>문의 리스트(${pageVO.part})
	                </div>
	                <div class="card-body">
										<form name="categoryForm" style="width:200px" onchange="categoryCheck()">
											<select class="form-select" name="part">
												<option value="전체" <c:if test="${part=='전체'}">selected</c:if>>전체문의글</option>
												<option value="답변대기중" <c:if test="${part=='답변대기중'}">selected</c:if>>답변대기중</option>
												<option value="답변완료" <c:if test="${part=='답변완료'}">selected</c:if>>답변완료</option>
											</select>
										</form>
										<br/>
										<table id="datatablesSimple">
											<thead>
												<tr>
													<th>번호</th>
													<th>제목</th>
													<th>작성자ID</th>
													<th>작성일</th>
													<th>상태</th>
												</tr>
											</thead>
											<tbody>
												<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
												<c:forEach var="vo" items="${vos}">
													<tr>
														<td>${curScrStartNo}</td>
														<td><a href="${ctp}/admin/inquiry/adInquiryReply?idx=${vo.idx}&pag=${pageVO.pag}&part=${part}">[${vo.part}] ${vo.title}</a></td>
														<td>${vo.mid}</td>
														<td>
															${fn:substring(vo.WDate,0,10)}
														</td>
														<td>
															<c:if test="${vo.reply=='답변대기중'}">
																<span class="badge bg-secondary">${vo.reply}</span>
															</c:if>
															<c:if test="${vo.reply=='답변완료'}">
																<span class="badge bg-danger">${vo.reply}</span>
															</c:if>
														</td>
													</tr>
													<c:set var="curScrStartNo" value="${curScrStartNo-1}" />
												</c:forEach>
											</tbody>
										</table>
										
								
										<!-- 블록페이지 시작 -->
										<c:if test="${pageVO.totRecCnt != 0}">
											<div class="pagination justify-content-center">
											  <c:if test="${pageVO.pag > 1}"><a href="adMemberList?pag=1&pageSize=${pageVO.pageSize}&level=${pageVO.level}" class="page-item page-link text-decoration-none text-dark link-primary">첫페이지</a></c:if>
											  <c:if test="${pageVO.curBlock > 0}"><a href="adMemberList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}&level=${pageVO.level}" class="page-item page-link text-decoration-none text-dark link-primary">이전블록</a></c:if>
											  <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}" varStatus="st">
											  	<c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><a href="adMemberList?pag=${i}&pageSize=${pageVO.pageSize}&level=${pageVO.level}" class="page-item page-link active text-decoration-none bg-secondary border-secondary">${i}</a></c:if>
											  	<c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><a href="adMemberList?pag=${i}&pageSize=${pageVO.pageSize}&level=${pageVO.level}" class="page-item page-link text-decoration-none text-dark link-primary">${i}</a></c:if>
											  </c:forEach>
											  <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><a href="adMemberList?pag=${(pageVO.curBlock+1)*blockSize + 1}&pageSize=${pageVO.pageSize}&level=${pageVO.level}" class="page-item page-link text-decoration-none text-dark link-primary">다음블록</a></c:if>
											  <c:if test="${pageVO.pag < pageVO.totPage}"><a href="adMemberList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}&level=${pageVO.level}" class="page-item page-link text-decoration-none text-dark link-primary">마지막페이지</a></c:if>
											</div>
										</c:if>
										<!-- 블록페이지 끝 -->
	                </div>
	            </div>
	        </div>
	    </main>
			<jsp:include page="/WEB-INF/views/include/adfooter.jsp" />
	</div>
</div> 
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="${ctp}/js/scripts.js"></script>
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
<script src="${ctp}/js/datatables-simple-demo.js"></script>
</body>
</html>