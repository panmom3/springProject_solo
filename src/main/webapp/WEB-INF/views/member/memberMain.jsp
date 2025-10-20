<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <meta name="description" content="" />
  <meta name="author" content="" />
  <jsp:include page="/WEB-INF/views/include/sub.jsp" />
  <title>Login</title>
</head>
<body>
<!-- nav -->
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<!-- header -->
<jsp:include page="/WEB-INF/views/include/header.jsp">
  <jsp:param name="bgImage" value="home-bg.jpg"/>
  <jsp:param name="siteTitle" value="마이페이지"/>
  <jsp:param name="subTitle" value=""/>
</jsp:include>
<!-- Main Content-->
<div class="container px-4 px-lg-5 mb-5">
	<div class="box imagebox">
	    <div class="inner">
	        <div class="image">
	            <img src="${ctp}/member/${mVo.photo}" alt="프로필이미지">
	        </div>
	        <div class="cont" style="width: calc(100% - 310px);">
	            <div class="tit"><em class="em_b_blue">${sNickName}</em> 회원님 마이페이지</div>
	            <div class="txt">
	            	<table class="table table-bordered table-group-divider table-hover table-responsive">
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
	    </div>
	</div>
	<h3>활동내역</h3>
	<div class="box">
		<table class="table table-bordered table-group-divider">
        <caption>테이블제목 - 순으로 정보를 제공</caption>
        <colgroup>
            <col class="w30p">
            <col class="w70p">
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
	</div>
	<h3>일정관리</h3>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>