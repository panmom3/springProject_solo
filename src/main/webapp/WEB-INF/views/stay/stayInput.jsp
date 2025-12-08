<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=Edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="" />
  <meta name="author" content="" />
  <jsp:include page="/WEB-INF/views/include/sub.jsp" />
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
	<title>숙소등록</title>
</head>
<body id="sub" class="sub">
<div id="wrapper">
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<div id="container">
		<jsp:include page="/WEB-INF/views/include/header.jsp">
  		<jsp:param name="bgImage" value="sub_visual.png"/>
  		<jsp:param name="siteTitle" value="숙소등록"/>
  		<jsp:param name="subTitle" value=""/>
		</jsp:include>
		<div class="wrap clearfix">
			<main id="colgroup" class="colgroup">
				<article>
					<div id="contents">
						<form action="" method="post" enctype="multipart/form-data">
							<fieldset>
								<legend>숙소등록하기</legend>
								<table class="table type2">
									<tr>
										<th><label for="part">구분</label></th>
										<td>
											<select class="p-input-auto" name="part" id="part">
												<option value="" selected>선택하세요</option>
												<option value="리조트">리조트</option>
												<option value="펜션">펜션</option>
												<option value="호텔">호텔</option>
											</select>
										</td>
									</tr>
									<tr>
										<th>
											<label for="title">숙소이름</label>
										</th>
										<td>
											<input type="text" name="title" id="title" class="p-input" />
										</td>
									</tr>
									<tr>
										<th>
											<label for="description">숙소설명</label>
										</th>
										<td>
											<input type="text" name="description" id="description" class="p-input" />
										</td>
									</tr>
									<tr>
										<th>
											<label for="stay_tags">숙소키워드</label>
										</th>
										<td>
											<input type="text" name="stay_tags" id="stay_tags" class="p-input" placeholder="#오션뷰 #바다" />
										</td>
									</tr>
									<tr>
										<th>
											<label for="region">지역명</label>
										</th>
										<td>
											<select name="region" id="region">
											  <option value="">지역 선택</option>
											  <option value="서울">서울</option>
											  <option value="부산">부산</option>
											  <option value="대구">대구</option>
											  <option value="인천">인천</option>
											  <option value="광주">광주</option>
											  <option value="대전">대전</option>
											  <option value="울산">울산</option>
											  <option value="세종">세종</option>
											  <option value="경기">경기</option>
											  <option value="강원">강원</option>
											  <option value="충북">충북</option>
											  <option value="충남">충남</option>
											  <option value="전북">전북</option>
											  <option value="전남">전남</option>
											  <option value="경북">경북</option>
											  <option value="경남">경남</option>
											  <option value="제주">제주</option>
											</select>
										</td>
									</tr>
									<tr>
										<th>
											<label for="address">주소</label>
										</th>
										<td>
											<input type="text" name="address" id="address" class="p-input" />
										</td>
									</tr>
									<tr>
										<th>
											<label for="phone">전화번호</label>
										</th>
										<td>
											<input type="text" name="phone" id="phone" class="p-input" />
										</td>
									</tr>
									<tr>
										<th>
											<label for="homepage">홈페이지</label>
										</th>
										<td>
											<input type="text" name="homepage" id="homepage" class="p-input" />
										</td>
									</tr>
									<tr>
										<th>
											<label for="price">최저가</label>
										</th>
										<td>
											<input type="text" name="price" id="price" class="p-input" />
										</td>
									</tr>
									<tr>
										<th>
											<label for="latitude">위도</label>
										</th>
										<td>
											<input type="text" name="latitude" id="latitude" class="p-input" />
										</td>
									</tr>
									<tr>
										<th>
											<label for="longitude">경도</label>
										</th>
										<td>
											<input type="text" name="longitude" id="longitude" class="p-input" />
										</td>
									</tr>
									<tr>
										<th><label for="img_upload">이미지 업로드</label></th>
										<td>
											<input type="file" name="files" multiple />
										</td>
									</tr>
								</table>
								<div class="row_group margin_t_30">
									<div class="sd_input"><input type="button" value="등록하기" onclick="fCheck()" class="btn type1 medium" /></div>
									<div class="sd_input right"><input type="button" value="돌아가기" onclick="location.href='stayList';" class="btn type2 medium" /></div>
								</div>	
							</fieldset>
						</form>
					</div><!-- //#contents -->
				</article>
			</main>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</div>
</body>
</html>