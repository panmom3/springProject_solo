<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!-- Navigation-->
<nav class="navbar navbar-expand-lg navbar-light" id="mainNav">
    <div class="container px-4 px-lg-5">
        <a class="navbar-brand" href="http://192.168.50.61:9090/springGroupS09/">EasyTrip</a>
        <!-- 모바일토글버튼 -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
            Menu
            <i class="fas fa-bars"></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ms-auto py-4 py-lg-0">
                <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="http://192.168.50.61:9090/springGroupS09/">Home</a></li>
                <li class="nav-item dropdown">
                    <a class="nav-link px-lg-3 py-3 py-lg-4 dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">추천여행지</a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="#">Action</a></li>
                        <li><a class="dropdown-item" href="#">Another action</a></li>
                        <li><a class="dropdown-item" href="#">Something else here</a></li>
                    </ul>
                </li>
                <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="#">숙박/예약</a></li>
                <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="${ctp}/board/boardList">소통게시판</a></li>
                <c:if test="${empty sLevel}">
                	<li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="${ctp}/member/memberJoin">회원가입</a></li>
                	<li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="${ctp}/member/memberLogin">로그인</a></li>
                	
                </c:if>
                <c:if test="${!empty sLevel && sLevel != 0}">
                  <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="${ctp}/member/memberMain">mypage</a></li>
                </c:if>
                <c:if test="${!empty sLevel}">
                	<li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="${ctp}/member/memberLogout">로그아웃</a></li>
                </c:if>
                <c:if test="${sLevel == 0}">
				        	<a href="${ctp}/admin/adminMain" class="w3-bar-item w3-button">관리자메뉴</a>
				        </c:if>
            </ul>
        </div>
    </div>
</nav>