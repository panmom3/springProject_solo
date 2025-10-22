<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <jsp:include page="/WEB-INF/views/include/main.jsp" />
  <title>HOME</title>
</head>
<body id="main" class="main">
<div id="wrapper">
	<!-- Navbar -->
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<!-- Main Content-->
	<div class="container">
		<main>
			<div class="rowgroup rowgroup1 rowcont" data-index="0">
				<section class="main_visual">
					<h2 class="skip">메인비주얼</h2>
					<div class="visual_box">
						<div class="wrap">
							<div class="visual_cont">
								<div class="tit text1">
									<span>가을 단풍 여행</span>
								</div>
								<div class="tit text2">
									<span>일년에 딱 한번 열리는 숲 길,<br />
										단풍축제에 초대합니다.
									</span>
								</div>
							</div>

						</div>
					</div>
					<div class="visual_slide">
						<i class="left_bar"></i>
						<i class="right_bar"></i>
						<div class="slide_list">
							<div class="slide_item">
								<div class="image_box">
									<div class="inner_image" style="background-image: url('${ctp}/images/main/visual_img_1.jpg')"></div>
								</div>
							</div>
							<div class="slide_item">
								<div class="image_box">
									<div class="inner_image" style="background-image: url('${ctp}/images/main/visual_img_2.jpg')"></div>
								</div>
							</div>
							<div class="slide_item">
								<div class="image_box">
									<div class="inner_image" style="background-image: url('${ctp}/images/main/visual_img_3.jpg')"></div>
								</div>
							</div>
						</div>
						<div class="slide_btn">
							<div class="count_box">
								<span class="current"></span>
								<span class="total"></span>
							</div>
							<div class="slide_control">
								<button type="button" class="prev">이전</button>
								<button type="button" class="auto">일시정지</button>
								<button type="button" class="next">다음</button>
							</div>
						</div>
					</div>
					<div class="scrolling">
						<span class="gage"><span class="gage_bar"></span></span>
						<img src="${ctp}/images/main/scroll_txt.png" alt="SCROLL DOWN">
					</div>
					<div class="wave"></div>
				</section>
			</div>
			<div class="rowgroup2">
				<div class="wrap">
					<section>추천여행지</section>
				</div>
			</div>
			<div class="rowgroup3">
				<div class="colgroup1 clearfix">
					<section class="popup"></section>
					<section class="mayor"></section>
				</div>
				<div class="colgroup2">
					<section></section>
				</div>
			</div>
		</main>
	</div>
	<!-- Footer -->
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</div>
</body>
</html>