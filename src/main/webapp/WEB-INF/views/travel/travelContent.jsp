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
	<title>추천여행지</title>
	<script>
		'use strict';
		
		// 게시글 삭제하기
		function deleteCheck(idx) {
			let ans = confirm("현재 게시글을 삭제하시겠습니까?");
			if(!ans) return false;
			else location.href="travelDelete?idx="+idx;
		}
		
		// 댓글 등록보기
		function replyInputShow() {
			$("#replyInput").toggle();
		}
		
		// 댓글달기
		function replyCheck() {
			let content = $("#content").val();
			if(content.trim() == "") {
				alert("이용후기을 입력하세요");
				return false;
			}
			let query = {
					mid : '${sMid}',
					travelIdx : '${vo.idx}',
					content : content
			}
			$.ajax({
				url : "${ctp}/travel/travelReplyInput",
				type : "post",
				data : query,
				success : function(res) {
					if(res != 0) {
						alert("이용후기가 입력되었습니다.");
						location.reload();
					}
					else alert("이용후기 입력 실패~~");
				},
				error : function() {
					alert("전송 오류!");
				}
			});	
		}
		// 댓글 삭제하기
		function replyDelete(idx) {
			let ans = confirm("선택한 이용후기를 삭제하시겠습니까?");
			if(!ans) return false;
			
			$.ajax({
				url : "${ctp}/travel/travelReplyDelete",
				type : "post",
				data : {idx : idx},
				success : function(res) {
					if(res != 0) {
						alert("이용후기가 삭제되었습니다.");
						location.reload();
					}
					else alert("이용후기 삭제 실패~~");
				},
				error : function() {
					alert("전송 오류!");
				}
			});
		}
		
		// 좋아요 처리(중복불허)
		function goodCheck() {
			$.ajax({
				url : "${ctp}/travel/travelGoodCheck",
				type : "post",
				data : {idx : ${vo.idx}},
				success : function(res) {
					if(res != 0) location.reload();
					else alert("이미 좋아요 버튼을 클릭하셨습니다.");
				},
				error : function() {
					alert("전송 오류!");
				}
			});
		}
	
	</script>
</head>
<body id="sub" class="sub">
<div id="wrapper">
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<div id="container">
		<jsp:include page="/WEB-INF/views/include/header.jsp">
  		<jsp:param name="bgImage" value="sub_visual.png"/>
  		<jsp:param name="siteTitle" value="추천여행지"/>
  		<jsp:param name="subTitle" value=""/>
		</jsp:include>
		<div class="wrap clearfix">
			<main id="colgroup" class="colgroup">
				<article>
					<div id="contents">
						<div class="p-wrap bbs bbs__view bbs_new_skin">
							<div class="bbs_viewbox">
								<div class="subjectbox">
									<span>[${vo.part}] ${vo.title}</span>
								</div>
								<div class="fieldlistbox">
									<div class="field_item">
										<em class="title">조회수</em>
										<span class="text">${vo.readNum}</span>
									</div>
									<div class="field_item">
										<em class="title">이용후기</em>
										<span class="text">${vo.replyCnt}</span>
									</div>
									<div class="field_item">
										<em class="title">좋아요</em>
										<span class="text">${vo.goodCount}</span>
									</div>
									<div class="field_item">
										<em class="title">작성일</em>
										<span class="text">${fn:substring(vo.PDate,0,16)}</span>
									</div>
								</div>
								<div class="viewcontentbox">
									<div class="viewcontent">
										<%-- <div class="bbs_photo">
											<div class="inner">
											<c:forEach var="photo" items="${photoList}" varStatus="st">
												<img src="${ctp}/travel/${photo}" title="${photo}" alt="${photo}" />
											</c:forEach>
											</div>
										</div> --%>
										<div class="contenttext text_center">
											${vo.content}
										</div>
									</div>
								</div>
							</div>
							<!-- 댓글창 -->
							<div class="reply_area">
								<div class="btn_box">
									<a href="javascript:goodCheck()" class="icon_like">
										<i class="t_icon like margin_r_5" title="좋아요"></i>
										<span>${vo.goodCount}</span>
									</a> 
									<c:if test="${sLevel <= 1}">
										<a href="javascript:replyInputShow();" class="icon_reply margin_l_20">
											<i class="t_icon reply margin_r_5" title="이용후기"></i>
										    <span>${vo.replyCnt}</span>
										</a> 
									</c:if>
								</div>
								<div id="replyInput" class="replyInput" style="display:none;">
									<form name="replyForm">
										<div class="nickName">
											<span>${sNickName}</span>
										</div>
										<div class="cont">
											<div class="col_line input">
												<textarea rows="4" name="content" id="content"></textarea>
											</div>
											<div class="col_line submit">
												<input type="button" value="등록" onclick="replyCheck()" class="btn btn2 small" />
											</div>
										</div>
									</form>
								</div>
								<!-- 댓글 리스트 보여주기 -->
								<div id="replyList" class="replyList">
									<c:forEach var="replyVo" items="${replyVos}" varStatus="st"> 
										<div class="nickName">
											<span>${replyVo.mid}</span>
											<c:if test="${sMid == replyVo.mid || sLevel == 0}">
													<a href="javascript:replyDelete(${replyVo.idx})" class="btn type4 ssmall">삭제</a>
											</c:if> 
											<!-- <a href="" class="btn type3 ssmall">좋아요</a>
											<a href="" class="btn type4 ssmall">신고</a> -->
										</div>
										<div class="cont">
											<p class="col_line">
												${fn:replace(replyVo.content,newLine,"<br/>")}
											</p>
										</div>
										<div class="submit_date">
											<span>${fn:substring(replyVo.prDate, 0, 10)}</span>
										</div>
										<div class="line3"></div>
									</c:forEach>
								</div>
							</div>
							<div class="floatbox btn_group clearfix">
								<div class="floatleft">
									<a href="travelList" class="btn type2 medium">목록</a>
								</div>
								<c:if test="${sLevel == 0}">
								<div class="floatright">
									<a href="location.href='travelUpdate?idx=${vo.idx}'" class="btn type1 medium">수정</a>
									<a href="deleteCheck(${vo.idx})" class="btn type3 medium">삭제</a>
								</div>
								</c:if>
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