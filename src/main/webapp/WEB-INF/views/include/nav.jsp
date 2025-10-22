<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!-- Navigation-->
<header id="header">
	  <div class="header_top">
		<div class="wrap clearfix">
			<ul class="gnb">
				<c:if test="${empty sLevel}">
				<li class="gnb_list"><a href="${ctp}/member/memberLogin" class="gnb_link"><i class="fa-solid fa-right-to-bracket"></i>로그인</a></li>
				<li class="gnb_list"><a href="${ctp}/member/memberJoin" class="gnb_link">회원가입</a></li>
				</c:if>
				<c:if test="${!empty sLevel}">
				<li class="gnb_list"><a href="${ctp}/member/memberLogout" class="gnb_link">로그아웃</a></li>
				</c:if>
				<c:if test="${sLevel == 0}">
				<li class="gnb_list"><a href="${ctp}/admin/adminMain" class="gnb_link">관리자메뉴</a></li>
				</c:if>
				<c:if test="${!empty sLevel && sLevel != 0}">
				<li class="gnb_list"><a href="${ctp}/member/memberMain" class="gnb_link">마이페이지</a></li>
				</c:if>
			</ul>
		</div>
	</div>
	<div class="header_box">
		<div class="wrap">
			<h1 class="logo">
				<a href="http://192.168.50.61:9090/springGroupS09/"><img src="${ctp}/images/common/logo_top.png" alt="이지트립 로고"></a>
			</h1>
			<div class="menu_show">
				<button type="button" class="menu_button">메뉴열기</button>
			</div>
		</div>
	</div>
	<div class="lnb">
		<div class="lnb_topbox"><!-- 모바일용 --></div>
		<nav class="menu init after eachdown mouse"><!-- mouse/click 둘중 하나는 꼭 들어가야함, mouseleave:클릭일때 메뉴영역에서 마우스 빠질때 메뉴닫기 -->
			<h2 class="skip">메뉴</h2>
			<div class="wrap">
				<div class="depth depth1">
					<ul class="depth_list depth1_list clearfix">
						<li class="depth_item depth1_item">
							<a href="" class="depth_text depth1_text"><span>ABOUT</span></a>
						</li>
						<li class="depth_item depth1_item">
							<a href="${ctp}/travel/travelList" class="depth_text depth1_text"><span>추천여행지</span></a>
							<div class="depth depth2">
								<div class="menu_title">
									<div class="innerbox">
										<div class="title">추천여행지</div>
										<p class="text">오감을 열면 힐링이된다!</p>
									</div>
								</div>
								<ul class="depth_list depth2_list clearfix">
									<li class="depth_item depth2_item clearfix"><a href="" class="depth_text depth2_text"><span>추천여행지</span></a></li>
									<li class="depth_item depth2_item clearfix"><a href="" class="depth_text depth2_text"><span>지역별</span></a></li>
									<li class="depth_item depth2_item clearfix"><a href="" class="depth_text depth2_text"><span>테마별</span></a></li>
								</ul>
							</div>
						</li>
						<li class="depth_item depth1_item">
							<a href="" class="depth_text depth1_text"><span>예약/숙소</span></a>
							<div class="depth depth2">
								<div class="menu_title">
									<div class="innerbox">
										<div class="title">예약/숙소</div>
										<p class="text">오감을 열면 힐링이된다!</p>
									</div>
								</div>
								<ul class="depth_list depth2_list clearfix">
									<li class="depth_item depth2_item clearfix"><a href="" class="depth_text depth2_text"><span>2차메뉴</span></a></li>
									<li class="depth_item depth2_item clearfix"><a href="" class="depth_text depth2_text"><span>2차메뉴</span></a></li>
									<li class="depth_item depth2_item clearfix"><a href="" class="depth_text depth2_text"><span>2차메뉴</span></a></li>
									<li class="depth_item depth2_item clearfix"><a href="" class="depth_text depth2_text"><span>2차메뉴</span></a></li>
								</ul>
							</div>
						</li>
						<li class="depth_item depth1_item">
							<a href="${ctp}/board/boardList" class="depth_text depth1_text"><span>커뮤니티</span></a>
								<div class="depth depth2">
									<div class="menu_title">
										<div class="innerbox">
											<div class="title">커뮤니티</div>
											<p class="text">오감을 열면 힐링이된다!</p>
										</div>
									</div>
									<ul class="depth_list depth2_list clearfix">
										<li class="depth_item depth2_item clearfix"><a href="" class="depth_text depth2_text"><span>2차메뉴</span></a></li>
										<li class="depth_item depth2_item clearfix"><a href="" class="depth_text depth2_text"><span>2차메뉴</span></a></li>
										<li class="depth_item depth2_item clearfix"><a href="" class="depth_text depth2_text"><span>2차메뉴</span></a></li>
										<li class="depth_item depth2_item clearfix"><a href="" class="depth_text depth2_text"><span>2차메뉴</span></a></li>
									</ul>
								</div>
							</li>
							<li class="depth_item depth1_item"><a href="" class="depth_text depth1_text"><span>문의하기</span></a></li>
						</ul>
					</div>
				</div>
			</nav>
			<div class="menu_hide">
				<button type="button" class="menu_button">메뉴 닫기</button>
			</div>
		</div>
		<div class="lnb_curtain"><button type="button">메뉴 닫기</button></div>
	</header>