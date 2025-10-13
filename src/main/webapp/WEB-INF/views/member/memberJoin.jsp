<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <meta name="description" content="" />
  <meta name="author" content="" />
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <title>회원가입</title>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
  <script>
  	'use strict';
  
    let idCheckSw = 0;
    let nickCheckSw = 0;

    // 정규식을 이용한 유효성검사처리
    let regMid = /^[a-zA-Z0-9_]{4,20}$/;// 아이디는 4~20의 영문 대/소문자와 숫자와 밑줄 가능
    let regNickName = /^[가-힣0-9_]+$/;		// 닉네임은 한글, 숫자, 밑줄만 가능
    let regName = /^[가-힣a-zA-Z]+$/;			// 이름은 한글/영문 가능
    let regEmail =/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;

    function fCheck() {
    	// 유효성 검사.....
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

      // 전송전에 '주소'를 하나로 묶어서 전송처리 준비한다.
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
      let fName = document.getElementById("file").value;
      if(fName.trim() != "") {
        let ext = fName.substring(fName.lastIndexOf(".")+1).toLowerCase();
        let maxSize = 1024 * 1024 * 5;
        let fileSize = document.getElementById("file").files[0].size;

        if(ext != 'jpg' && ext != 'gif' && ext != 'png') {
          alert("그림파일만 업로드 가능합니다.");
          return false;
        }
        else if(fileSize > maxSize) {
          alert("업로드할 파일의 최대용량은 5MByte입니다.");
          return false;
        }
        submitFlag = 1;
      }

      // 전송전에 모든 체크가 끝나면 submitFlag가 1로 되게된다. 이때 값들을 서버로 전송처리
      if(submitFlag == 1) {
        if(idCheckSw == 0) {
          alert("아이디 중복체크버튼을 눌러주세요");
          document.getElementById("midBtn").focus();
        } 
        else if(nickCheckSw == 0) {
          alert("닉네임 중복체크버튼을 눌러주세요");
          document.getElementById("nickNameBtn").focus();
        }
        else {
          myform.email.value = email;
          myform.tel.value = tel;
          myform.address.value = address;

          myform.submit();
        }
      }
      else {
        alert("회원정보등록 실패~~다시 확인하세요.")
      }
    }
    
    // 아이디 중복체크
    function idCheck() {
    	let mid = myform.mid.value.trim();
    	
    	if(!regMid.test(mid)) {
    		alert("아이디는 4~20자리의 영문 소/대문자와 숫자, 언더바(_)만 사용가능합니다.");
    		myform.mid.focus();
    		return false;
    	}
    	
    	$.ajax({
    		url : "${ctp}/member/memberIdCheck",
    		type : "post",
    		data : {mid : mid},
    		success : (res) => {
    			if(res != '') {
    				alert("이미 사용중인 아이디 입니다. 다시 입력하세요.");
    				myform.mid.focus();
    			}
    			else {
    				alert("사용 가능한 아이디 입니다.");
    				document.getElementById("mid").readOnly = true;
    				if(document.getElementById("pwd").value == '') document.getElementById("pwd").focus();
    				idCheckSw = 1;
    			}
    		},
    		error : () => alert("전송 오류!")
    	});
    }
 		// 닉네임 중복체크
    function nickNameCheck() {
    	let nickName = myform.nickName.value.trim();
    	
    	if(!regNickName.test(nickName)) {
        alert("닉네임은 '한글/숫자/_'만 사용가능합니다.");
        myform.nickName.focus();
        return false;
      }
    	
    	$.ajax({
				url  : "${ctp}/member/memberNickCheck",
				type : "post",
				data : {nickName : nickName},
				success: (res) => {
					if(res != '') {
						alert("이미 사용중인 닉네임 입니다. 다시 입력하세요.");
						myform.nickName.focus();
					}
					else {
						alert("사용 가능한 닉네임 입니다.");
						document.getElementById("nickName").readOnly = true;
						if(document.getElementById("name").value == '') document.getElementById("name").focus();
						nickCheckSw = 1;
					}
				},
				error : () =>	alert("전송 오류!")
			});
    }
 		
 		// 선택된 사진 미리보기
 		function imgCheck(e){
 			if(e.files && e.files[0]) {
 				let reader = new FileReader();
 				reader.onload = function(e) {
 					document.getElementById("photoDemo").src = e.target.result;
 				}
 				reader.readAsDataURL(e.files[0]);
 			}
 		}


  </script>

</head>
<body>
<!-- nav -->
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<!-- header -->
<jsp:include page="/WEB-INF/views/include/header.jsp">
  <jsp:param name="bgImage" value="about-bg.jpg"/>
  <jsp:param name="siteTitle" value="회원가입"/>
  <jsp:param name="subTitle" value="이지트립 회원가입페이지입니다."/>
</jsp:include>
<!-- container -->
<div class="container px-4 px-lg-5">
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
		      <div class="input-group mb-1">
		        <input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control me-2">
	          <input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="form-control">
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
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>