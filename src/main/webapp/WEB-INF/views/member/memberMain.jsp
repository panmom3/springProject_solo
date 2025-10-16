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
  <div class="box mb-10">
      <div class="h3">${sNickName} 회원 전용방</div>
      <div class="images">
     		<img src="${ctp}/member/${mVo.photo}" width="200px"/>
      </div>
  </div>
	<table class="table">
      <caption>테이블제목 - 순으로 정보를 제공</caption>
      <colgroup>
          <col>
          <col>
          <col>
          <col>
      </colgroup>
      <thead>
      <tr>
          <th scope="col">회원 등급</th>
          <th scope="col">오늘 방문횟수</th>
          <th scope="col">총 방문횟수</th>
          <th scope="col">적립포인트</th>
      </tr>
      </thead>
      <tbody>
      <tr>
          <td>${strLevel}</td>
          <td>${mVo.todayCnt}</td>
          <td>${mVo.visitCnt}</td>
          <td>${mVo.point}</td>
      </tr>
      </tbody>
  </table>
 
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>