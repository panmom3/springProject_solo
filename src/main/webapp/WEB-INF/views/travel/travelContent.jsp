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
										<em class="title">작성자</em>
										<span class="text">${vo.mid}</span>
									</div>
									<div class="field_item">
										<em class="title">조회수</em>
										<span class="text">${vo.readNum}</span>
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
										<div class="bbs_photo">
											<div class="inner">
											<c:forEach var="photo" items="${photoList}" varStatus="st">
												<img src="${ctp}/travel/${photo}" title="${photo}" alt="${photo}" />
											</c:forEach>
											</div>
										</div>
										<div class="contenttext">
											우리 집 고양이는 매일 책상 위에서 꾸벅꾸벅 낮잠을 즐깁니다. 고양이가 책상 위에서 자는 것을 좋아하는 특별한 이유가 있을까요 비밀은 책상 위의 유리에 있습니다.
											유리는 나무보다 열전도가 높아서 열기나 냉기를 사람에게 빠르게 전달합니다. 유리를 놓은 책상 위에 올라간 고양이는 유리의 냉기 때문에 신체의 온도변화를 느끼게 되는데요. 신체의 온도가 변하면 근육이 이완되고 온몸이 나른해집니다. 창문 가에서 낮잠을 잘 때 잠이 더 잘 오는 것도 이와 같은 원리랍니다!<br>
											<br>
											졸음은 부족한 잠을 보충하려는 생리적 욕구로서 잠에 빠지기 쉬운 상태를 말합니다. 공부하는 학생들에게는 졸음이 상대하기 어려운 적이라는 사실! 신체의 온도변화를 일으키는 책상 위의 유리는 졸음을 유발하게 됩니다
										</div>
									</div>
									<!-- <div class="attachedfile">첨부파일이 있을 때 출력
										<div class="attach_item">
											<span class="text">첨부파일명.jpg</span>
											<a href="" class="icon_btn type2 shape2 small download"><span>다운로드</span></a>
										</div>
										<div class="attach_item">
											<span class="text">첨부파일명.hwp</span>
											<a href="" target="_blank" title="새창" class="icon_btn type2 shape2 small preview"><span>미리보기</span></a>
										</div>
									</div> -->
								</div>
							</div>

							<div class="floatbox btn_group clearfix">
								<div class="floatleft">
									<a href="travelList" class="btn type2 medium">목록</a>
								</div>
								<c:if test="${sLevel == 0}">
								<div class="floatright">
									<a href="" class="btn type1 medium">수정</a>
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