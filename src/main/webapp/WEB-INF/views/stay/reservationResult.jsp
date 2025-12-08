<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="" />
  <meta name="author" content="" />
  <jsp:include page="/WEB-INF/views/include/sub.jsp" />
  <title>숙소예약 완료</title>
</head>
<body id="sub" class="sub">
<div id="wrapper">
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<div id="container">
		<jsp:include page="/WEB-INF/views/include/header.jsp">
  		<jsp:param name="bgImage" value="sub_visual.png"/>
  		<jsp:param name="siteTitle" value="숙소예약완료"/>
  		<jsp:param name="subTitle" value="이지트립 페이지입니다."/>
		</jsp:include>
		<div class="wrap clearfix">
			<main id="colgroup" class="colgroup">
				<article>
					<div id="contents">
						<div class="reservation_result_wrap text_center">
							<h3>예약이 정상적으로 접수되었습니다!</h3>
							<table class="reservation_table table type2">
								<tr>
									<th>예약자</th>
									<td>${sMid}</td>
								</tr>
								<tr>
									<th>숙소명</th>
									<td>${vo.title}</td>
								</tr>
								<tr>
									<th>체크인</th>
									<td>${vo.check_in}</td>
								</tr>
								<tr>
									<th>체크아웃</th>
									<td>${vo.check_out}</td>
								</tr>
								<tr>
									<th>총 결제 금액</th>
									<td>
										<fmt:formatNumber value="${vo.total_price}" type="number" /> 원
									</td>
								</tr>
							</table>
							<div class="margin_t_30 text_center">
								<a href="${ctp}/member/memberMain" class="btn medium type1">내 예약 확인</a>
    						<a href="${ctp}/stay/stayList" class="btn medium type3">돌아가기</a>
							</div>
						</div>
					</div>
					</article>
			</main>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</div>
</body>
</html>