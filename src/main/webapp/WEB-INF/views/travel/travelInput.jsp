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
	<title>추천여행지 등록</title>
	<script>
		'use strict';
		
		function fCheck(){
			let title = document.getElementById("title").value;
			if(CKEDITOR.instances.content.getData() == '' || CKEDITOR.instances.content.getData().length == 0) {
				alert("사진을 등록해주세요.");
				$("#content").focus();
			}
			else if(title.trim() == "") {
				alert("제목을 입력해주세요.");
				$("#title").focus();
			}
			else {
				myform.submit();
			}
		}
	
	</script>
</head>
<body id="sub" class="sub">
<div id="wrapper">
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<div id="container">
		<jsp:include page="/WEB-INF/views/include/header.jsp">
  		<jsp:param name="bgImage" value="sub_visual.png"/>
  		<jsp:param name="siteTitle" value="추천여행지 등록"/>
  		<jsp:param name="subTitle" value=""/>
		</jsp:include>
		<div class="wrap clearfix">
			<main id="colgroup" class="colgroup">
				<article>
					<div id="contents">
						<form name="myform" method="post">
							<table class="table type2">
								<colgroup>
									<col class="w20p">
									<col>
								</colgroup>
								<tbody>
									<tr>
										<th>분류</th>
										<td>
											<div class="sd_input display_block text_left">
												<select name="part" id="part">
														<option value="전체" selected>전체</option>
														<option value="가족">가족</option>
														<option value="연인">연인</option>
														<option value="친구">친구</option>
														<option value="기타">기타</option>
												</select>
											</div>
										</td>
									</tr>
									<tr>
										<th>제목</th>
										<td>
											<div class="sd_input display_block">
												<input type="text" name="title" id="title" class="w100p" />
											</div>
										</td>
									</tr>
									<tr>
										<th>해시태그</th>
										<td>
											<div class="sd_input display_block">
												<input type="text" name="tags" id="tags" class="w100p" />
											</div>
										</td>
									</tr>
									<tr>
										<td colspan="2">
											<textarea name="content" id="content" required></textarea>
											<script>
										    CKEDITOR.replace("content",{
										    	height:500,
										    	filebrowserUploadUrl: "${ctp}/imageUpload",
										    	uploadUrl:"${ctp}/imageUpload"
										    });
										  </script>
										</td>
									</tr>
								</tbody>
							</table>
							<div class="row_group margin_t_30">
								<div class="sd_input"><input type="button" value="등록하기" onclick="fCheck()" class="btn type1 medium" /></div>
								<div class="sd_input right"><input type="button" value="돌아가기" onclick="location.href='travelList';" class="btn type2 medium" /></div>
							</div>
							<input type="hidden" name="mid" value="${sMid}" />
						</form>
					</div>
				</article>
			</main>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</div>
</body>
</html>