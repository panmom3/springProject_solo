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
						<div class="search_bar">
							<div class="sd_input">
									<select name="part" id="part">
											<option value="전체" selected>전체</option>
											<option value="가족">가족</option>
											<option value="연인">연인</option>
											<option value="친구">친구</option>
											<option value="기타">기타</option>
									</select>
							</div>
							<div class="sd_input">
									<select name="choice" id="choice">
											<option value="최근순" selected>최근순</option>
											<option value="추천순">추천순</option>
											<option value="조회순">조회순</option>
											<option value="댓글순">댓글순</option>
									</select>
							</div>
							<input type="button" value="조건검색" class="btn type2 medium" onclick="travelSearch()" />
							<div style="float:right">
								<input type="button" value="등록하기" onclick="location.href='travelInput';" class="btn type1 medium">
							</div>
						</div>
            <div class="gallery_list clearfix margin_t_20">
              <%-- <div class="gallery_item">
                  <a href="">
                      <span class="photobox">
                          <span class="inner_photo" style="background-image:url(${ctp}/images/sub/normal.jpg);"></span>
                      </span>
                      <span class="title">단풍여행하기 좋은 추천 여행지 단풍여행하기 좋은 추천 여행지</span>
                  </a>
                  <div class="tag">#여행 #가족 #연인 #친구</div>
                  <div class="date">2026-08-25</div>
                  <div class="instar_bar">
                  	<ul>
											<li><i class="fa-regular fa-pen-to-square" title="댓글수"></i> ${vo.replyCnt}0</li>
											<li><i class="fa-regular fa-face-grin-hearts" title="좋아요"></i> ${vo.goodCount}0</li>
											<li><i class="fa-regular fa-eye" title="조회수"></i> ${vo.readNum}0</li>
										</ul>
                  </div>
              </div> --%>
              <c:forEach var="vo" items="${vos}" varStatus="st">
	              <div class="gallery_item">
	                  <a href="travelContent?idx=${idx}">
	                      <span class="photobox">
	                          <span class="inner_photo" style="background-image:url(${ctp}/photoGallery/${vo.thumbnail});"></span>
	                      </span>
	                      <span class="title">${vo.title}</span>
	                  </a>
	                  <div class="tag">${vo.tag}</div>
	                  <div class="date">${fn:substring(vo.PDate,0,16)}</div>
	                  <div class="instar_bar">
	                  	<ul>
												<li><i class="fa-regular fa-pen-to-square" title="댓글수"></i> ${vo.replyCnt}0</li>
												<li><i class="fa-regular fa-face-grin-hearts" title="좋아요"></i> ${vo.goodCount}0</li>
												<li><i class="fa-regular fa-eye" title="조회수"></i> ${vo.readNum}0</li>
											</ul>
	                  </div>
	              </div>
              </c:forEach>
            </div>
            <div class="p-pagination">
              <div class="p-page">
                <span class="p-page__control">
                    <a href="#" class="p-page__link prev-end"><span class="skip">처음 페이지</span></a>
                    <a href="#" class="p-page__link prev"><span class="skip">이전 10 페이지</span></a>
                    <a href="#" class="p-page__link prev-one">이전 페이지</a>
                </span>
                <span class="p-page__link-group">
                    <strong title="현재 1페이지" class="p-page__link">1</strong>
                    <a href="" title="2페이지 이동" class="p-page__link active">2</a>
                    <a href="" title="3페이지 이동" class="p-page__link">3</a>
                    <a href="" title="4페이지 이동" class="p-page__link">4</a>
                    <a href="" title="5페이지 이동" class="p-page__link">5</a>
                    <a href="" title="6페이지 이동" class="p-page__link">6</a>
                    <a href="" title="7페이지 이동" class="p-page__link">7</a>
                    <a href="" title="8페이지 이동" class="p-page__link">8</a>
                    <a href="" title="9페이지 이동" class="p-page__link">9</a>
                    <a href="" title="10페이지 이동" class="p-page__link">110</a>
                </span>
                <span class="p-page__control">
                    <a href="#" class="p-page__link next-one">다음 페이지</a>
                    <a href="#" class="p-page__link next"><span class="skip">다음 10 페이지</span></a>
                    <a href="#" class="p-page__link next-end"><span class="skip">끝 페이지</span></a>
                </span>
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