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
    	
    	// 등급별 보여주기
    	function levelItemCheck() {
	    	let level = $("#levelItem").val();
	    	location.href = "adMemberList?level="+level;
	    }
    	
    	// 등급 변경처리
    	function levelChange(e) {
				let ans = confirm("선택한 회원의 등급을 변경하시겠습니까?");
				if(!ans) {
					location.reload();
					return false;
				}
				
				let items = e.value.split("/");
				let query = {
						level : items[0],
						idx : items[1]
				}
				$.ajax({
					url : '${ctp}/admin/member/memberLevelChange',
					type : 'post',
					data : query,
					success : (res) => {
						if(res != 0) {
							alert("등급 수정 완료!!");
							location.reload();
						}
						else alert("등급 수정 실패~~");
					},
					error : () = > alert("전송오류")
				});
			}
    	
    	// 전체선택
			function allCheck() {
    		for(let i=0; i<myform.idxFlag.length; i++) {
    			if(!myform.idxFlag[i].disabled) myform.idxFlag[i].checked = true;
    		}
    	}
    	
    	// 전체취소
			function allReset() {
				for(let i=0; i<myform.idxFlag.length; i++) {
	    			myform.idxFlag[i].checked = false;
	    	}
	    }
    	
    	// 선택반전
			function reverseCheck() {
				for(let i=0; i<myform.idxFlag.length; i++) {
					if(!myform.idxFlag[i].disabled) {
						myform.idxFlag[i].checked = !myform.idxFlag[i].checked;
					}
	    	}
		  }
			
    </script>
    <style>
    	.datatable-top{display:none}
    </style>
</head>
<body class="sb-nav-fixed">
<jsp:include page="/WEB-INF/views/include/adtop.jsp" />
<div id="layoutSidenav">
<jsp:include page="/WEB-INF/views/include/adnav.jsp" />
	<div id="layoutSidenav_content">
	    <main>
	        <div class="container-fluid px-4">
	            <h1 class="mt-4">회원리스트</h1>
	          
	            <div class="card mb-4">
	                <div class="card-header">
	                    <i class="fas fa-table me-1"></i>회원관리
	                </div>
	                <div class="card-body">
	                	<div class="row mb-3">
	                		<div class="col-4">
	                			<div class="input-group">
	                				<select name="levelItem" id="levelItem" onchange="levelItemCheck()" class="form-select me-3">
										        <option value="99"  ${pageVO.level == 99  ? 'selected' : ''}>전체회원</option>
										        <option value="1"   ${pageVO.level == 1   ? 'selected' : ''}>우수회원</option>
										        <option value="999" ${pageVO.level == 999 ? 'selected' : ''}>탈퇴신청회원</option>
										        <option value="0"   ${pageVO.level == 0   ? 'selected' : ''}>관리자</option>
										      </select>
										      <input type="button" value="전체선택" onclick="allCheck()" class="btn btn-success btn-sm"/>
	      									<input type="button" value="전체취소" onclick="allReset()" class="btn btn-primary btn-sm"/>
	      									<input type="button" value="선택반전" onclick="reverseCheck()" class="btn btn-info btn-sm me-1"/>
	                			</div>
	                		</div>
	                	</div>
	                	<form name="myform">
	                    <table id="datatablesSimple">
	                    	<caption></caption>
                        <thead>
                            <tr>
                              <th>번호</th>
												      <th>아이디</th>
												      <th>닉네임</th>
												      <th>성명</th>
												      <th>생일</th>
												      <th>총방문횟수</th>
												      <th>오늘방문횟수</th>
												      <th>최종방문일</th>
												      <th>활동여부</th>
												      <th>회원등급</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="curScrStartNo" value="${pageVO.curScrStartNo}"/>
    												<c:forEach var="vo" items="${vos}" varStatus="st">
                         			<tr>
                                <td>
                                	<c:if test="${vo.level != 0}"><input type="checkbox" name="ideFlag" id="idxFlag${vo.idx}" value="${vo.idx}"/></c:if>
                                	<c:if test="${vo.level == 0}"><input type="checkbox" name="ideFlag" id="idxFlag${vo.idx}" value="${vo.idx}" disabled/></c:if>
                                	${curScrStartNo}
                                </td>
                                <td>${vo.mid}</td>
                                <td>${vo.nickName}</td>
                                <td>${vo.name}</td>
                                <td>${fn:substring(vo.birthday,0,10)}</td>
                                <td>${fn:substring(vo.visitCnt,0,16)}</td>
                                <td>${vo.todayCnt}</td>
                                <td>${fn:substring(vo.lastDate,0,16)}</td>
                                <td>
                                	<c:if test="${vo.userDel == 'NO'}">활동중</c:if>
          												<c:if test="${vo.userDel == 'OK'}">탈퇴신청중</c:if>
                                	<c:if test="${vo.userDel == 'OK' && vo.deleteDiff < 30}">(<font color='red'>${vo.deleteDiff}</font>)</c:if>
                                	<c:if test="${vo.userDel == 'OK' && vo.deleteDiff >= 30}"><br/>
												            (<a href="javascript:memberDeleteOk('${vo.idx}','${vo.photo}')"><font color='red'>30일경과</font></a>)
												          </c:if>
                                </td>
                                <td>
                                	<select name="level" id="level" onchange="levelChange(this)">
                                		<option value="0/${vo.idx}" ${vo.level==0 ? 'selected' : ''}>관리자</option>
                                		<option value="1/${vo.idx}" ${vo.level==1 ? 'selected' : ''}>회원</option>
                                		<option value="999/${vo.idx}" ${vo.level==999 ? 'selected' : ''}>탈퇴회원</option>
                                	</select>
                                </td>
                            	</tr>
                            	
                            	<c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
                            </c:forEach>
                        </tbody>
	                    </table>
                    </form>
                    <!-- 블록페이지 시작 -->
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