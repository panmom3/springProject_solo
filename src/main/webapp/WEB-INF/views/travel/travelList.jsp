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
		
		function travelSearch() {
	    	let part = $("#part").val();
	    	let choice = $("#choice").val();
	    	
	    	location.href = "travelList?part="+part+"&choice="+choice;
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
						<div class="search_bar">
							<div class="sd_input">
									<select name="part" id="part">
											<option value="전체" ${part == '전체' ? 'selected' : ''}>전체</option>
											<option value="가족" ${part == '가족' ? 'selected' : ''}>가족</option>
											<option value="연인" ${part == '연인' ? 'selected' : ''}>연인</option>
											<option value="친구" ${part == '친구' ? 'selected' : ''}>친구</option>
											<option value="기타" ${part == '기타' ? 'selected' : ''}>기타</option>
									</select>
							</div>
							<div class="sd_input">
									<select name="choice" id="choice">
											<option value="최근순" ${choice == '최근순' ? 'selected' : ''}>최근순</option>
											<option value="추천순" ${choice == '추천순' ? 'selected' : ''}>추천순</option>
											<option value="조회순" ${choice == '조회순' ? 'selected' : ''}>조회순</option>
											<option value="댓글순" ${choice == '댓글순' ? 'selected' : ''}>댓글순</option>
									</select>
							</div>
							<input type="button" value="조건검색" class="btn type2 medium" onclick="travelSearch()" />
							<c:if test="${sLevel == 0}">
							<div style="float:right">
								<input type="button" value="등록하기" onclick="location.href='travelInput';" class="btn type1 medium">
							</div>
							</c:if>
						</div>
            <div class="gallery_list clearfix margin_t_20">
              <c:forEach var="vo" items="${vos}" varStatus="st">
	              <div class="gallery_item">
	                  <a href="travelContent?idx=${vo.idx}">
	                      <span class="photobox">
	                          <span class="inner_photo" style="background-image:url(${ctp}/data/photoGallery/${vo.thumbnail});"></span>
	                      </span>
	                      <span class="title">${vo.title}</span>
	                  </a>
	                  <div class="tag">${vo.tags}</div>
	                  <div class="date">${fn:substring(vo.PDate,0,16)}</div>
	                  <div class="instar_bar">
	                  	<ul>
												<li><i class="fa-regular fa-pen-to-square" title="댓글수"></i>-</li>
												<li><i class="fa-regular fa-face-grin-hearts" title="좋아요"></i> ${vo.goodCount}</li>
												<li><i class="fa-regular fa-eye" title="조회수"></i> ${vo.readNum}</li>
											</ul>
	                  </div>
	              </div>
              </c:forEach>
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