<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=Edge" />
  <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, maximum-scale=2.0, minimum-scale=1.0, user-scalable=yes" />
  <meta name="description" content="" />
  <meta name="author" content="" />
  <jsp:include page="/WEB-INF/views/include/sub.jsp" />
	<title>소통게시판</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/header.jsp">
  <jsp:param name="bgImage" value="home-bg.jpg"/>
  <jsp:param name="siteTitle" value="커뮤니티"/>
  <jsp:param name="subTitle" value="이지트립 커뮤니티게시판입니다."/>
</jsp:include>
<div class="container px-4 px-lg-5">
	<div class="p-wrap bbs bbs__list bbs_new_skin bbs_normal">
		<div class="boardtopbox">
			<i class="icon"></i>
			<div class="box_wrap">
				<div class="box_title">커뮤니티 게시판</div>
				<div class="textbox">
					<p>회원간 소통하는 커뮤니티 게시판입니다.</p>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-9 col-sm-24 margin_t_10 small">
				<div class="bbs_page">
					<span class="item count">총게시물 : <em>2</em>건</span>
					<span class="item page">페이지 : <em>1/2</em></span>
				</div>
			</div>
			<div class="col-15 col-sm-24 right top_select">
				<select name="" id="" class="p-input p-input--auto" title="검색영역선택">
					<option value="">셀렉트 제목</option>
					<option value="">셀렉트 제목</option>
					<option value="">셀렉트 제목</option>
					<option value="">셀렉트 제목</option>
				</select>
				<input type="text" name="" id="" class="p-input p-input--auto board_search" title="검색단어 입력" value="" placeholder="입력하세요.">
				<button type="submit" class="p-button primary">조회</button>
			</div>
		</div>

		<form name="myform" method="post">
			<fieldset>
				<legend>게시물 목록</legend>
				<div class="table-responsive">
					<table class="p-table simple" data-table="rwd" data-tabletype="simple" data-breakpoint="760">
						<caption>{게시판명} 목록 - 번호, 제목, 작성자, 작성일, 조회수 정보  제공</caption>
						<thead>
							<tr>
								<th scope="col">번호</th>
								<th scope="col">제목</th>
								<th scope="col">작성자</th>
								<th scope="col">작성일</th>
								<th scope="col">조회수</th>
							</tr>
						</thead>
						<tbody class="text_center">
						<c:forEach var="vo" items="${vos}" varStatus="st">
							<tr>
								<td><span class="bbs_num">1</span></td>
								<td class="p-subject"><a href="#">${vo.title}</a>
								 	<!-- <span class="p-icon p-icon__new">새글</span> -->
								</td>
								<td>${vo.nickName}</td>
								<td>${vo.WDate}</td>
								<td class="hits">${vo.readNum}</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
			</fieldset>
		</form>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>