<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- Page Header-->
<!-- <header class="masthead" style="background-image: url('images/home-bg.jpg')"> -->
<header class="masthead" style="background-image: url('${pageContext.request.contextPath}/images/${param.bgImage}')">
    <div class="container position-relative px-4 px-lg-5">
        <div class="site-heading">
            <h1>${param.siteTitle}</h1>
            <span class="subheading">${param.subTitle}</span>
        </div>
    </div>
</header>