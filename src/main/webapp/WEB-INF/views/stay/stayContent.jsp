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
  <title>숙소예약</title>
</head>
<body id="sub" class="sub">
<div id="wrapper">
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<div id="container">
		<jsp:include page="/WEB-INF/views/include/header.jsp">
  		<jsp:param name="bgImage" value="sub_visual.png"/>
  		<jsp:param name="siteTitle" value="숙소예약"/>
  		<jsp:param name="subTitle" value="이지트립 페이지입니다."/>
		</jsp:include>
		<div class="wrap clearfix">
			<main id="colgroup" class="colgroup">
				<article>
					<div id="contents">
						<div class="stay">
							<ul class="stay_list">
								<li class="stay_item">
									<div class="image">
										<div class="image_wrap">
											<img src="${ctp}/images/template/normal.jpg" alt="이미지">
										</div>
									</div>
									<div class="desc">
										<div class="content">
											<span class="part">리조트</span>
											<p class="title">금호설악리조트</p>
											<ul class="bu keyword">
												<li>설악산인근 추천숙소</li>
												<li>설악워터피아 인근 추천숙소</li>
												<li>설악 척산온천</li>
											</ul>
										</div>
										<div class="info">
											<div class="addr">주소 : 강원 속초시 사당골길 43 </div>
											<div class="tel">TEL : 033-636-8000</div>
											<div class="site">홈페이지 : 
												<a href="https://www.kumhoresort.co.kr/resort/?khr=C1000" target="_blank" title="새창">www.kumhoresort.co.kr/resort/?khr=C1000</a>
											</div>
										</div>
										<div class="price">
											1박 최저가 111,110원~
											<span class="split">객실 세금/ 봉사료 포함</span>
										</div>
									</div>
								</li>
							</ul>
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