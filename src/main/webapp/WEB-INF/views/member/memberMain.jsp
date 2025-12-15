<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <meta name="description" content="" />
  <meta name="author" content="" />
  <jsp:include page="/WEB-INF/views/include/sub.jsp" />
  <title>마이페이지</title>
  <script>
  	function userDeleteCheck() {
  		let ans = confirm("회원 탈퇴하시겠습니까?");
  		if(ans) {
  			ans = confirm("탈퇴하시면 1개월간 같은 아이디로는 다시 가입하실수 없습니다.\n그래도 탈퇴 하시겠습니까?");
  			if(ans) {
  				$.ajax({
  					url : '${ctp}/member/userDelete',
  					type : 'post',
  					success : (res) => {
  						if(res != '0') {
  							alert("회원에서 탈퇴 되셨습니다.");
  							location.href = '${ctp}/member/memberLogin';
  						}
  						else alert("회원 탈퇴 실패~~");
  					},
  					error : () => alert("전송오류!")
  				});
  			}
  		}
  	}
  </script>
</head>
<body id="sub" class="sub">
<div id="wrapper">
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<div id="container">
		<jsp:include page="/WEB-INF/views/include/header.jsp">
  		<jsp:param name="bgImage" value="sub_visual.png"/>
  		<jsp:param name="siteTitle" value="마이페이지"/>
  		<jsp:param name="subTitle" value=""/>
		</jsp:include>
		<div class="wrap clearfix">
			<main id="colgroup" class="colgroup">
				<article>
					<div id="contents">
						<div class="box imagebox">
					    <div class="inner">
					        <div class="image margin_t_20">
					            <img src="${ctp}/member/${mVo.photo}" alt="프로필이미지">
					        </div>
					        <div class="cont" style="width: calc(100% - 310px);">
					            <div class="tit"><h3 class="margin_t_0 margin_b_10"><em class="em_b_blue">${sNickName}</em> 회원님 마이페이지</h3></div>
					            <div class="txt">
					            	<table class="table">
										      <caption>테이블제목 - 순으로 정보를 제공</caption>
										      <colgroup>
										          <col>
										          <col>
										          <col>
										          <col>
										      </colgroup>
										      <thead class="table-secondary text-center">
										      <tr>
										          <th scope="col">회원 등급</th>
										          <th scope="col">오늘 방문횟수</th>
										          <th scope="col">총 방문횟수</th>
										          <th scope="col">적립포인트</th>
										      </tr>
										      </thead>
										      <tbody class="text-center">
										      <tr>
										          <td>${strLevel}</td>
										          <td>${mVo.todayCnt}</td>
										          <td>${mVo.visitCnt}</td>
										          <td>${mVo.point}</td>
										      </tr>
										      </tbody>
										  	</table>
					            </div>
					        </div>
					        <div class="text_right margin_t_20">
					        	<a class="btn type1 small" href="${ctp}/member/memberPwdCheck/pwdck">비밀번호변경</a>
					        	<a class="btn type2 small" href="${ctp}/member/memberPwdCheck/update">회원가입수정</a>
					        	<a class="btn type3 small" href="javascript:userDeleteCheck()">회원탈퇴</a>
					        </div>
					    </div>
						</div>
						<c:if test="${!empty sLevel && sLevel != 0}">
						<h4>활동내역</h4>
						<table class="table type2">
				        <caption>테이블제목 - 순으로 정보를 제공</caption>
				        <colgroup>
				            <col class="w30p">
				            <col />
				        </colgroup>
				        <tbody>
					        <tr>
					            <th scope="row" class="table-secondary">커뮤니티 게시판 등록글수</th>
					            <td>테이블 내용1</td>
					        </tr>
					        <tr>
					            <th scope="row" class="table-secondary">테이블 제목2</th>
					            <td>테이블 내용2</td>
					        </tr>
				        </tbody>
				    </table>
				    
						<h4>나의 예약현황</h4>
						<h5>예약건수 : ${fn:length(vos)}</h5>
						<table class="table">
				        <caption>예약현황</caption>
				        <thead>
				        	<tr>
				        		<th>숙소명</th>
				        		<th>체크인-체크아웃</th>
				        		<th>예약금액</th>
				        		<th>예약상태</th>
				        		<th>예약일</th>
				        		<th>예약취소</th>
				        	</tr>
				        </thead>
				        <tbody>
				        <c:forEach var="vo" items="${vos}">
					        <tr>
					            <td>${vo.title}</td>
					            <td>${vo.check_in} - ${vo.check_out}</td>
					            <td><fmt:formatNumber value="${vo.total_price}" pattern="#,###" /> 원</td>
					            <td>${vo.status}</td>
					            <td>${vo.created_at}</td>
					            <td>
					            	<c:if test="${vo.status == '예약신청'}">
					            		<a href="reservationCancel?reservation_idx=${vo.reservation_idx}" class="btn small type3">취소</a>
					            	</c:if>
					            </td>
					        </tr>
					       </c:forEach>
				        </tbody>
				    </table>
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