<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
    
	    // 답변글 작성하기
	    function inquiryReply() {
				var inquiryIdx = "${vo.idx}";
				var reContent = replyForm.reContent.value;
				if(reContent == "") {
					alert("답변을 입력하세요!");
					replyForm.reContent.focus();
					return false;
				}
				var query = {
						inquiryIdx : inquiryIdx,
						reContent : reContent
				}
				$.ajax({
					type : "post",
					url : "${ctp}/admin/inquiry/adInquiryReplyInput",
					data : query,
					success : function(res) {
						if(res != 0) {
							alert("답변글이 등록되었습니다.");
							location.reload();
						}
						else alert("답변글 등록 실패~");
					}
				});
			}
	    
	    // 답변글만 삭제하기
	    function deleteReplyCheck() {
				var ans = confirm("답변글을 삭제하시겠습니까?");	
				if(!ans) return false;
				
				var reIdx = '${reVO.reIdx}';
				var inquiryIdx = '${reVO.inquiryIdx}';
				var query = {
						reIdx : reIdx,
						inquiryIdx : inquiryIdx
				}
				$.ajax({
					url : "${ctp}/admin/inquiry/adInquiryReplyDelete",
					type : "post",
					data : query,
					success : function() {
						alert("삭제 되었습니다.");
						location.reload();
					}
				});
			}
	    
	 		// 답변글 수정폼 호출하기(replySw값을 U(수정)을 보내어서 그 값이 U(수정)이면 textarea창의 readonly속성을 풀어준다.)
	 		function adUpdateReplyCheck() {
				location.href = "${ctp}/admin/inquiry/adInquiryReply?idx=${vo.idx}&replySw=U";
			}
	    
	 		// 원본 게시글 삭제하기(원본게시글은 답변글이 달리기전에는 수정/삭제 가능하다)
	 		function deleteCheck() {
	 			var ans = confirm("삭제하시겠습니까?");
	 			if(!ans) return false;
	 			let reIdx = 0;
	 			if(${!empty reVO.reIdx}) reIdx = '${reVO.reIdx}';
	 			location.href="${ctp}/admin/inquiry/adInquiryDelete?idx=${vo.idx}&fSName=${vo.FSName}&reIdx="+reIdx+"&pag=${pag}";
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
	            <h1 class="mt-4">1:1문의 상세보기</h1>
	            <div class="card mb-4">
	                <div class="card-header">
	                    <i class="fas fa-table me-1"></i>1:1문의
	                </div>
	                <div class="card-body">
										<table class="table">
											<tr>
												<th>제목</th>
												<td>[${vo.part}] ${vo.title}</td>
											</tr>
											<tr>
												<th>작성ID</th>
												<td>${vo.mid}</td>
											</tr>
											<tr>
												<th>상태</th>
												<td>
													<c:if test="${vo.reply=='답변대기중'}">
														<span class="badge bg-secondary">${vo.reply}</span>						
													</c:if>
													<c:if test="${vo.reply=='답변완료'}">
														<span class="badge bg-danger">${vo.reply}</span>						
													</c:if>
												</td>
											</tr>
											<tr>
												<th>작성일</th>
												<td>${fn:substring(vo.WDate,0,10)}</td>
											</tr>
											<tr>
												<th>내용</th>
												<td class="view-content">
										      <c:if test="${!empty vo.FSName}">
												    <c:set var="ext" value="${fn:toLowerCase(fn:split(vo.FSName, '.')[fn:length(fn:split(vo.FSName, '.')) - 1])}" />
												    <c:set var="imgExt" value="jpg,png,gif" />
														<!-- 이미지출력 -->
												    <c:if test="${fn:contains(imgExt, ext)}">
												    	<c:set var="imgs" value="${fn:split(vo.FSName,'/')}" />
												    	<c:forEach var="img" items="${imgs}">
												        <img src="${ctp}/data/inquiry/${img}" width="400px"><br/><br/>
												       </c:forEach>
												    </c:if>
														<!-- 파일출력 -->
												    <c:if test="${!fn:contains(imgExt, ext)}">
												        <a href="${ctp}/data/inquiry/${vo.FSName}" download>📄 ${vo.FSName}</a><br/>
												    </c:if>
													</c:if>
										      <br/>
										      <p>${fn:replace(vo.content,newLine,"<br/>")}<br/></p>
												</td>
											</tr>
										</table>
										
										<div class="d-grid gap-2 d-md-flex justify-content-md-end">
										<c:if test="${sMid==vo.mid || sLevel == 0}">	<!-- 작성글을 관리자라가 삭제처리할수 있다.(만약 답변이 달려있는 글이라면 답변글을 먼저 지우고 원본글을 삭제한다. -->
											<input type="button" value="원본글삭제" onclick="deleteCheck()" class="btn btn-danger btn-sm" />
										</c:if>
											<input type="button" value="목록" onclick="location.href='${ctp}/admin/inquiry/adInquiryList?pag=${pag}'" class="btn btn-secondary btn-sm" />
										</div>
										<hr/>

										<!-- 답변서가 작성되어 있을때 수행하는 곳 -->
										<c:if test="${!empty reVO.reContent}">
											<form name="replyForm" method="post">
												<label for="reContent" class="form-label">답변내용</label>
												<c:if test="${empty replySw || replySw != 'U'}"> <!-- 답변서 작성되어 있고, 수정가능상태는 readonly로 처리후 '수정'버튼 누르면 'readonly'해제후 '수정완료'버튼으로 바꾼다. -->
													<textarea name="reContent" rows="5"  id="reContent" readonly="readonly" class="form-control" >${reVO.reContent}</textarea>
													<div class="d-grid gap-2 d-md-flex justify-content-md-end">	<!-- 수정을 위해서는 현재 답변글의 글번호(reIdx)를 넘겨야하지만, 현재는 답변글이 항상 1개이기에 넘기지않아도 알수 있다. -->
														<input type="button" value="수정" id="updateBtn" onclick="adUpdateReplyCheck()" class="btn btn-secondary btn-sm mt-2"/>
														<input type="button" value="삭제" id="deleteBtn" onclick="deleteReplyCheck()" class="btn btn-danger btn-sm mt-2"/>
													</div>
												</c:if>
												<c:if test="${!empty replySw && replySw == 'U'}">
													<textarea name="reContent" rows="5"  id="reContent" class="form-control">${reVO.reContent}</textarea>
													<div class="d-grid gap-2 d-md-flex justify-content-md-end">
														<input type="submit" value="수정" id="updateOkBtn" onclick="updateReplyCheckOk()" class="btn btn-secondary btn-sm mt-2"/>
														<input type="button" value="삭제" id="deleteBtn" onclick="deleteReplyCheck()" class="btn btn-danger btn-sm mt-2"/>
													</div>
												</c:if>
												<input type="hidden" name="reIdx" value="${reVO.reIdx}" />
												<input type="hidden" name="inquiryIdx" value="${reVO.inquiryIdx}" />
											</form>
										</c:if>
										
										<!-- 답변서가 작성되어 있지 않을때 수행하는 곳 -->
										<c:if test="${empty reVO.reContent}">
											<form name="replyForm">
												<label for="reContent" class="form-label">답변글 작성하기</label>
												<textarea name="reContent" rows="3" class="form-control" placeholder="답변글을 작성해 주세요"></textarea>
												<div class="d-grid gap-2 d-md-flex justify-content-md-end">
													<input type="button" value="등록" onclick="inquiryReply()" class="btn btn-primary btn-sm mt-2"/>
												</div>
											</form>
										</c:if>
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