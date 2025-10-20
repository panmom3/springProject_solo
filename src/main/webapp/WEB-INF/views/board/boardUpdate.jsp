<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=Edge" />
  <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, maximum-scale=2.0, minimum-scale=1.0, user-scalable=yes" />
  <meta name="description" content="" />
  <meta name="author" content="" />
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
  <jsp:include page="/WEB-INF/views/include/sub.jsp" />
	<title>커뮤니티 글수정하기</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/header.jsp">
  <jsp:param name="bgImage" value="home-bg.jpg"/>
  <jsp:param name="siteTitle" value="커뮤니티"/>
  <jsp:param name="subTitle" value="이지트립 커뮤니티 수정 페이지입니다."/>
</jsp:include>
<div class="container px-4 px-lg-5" style="min-height:500px">
	<div class="p-wrap bbs bbs__form bbs_new_skin">
		<form name="myform" method="post">
			<table class="p-table mobile block">
			<caption>커뮤니티 수정</caption>
			<colgroup>
				<col class="w20p">
				<col>
			</colgroup>
			<tbody class="p-table--th-left">
				<tr class="p-table__subject">
					<th scope="row">
						<label for="nickName" class="p-form__label">글쓴이</label>
					</th>
					<td>
						<input type="text" name="nickName" id="nickName" value="${sNickName}" readonly class="p-input p-input--auto"/>
					</td>
				</tr>
				<tr>
					<th scope="row">
						<label for="title" class="p-form__label">글제목</label>
					</th>
					<td>
						<input type="text" name="title" id="title" value="${vo.title}" autofocus required class="p-input"/>
					</td>
				</tr>
				<tr>
					<th scope="row">
						<label for="CKEDITOR" class="p-form__label">글내용</label>
					</th>
					<td>
						<textarea rows="6" name="content" id="CKEDITOR" required cols="80" class="p-input">${vo.content}</textarea>
						<script>
	        		CKEDITOR.replace("content", {
	        			height:400,
	       				filebrowserUploadUrl:"${ctp}/imageUpload",  // 대화상자에서 '이미지/동영상'을 선택후 '서버로전송'버튼 누를때 수행(HomeController)
	       				uploadUrl:"${ctp}/imageUpload"   // 업로드할 그림들을 드래그하여 글내용 상자에 넣을때 수행하는 곳
	        		});
	        	</script>
					</td>
				</tr>
				<tr>
					<th scope="row">공개여부</th>
					<td>
					<span class="p-form-radio">
						<input type="radio" name="openSw" id="openSw1" value="OK" class="p-form-radio__input" checked/> 
						<label for="openSw1" ${vo.openSw==OK ? 'checked' : ''} value="OK" class="p-form-radio__label margin_r_10">공개</label>
					</span>
					<span class="p-form-radio">
						<input type="radio" name="openSw" id="openSw2" value="NO" class="p-form-radio__input"/>
						<label for="openSw2" ${vo.openSw==NO ? 'checked' : ''} value="NO" class="p-form-radio__label margin_r_10">비공개</label>
					</span>	
					</td>
				</tr>
				<tr>
					<td colspan="2" class="text-center">
						<input type="submit" value="글수정하기" class="btn type1 medium" />
						<input type="button" value="돌아가기" onclick="location.href='boardList?pag=${pag}&pageSize=${pageSize}';" class="btn type2 medium" />
					</td>
				</tr>
			</tbody>
			</table>
			<input type="hidden" name="idx" value="${vo.idx}"/>
    	<input type="hidden" name="pag" value="${pag}"/>
    	<input type="hidden" name="pageSize" value="${pageSize}"/>
    	<input type="hidden" name="mid" value="${sMid}"/>
		</form>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>