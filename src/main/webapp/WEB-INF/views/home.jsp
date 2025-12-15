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
	<div id="container">
		<main>
			<div class="rowgroup rowgroup1 rowcont" data-index="0">
				<section class="main_visual">
					<h2 class="skip">메인비주얼</h2>
					<div class="visual_box">
						<div class="wrap">
							<div class="visual_cont">
								<div class="tit text1">
									<span>단풍 따라 가을여행</span>
								</div>
								<div class="tit text2">
									<span>패키지로 간편하게 떠나는<br />
										국내 여행
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
									<div class="inner_image" style="background-image: url('${ctp}/images/main/visual_img1.jpg')"></div>
								</div>
							</div>
							<div class="slide_item">
								<div class="image_box">
									<div class="inner_image" style="background-image: url('${ctp}/images/main/visual_img2.jpg')"></div>
								</div>
							</div>
							<div class="slide_item">
								<div class="image_box">
									<div class="inner_image" style="background-image: url('${ctp}/images/main/visual_img3.jpg')"></div>
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
			<div class="rowgroup rowgroup2 rowcont" data-index="1">
				<div class="wrap">
					<section>
						<div class="title_box">
							<h2>고객님만을 위한 추천여행</h2>
						</div>
						<div class="content">
							<div class="cont_list">
								<div class="cont_item">
									<div class="img_inner" style="background-image: url(${ctp}/images/main/row2_img1.jpg);"></div>
									<div class="desc">
										<span class="tit">단풍트레킹 설악산</span>
										<span class="hash">#가족여행 #단풍구경 #힐링여행</span>
									</div>
								</div>
								<div class="cont_item">
									<div class="img_inner" style="background-image: url(${ctp}/images/main/row2_img2.jpg);"></div>
									<div class="desc">
										<span class="tit">단풍트레킹 설악산</span>
										<span class="hash">#가족여행 #단풍구경 #힐링여행</span>
									</div>
								</div>
								<div class="cont_item">
									<div class="img_inner" style="background-image: url(${ctp}/images/main/row2_img3.jpg);"></div>
									<div class="desc">
										<span class="tit">단풍트레킹 설악산</span>
										<span class="hash">#가족여행 #단풍구경 #힐링여행</span>
									</div>
								</div>
								<div class="cont_item">
									<div class="img_inner" style="background-image: url(${ctp}/images/main/row2_img4.jpg);"></div>
									<div class="desc">
										<span class="tit">단풍트레킹 설악산</span>
										<span class="hash">#가족여행 #단풍구경 #힐링여행</span>
									</div>
								</div>
							</div>
						</div>
					</section>
				</div>
			</div>
			<div class="rowgroup rowgroup3 rowcont" data-index="2">
				<div class="colgroup1 clearfix">
					<section>
					
					</section>
				</div>
				<div class="colgroup2">
					<section>
						

					</section>
				</div>
			</div>
		</main>
	</div>
	<!-- Footer -->
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</div>
</body>
</html>