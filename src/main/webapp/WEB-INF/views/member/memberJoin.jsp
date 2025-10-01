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
  
    let idCheckSw = 0;
    let nickNameSw = 0;

    // 정규식을 이용한 유효성검사처리
    let regMid = /^[a-zA-Z0-9_]{4,20}$/;// 아이디는 4~20의 영문 대/소문자와 숫자와 밑줄 가능
    let regNickName = /^[가-힣0-9_]+$/;		// 닉네임은 한글, 숫자, 밑줄만 가능
    let regName = /^[가-힣a-zA-Z]+$/;			// 이름은 한글/영문 가능
    let regEmail =/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;

    function fCheck() {
    	let regTel = /\d{2,3}-\d{3,4}-\d{4}$/g;

      // 내역을 변수에 담아 회원가입처리
      let mid = myform.mid.value.trim();
      let pwd = myform.pwd.value.trim();
      let nickName = myform.nickName.value;
      let name = myform.name.value;

      let email1 = myform.email1.value.trim();
      let email2 = myform.email2.value;
      let email = email1 + "@" + email2;

      let tel1 = myform.tel1.value;
      let tel2 = myform.tel2.value.trim();
      let tel3 = myform.tel3.value.trim();
      let tel = tel1 + "-" + tel2 + "-" + tel3;

      // 주소 하나로 묵어서 전송처리 준비
      let postcode = myform.postcode.value + " ";
      let roadAddress = myform.roadAddress.value + " ";
      let detailAddress = myform.detailAddress.value + " ";
      let address = postcode + "/" + roadAddress + "/" +detailAddress;

      let submitFlag = 0; // 체크 완료를 체크하기위한 변수.. 체크완료되면 submitFlag=1

      if(!regMid.test(mid)) {
        alert("아이디는 4~20자리의 영문 대/소문자와 숫자, 언더바(_)만 사용가능합니다.");
        myform.mid.focus();
        return false;
      }
      else if(pwd.length < 4 && pwd.length > 20){
        alert("비밀번호는 4~20자리로 작성해주세요.");
        myform.pwd.focus();
        return false;
      }
      else if(!regNickName.test(nickName)) {
        alert("닉네임은 '한글/숫자/_'만 사용가능합니다.");
        myform.nickName.focus();
        return false;
      }
      else if(!regName.test(name)) {
        alert("성명은 한글과 영문대소문자만 사용가능합니다.");
        myform.name.focus();
        return false;
      }
      else if(!regEmail.test(email)) {
        alert("이메일 형식에 맞지않습니다.");
        myform.email1.focus();
        return false;
      }

      // 전화번호 형식 체크
      if(tel2 != "" && tel3 != "") {
        if(!regTel.test(tel)) {
          alert("전화번호형식을 확인하세요.(000-0000-0000)");
          myform.tel2.focus();
          return false;
        }
        else {
          submitFlag = 1;
        }
      }
      else {    // 전화번호를 입력하지 않을시 DB에는 '010- - '의 형태로 저장
        tel2 = " ";
        tel3 = " ";
        tel = tel1 + "-" + tel2 + "-" + tel3;
        submitFlag = 1;
      }

      // 전송전에 파일에 관련된 사항들을 체크
      
    }

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
        <label class="input-group-text bg-secondary-subtle border-secondary-subtle">가고싶은 여행지역</label>
        <div class="border form-control">
	        <input type="checkbox" class="form-check-input ms-2 me-1" value="서울" name="hopeTour"/>서울
	        <input type="checkbox" class="form-check-input ms-2 me-1" value="강릉" name="hopeTour"/>강릉
	        <input type="checkbox" class="form-check-input ms-2 me-1" value="대전" name="hopeTour"/>대전
	        <input type="checkbox" class="form-check-input ms-2 me-1" value="충북" name="hopeTour"/>충북
	        <input type="checkbox" class="form-check-input ms-2 me-1" value="인천" name="hopeTour"/>인천
	        <input type="checkbox" class="form-check-input ms-2 me-1" value="부산" name="hopeTour"/>부산
	        <input type="checkbox" class="form-check-input ms-2 me-1" value="기타" name="hopeTour" checked/>기타
        </div>
	    </div>
	    <div class="input-group mb-3">
	      <label for="content" class="input-group-text bg-secondary-subtle border-secondary-subtle">자기소개</label>
	      <textarea rows="5" class="form-control" id="content" name="content" placeholder="자기소개를 입력하세요."></textarea>
	    </div>
	    <div class="input-group mb-1">
	      <div class="input-group-text bg-secondary-subtle border-secondary-subtle">회원 사진(파일용량:2MByte이내)</div>
	      <input type="file" name="fName" id="file" onchange="imgCheck(this)" class="bg-secondary-subtle form-control"/>
	    </div>
	    <div class="text-end m-0 p-0"><img id="photoDemo" width="100px"/></div>
      <div class="text-center">
		    <button type="button" class="btn btn-success" onclick="fCheck()">회원가입</button> &nbsp;
		    <button type="reset" class="btn btn-warning">다시작성</button> &nbsp;
		    <button type="button" class="btn btn-info" onclick="location.href='${ctp}/member/memberLogin';">돌아가기</button>
	    </div>
    </div>
		
		<input type="hidden" name="email" />
		<input type="hidden" name="tel" />
		<input type="hidden" name="address" />
	</form>
	
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>