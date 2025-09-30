<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>회원가입</title>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
  <script>
  	'use strict';
  
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/subvisual.jsp" />
<p><br/></p>
<div class="container">
	<h2>회원가입</h2>
	<form name="myform" method="post" enctype="multipart/form-data" class="was-valideted">
    <div class="input-group mb-3">
      <label for="mid" class="input-group-text">아이디</label>
      <input type="text" class="form-control" name="mid" id="mid" placeholder="아이디를 입력하세요." autofocus required />
      <input type="button" value="아이디 중복체크" id="midBtn" onclick="idCheck()"/>
    </div>
    <div class="input-group mb-3">
      <label for="pwd" class="input-group-text">비밀번호</label>
      <input type="password" class="form-control" name="pwd" id="pwd" placeholder="비밀번호를 입력하세요." required />
    </div>
    <div class="input-group mb-3">
      <label for="nickName" class="input-group-text">닉네임</label>
      <input type="text" class="form-control" name="nickName" id="nickName" placeholder="별명를 입력하세요." required />
      <input type="button" value="닉네임 중복체크" id="nickNameBtn" onclick="nickNameCheck()"/>
    </div>
    <div class="input-group mb-3">
      <label for="name" class="input-group-text">성명</label>
      <input type="text" class="form-control" name="name" id="name" placeholder="성명을 입력하세요." required />
    </div>
    <div class="input-group mb-3">
      <label for="email1" class="input-group-text">EMAIL</label>
      <input type="text" name="email1" id="email1" class="form-control" placeholder="email을 입력하세요." required>
      <span class="input-group-text">@</span>
      <select name="email2" class="form-select">
        <option value="gmail.com" selected>gmail.com</option>
        <option value="naver.com">naver.com</option>
        <option value="hotmail.com">hotmail.com</option>
        <option value="hanmail.com">hanmail.com</option>
        <option value="nate.com">nate.com</option>
      </select>
      <input type="button" value="인증번호받기" onclick="emailCertification()" id="certificationBtn" class="btn btn-success btn-sm">
    </div>
		<div id="demoSpin" class="mb-3"></div>
    <div id="addContent">
      <div class="input-group mb-3">
	      <label for="birthday" class="input-group-text">생일</label>
	      <input type="date" name="birthday" value="${today}" class="form-control"/>
	    </div>
	    <div class="input-group mb-3">
	      <label for="tel" class="input-group-text">전화번호</label>
	      <select name="tel1" class="form-select">
	        <option value="010" selected>010</option>
	        <option value="02">서울</option>
	        <option value="031">경기</option>
	        <option value="032">인천</option>
	        <option value="041">충남</option>
	        <option value="042">대전</option>
	        <option value="043">충북</option>
	        <option value="051">부산</option>
	        <option value="052">울산</option>
	        <option value="061">전북</option>
	        <option value="062">광주</option>
	      </select>
	      <div class="input-group-text">-</div>
	      <input type="text" name="tel2" size=4 maxlength=4 class="form-control"/>
	      <div class="input-group-text">-</div>
	      <input type="text" name="tel3" size=4 maxlength=4 class="form-control"/>
	    </div>
	    <div class="row mb-2">
	      <div class="col-2">
	        <label for="address" class="input-group-text">주소</label>
	      </div>
	      <div class="col-10">
		      <div class="input-group mb-1">
		        <input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" class="form-control">
	          <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-secondary btn-sm">
		      </div>
		      <div class="mb-1">
		      	<input type="text" name="roadAddress" id="sample6_address" size="50" placeholder="주소" class="form-control mb-1">
		      </div>
		      <div class="mb-1">
		        <input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control">
		      </div>
	      </div>
	    </div>
	    <div class="input-group mb-3">
	      <label for="homepage" class="input-group-text">홈페이지</label>
	      <input type="text" name="homePage" id="homePage" value="https://" class="form-control" placeholder="홈페이지 주소를 입력하세요." />
	    </div>
    </div>
		
	</form>
	
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>