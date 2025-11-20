<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="" />
  <meta name="author" content="" />
  <jsp:include page="/WEB-INF/views/include/sub.jsp" />
  <title>고객지원</title>
</head>
<body id="sub" class="sub">
<div id="wrapper">
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<div id="container">
		<jsp:include page="/WEB-INF/views/include/header.jsp">
  		<jsp:param name="bgImage" value="sub_visual.png"/>
  		<jsp:param name="siteTitle" value="FAQ"/>
  		<jsp:param name="subTitle" value="이지트립 페이지입니다."/>
		</jsp:include>
		<div class="wrap clearfix">
			<main id="colgroup" class="colgroup">
				<article>
					<div id="contents">
					<h3>자주찾는 질문</h3>
						<div class="temp_accordion faq_list">
							<!-- 질문 -->
							<div class="accordion_item faq_item">
								<button type="button" title="내용닫기" class="accordion_btn">
									<span class="title">Q</span>
									<span class="text">예약은 어떻게 하나요?</span>
								</button>
								<div class="accordion_con">
									<div class="boxwrap">
										<span class="title">A</span>
										<div class="textbox">숙소나 축제, 이벤트 페이지에서 ‘예약하기’ 버튼을 클릭한 뒤 날짜와 인원수를 선택하면 됩니다. 일부 제휴처는 외부 예약 사이트로 연결될 수 있습니다.</div>
									</div>
								</div>
							</div>
							<!-- 질문 -->
							<div class="accordion_item faq_item">
								<button type="button" title="내용닫기" class="accordion_btn">
									<span class="title">Q</span>
									<span class="text">예약 내역은 어디서 확인할 수 있나요?</span>
								</button>
								<div class="accordion_con">
									<div class="boxwrap">
										<span class="title">A</span>
										<div class="textbox">로그인 후 상단 메뉴의 [마이페이지 > 예약내역] 에서 확인하실 수 있습니다.<br/>
												예약 취소 및 변경도 해당 페이지에서 가능합니다.
										</div>
									</div>
								</div>
							</div>
							<!-- 질문 -->
							<div class="accordion_item faq_item">
								<button type="button" title="내용닫기" class="accordion_btn">
									<span class="title">Q</span>
									<span class="text">회원가입 없이 이용할 수 있나요?</span>
								</button>
								<div class="accordion_con">
									<div class="boxwrap">
										<span class="title">A</span>
										<div class="textbox">일부 여행정보는 회원가입 없이 열람 가능합니다.
단, 예약, 리뷰 작성, 찜하기 등 개인화 서비스는 회원가입 후 이용하실 수 있습니다.
										</div>
									</div>
								</div>
							</div>
							<!-- 질문 -->
							<div class="accordion_item faq_item">
								<button type="button" title="내용닫기" class="accordion_btn">
									<span class="title">Q</span>
									<span class="text">모바일에서도 이용할 수 있나요?</span>
								</button>
								<div class="accordion_con">
									<div class="boxwrap">
										<span class="title">A</span>
										<div class="textbox">네, PC와 동일한 기능을 모바일 웹 및 앱에서 모두 이용하실 수 있습니다.
										</div>
									</div>
								</div>
							</div>
							<!-- 질문 -->
							<div class="accordion_item faq_item">
								<button type="button" title="내용닫기" class="accordion_btn">
									<span class="title">Q</span>
									<span class="text">고객센터 운영시간은 어떻게 되나요?</span>
								</button>
								<div class="accordion_con">
									<div class="boxwrap">
										<span class="title">A</span>
										<div class="textbox">평일 09:00 ~ 18:00 (주말 및 공휴일 휴무)<br/>
이메일 또는 1:1 문의를 남겨주시면 순차적으로 답변드립니다.
										</div>
									</div>
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