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
						<div class="stay_list_warp">
							<c:if test="${sLevel == 0}">
								<div style="float:right">
									<input type="button" value="등록하기" onclick="location.href='stayInput';" class="btn type1 medium">
								</div>
							</c:if>
							<!-- 리조트 -->
							<div class="stay_box">
								<div class="stay_list_title">요즘 뜨는 리조트</div>
									<ul class="stay_list">
										<c:forEach var="vo" items="${vos}" varStatus="st">
										<c:if test="${vo.part == '리조트'}">
											<li class="stay_item">
												<a href="travelContent?idx=${vo.stay_idx}">
													<div class="image"><img src="${ctp}/images/sub/${vo.stay_thumbnail}" alt=""></div>
													<div class="cont">
														<span class="regin">[${vo.region}]</span><span class="tit">${vo.title}</span>
														<div class="hash">
															<ul class="hash_list">
															    <c:forTokens var="tag" items="${vo.stay_tags}" delims=",">
															        <li class="hash_item">${tag}</li>
															    </c:forTokens>
															</ul>
														</div>
													</div>
													<div class="price">
														<span><fmt:formatNumber value="${vo.price}" type="number" />원~</span>
													</div>
												</a>
											</li>
										</c:if>
									</c:forEach>
								</ul>
							</div>
							<!-- 펜션 -->
							<div class="stay_box">
								<div class="stay_list_title">요즘 뜨는 펜션</div>
									<ul class="stay_list">
										<c:forEach var="vo" items="${vos}" varStatus="st">
										<c:if test="${vo.part == '펜션'}">
											<li class="stay_item">
												<a href="travelContent?idx=${vo.stay_idx}">
													<div class="image"><img src="${ctp}/images/sub/${vo.stay_thumbnail}" alt=""></div>
													<div class="cont">
														<span class="regin">[${vo.region}]</span><span class="tit">${vo.title}</span>
														<div class="hash">
															<ul class="hash_list">
															    <c:forTokens var="tag" items="${vo.stay_tags}" delims=",">
															        <li class="hash_item">${tag}</li>
															    </c:forTokens>
															</ul>
														</div>
													</div>
													<div class="price">
														<span><fmt:formatNumber value="${vo.price}" type="number" />원~</span>
													</div>
												</a>
											</li>
										</c:if>
										</c:forEach>
								</ul>
							</div>
							<!--  -->
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