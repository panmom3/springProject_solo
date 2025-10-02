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
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <title>Login</title>
</head>
<body>
<!-- nav -->
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<!-- header -->
<jsp:include page="/WEB-INF/views/include/header.jsp">
  <jsp:param name="bgImage" value="home-bg.jpg"/>
  <jsp:param name="siteTitle" value="회원 전용방"/>
  <jsp:param name="subTitle" value="이지트립 회원 전용방입니다."/>
</jsp:include>
<!-- Main Content-->
<div class="container px-4 px-lg-5">
	<h2>${sNickName} 회원 전용방</h2>
	<div class="col">
    현재 회원 등급 : ${strLevel}<br/>
    총 방문횟수 : ${mVo.visitCnt}<br/>
    오늘 방문횟수 : ${mVo.todayCnt}<br/>
    현재 가용 포인트 : ${mVo.point}<br/>
    최종 방문일 : ${sLastDate}<br/>
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>