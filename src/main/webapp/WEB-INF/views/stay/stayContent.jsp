<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="" />
  <meta name="author" content="" />
  <jsp:include page="/WEB-INF/views/include/sub.jsp" />
  <title>숙소예약</title>

</head>
<body id="sub" class="sub">
<div id="wrapper">
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<div id="container">
		<jsp:include page="/WEB-INF/views/include/header.jsp">
  		<jsp:param name="bgImage" value="sub_visual.png"/>
  		<jsp:param name="siteTitle" value="숙소예약"/>
  		<jsp:param name="subTitle" value="이지트립 페이지입니다."/>
		</jsp:include>
		<div class="wrap clearfix">
			<main id="colgroup" class="colgroup">
				<article>
					<div id="contents">
						<div class="stay_detail_wrap">
							<div class="detail_list">
								<div class="detail_top">
									<div class="image">
										<div class="image_wrap">
											<img src="${ctp}/images/sub/${vo.stay_thumbnail}" alt="이미지">
										</div>
									</div>
									<div class="desc">
										<div class="cont">
											<span class="part">${vo.part}</span>
											<p class="title">${vo.title}</p>
											<ul class="bu keyword">
												<li>${vo.description}</li>
											</ul>
										</div>
										<div class="info">
											<div class="addr">주소 : ${vo.address}</div>
											<div class="tel">TEL : ${vo.phone}</div>
											<div class="site">홈페이지 : 
												<a href="${vo.homepage}" target="_blank" title="새창">${vo.homepage}</a>
											</div>
										</div>
										<div class="price_box">
											<p class="price">1박 최저가 <fmt:formatNumber value="${vo.price}" type="number" />원~</p>
											<span class="add">객실 세금/ 봉사료 포함</span>
										</div>
									</div>
								</div>
							</div>
							<h3>숙소 예약하기</h3>
							<!-- 예약 슬라이드 영역 -->
							<div id="reservaitionBox" class="reservation_wrap">
								<form method="post" name="myform" action="${ctp}/stay/reservationInsert">
									<input type="hidden" name="stay_idx" value="${vo.stay_idx}">
									<input type="hidden" name="mid" value="${sMid}">
									<input type="hidden" name="total_price" id="total_price_hidden">
									
									<table class="reservation_table table type2">
										<tr>
											<th>체크인</th>
											<td><input type="date" id="checkIn" name="check_in" required></td>
										</tr>
										<tr>
											<th>체크아웃</th>
											<td><input type="date" id="checkOut" name="check_out" required></td>
										</tr>
										<tr>
											<th>1박 요금</th>
											<td><fmt:formatNumber value="${vo.price}" type="number" /> 원</td>
										</tr>
										<tr>
											<th>총금액</th>
											<td><span id="totalPrice">0</span> 원</td>
										</tr>
									</table>
									<div class="text_center margin_t_20">
							      <input type="button" value="예약신청" class="btn medium type2" onclick="fCheck()" />
							    </div>
								</form>
							</div>
							<h3>지도보기</h3>
							<div id="map" style="width:100%;height:500px;"></div>
							<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=278ab31c9959388aaf266a68e59371b2"></script>
							<script>
							var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
							    mapOption = { 
							        center: new kakao.maps.LatLng(${vo.latitude}, ${vo.longitude}), // 지도의 중심좌표
							        level: 4 // 지도의 확대 레벨
							    };
							
							var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
							
							var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png', // 마커이미지의 주소입니다    
							    imageSize = new kakao.maps.Size(64, 69), // 마커이미지의 크기입니다
							    imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
							      
							// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
							var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
							    markerPosition = new kakao.maps.LatLng(${vo.latitude}, ${vo.longitude}); // 마커가 표시될 위치입니다
							
							// 마커를 생성합니다
							var marker = new kakao.maps.Marker({
							    position: markerPosition, 
							    image: markerImage // 마커이미지 설정 
							});
							
							// 마커가 지도 위에 표시되도록 설정합니다
							marker.setMap(map);  
							</script>
						</div>
					</div><!-- //#contents -->
				</article>
			</main>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</div>
</body>
  <script>
  
	  function fCheck() {
		  if(document.myform.check_in.value == "") {
			  alert("체크인 날짜를 선택하세요");
			  return false;
		  }
		  document.myform.submit();
	  }
	 	
	  /* 숙박일 자동 금액 계산 */
	  const checkIn = document.getElementById("checkIn");
		const checkOut = document.getElementById("checkOut");
		const totalSpan = document.getElementById("totalPrice");
		const totalHidden = document.getElementById("total_price_hidden");
		const pricePerNight = ${vo.price};
		
		function calcPrice() {
		  if (!checkIn.value || !checkOut.value) return;
		
		  const inDate = new Date(checkIn.value);
		  const outDate = new Date(checkOut.value);
		
		  const diffTime = outDate - inDate;
		  const days = diffTime / (1000 * 60 * 60 * 24);
		
		  if (days <= 0) {
		    totalSpan.innerText = "0";
		    totalHidden.value = 0;
		    return;
		  }
		
		  const total = days * pricePerNight;
		
		  // 화면 표시용 (천단위)
		  totalSpan.innerText = total.toLocaleString();
		
		  // 서버 전송용 (콤마 없는 순수 숫자)
		  totalHidden.value = total;
		}
		
		// 날짜 변경 + 직접 입력 모두 감지
		checkIn.addEventListener("change", calcPrice);
		checkOut.addEventListener("change", calcPrice);
		checkIn.addEventListener("keyup", calcPrice);
		checkOut.addEventListener("keyup", calcPrice);
  	
  </script>
</html>