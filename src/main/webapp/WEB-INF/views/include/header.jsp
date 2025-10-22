<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="sub_visual">
	<div class="sub_bg">
		<div class="bg_img" style="background-image: url('${pageContext.request.contextPath}/images/sub/${param.bgImage}')"></div>
	</div>
	<div class="wrap">
		<header class="sub_head">
			<div class="sub_title">
				<h2>${param.siteTitle}</h2>
				<!-- <span class="subheading">${param.subTitle}</span> -->
			</div>
		</header>
	</div>
</div>