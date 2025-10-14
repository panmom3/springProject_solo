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
  <jsp:include page="/WEB-INF/views/include/sub.jsp" />
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

	<div class="p-wrap bbs bbs__form bbs_new_skin">
		<div>
			<span class="p-form__required--icon">필수</span> 표시는 필수 항목 입니다.
		</div>
		<form name="myform" method="post" enctype="multipart/form-data">
			<fieldset>
				<legend>회원가입</legend>
					<table class="p-table mobile block">
						<caption>{회원가입} - 정보 제공</caption>
						<colgroup>
							<col class="w20p">
							<col>
						</colgroup>
						<tbody class="p-table--th-left">
							<tr>
								<th scope="row">
									<label for="name" class="p-form__label">이름 <span class="p-form__required--icon">필수</span></label>
								</th>
								<td>
									<input type="text" name="name" id="name" class="p-input p-input--auto" placeholder="입력하세요.">
									<span class="p-table__subject_text">이름을 정확히 입력하세요.</span>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="mid" class="p-form__label">아이디 <span class="p-form__required--icon">필수</span></label>
								</th>
								<td>
									<input type="text" name="mid" id="mid" class="p-input p-input--auto" placeholder="아이디를 입력하세요.">
									<input type="button" value="아이디 중복체크" id="midBtn" onclick="idCheck()" class="btn type1 medium"/>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="pwd" class="p-form__label">비밀번호 <span class="p-form__required--icon">필수</span></label>
								</th>
								<td>
									<input type="text" name="pwd" id="pwd" class="p-input p-input--auto" placeholder="비밀번호를 입력하세요.">
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="nickName" class="p-form__label">닉네임 <span class="p-form__required--icon">필수</span></label>
								</th>
								<td>
									<input type="text" name="nickName" id="nickName" class="p-input p-input--auto" placeholder="닉네임를 입력하세요.">
									<input type="button" value="닉네임 중복체크" id="nickNameBtn" onclick="nickNameCheck()" class="btn type1 medium"/>
								</td>
							</tr>
							<tr>
								<th scope="row">이메일 <span class="p-form__required--icon">필수</span></th>
								<td>
									<div class="row">
										<div class="col-16 col-sm-24">
											<div class="p-form-group">
												<input type="text" name="email1" id="email1" class="p-input" title="이메일 아이디 입력" value="">
												<span class="p-form__split">@</span>
												<select name="email2" class="p-input" title="이메일 도메인 선택">
													<option value="gmail.com" selected>gmail.com</option>
									        <option value="naver.com">naver.com</option>
									        <option value="hotmail.com">hotmail.com</option>
									        <option value="hanmail.com">hanmail.com</option>
									        <option value="nate.com">nate.com</option>
												</select>
											</div>
										</div>
										<div class="col-8 col-sm-24">
											<input type="button" value="인증번호받기" onclick="emailCertification()" id="certificationBtn" class="btn type2 medium">
										</div>
									</div>
									<!-- <div id="demoSpin" class="mb-3"></div> -->
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="birthday" class="p-form__label">생일</label>
								</th>
								<td>
									<input type="date" name="birthday" id="birthday" value="${today}" class="p-input p-input--auto" placeholder="생일을 입력하세요.">
								</td>
							</tr>
							<tr>
								<th scope="row">연락처 <span class="p-form__required--icon">필수</span></th>
								<td>
									<div class="row telbox">
										<div class="col-12 col-sm-24 ">
											<div class="p-form-group">
												<select name="tel1" id="tel1" class="p-input" title="연락처 첫번째 번호 선택">
													<option value="">010</option>
													<option value="">011</option>
												</select>
												<span class="p-form__split"> - </span>
												<input type="tel" name="tel2" class="p-input" maxlength=4 title="연락처 중간번호 입력" value="">
												<span class="p-form__split"> - </span>
												<input type="tel" name="tel3" class="p-input" maxlength=4 title="연락처 마지막번호 입력" value="">
											</div>
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row">주소</th>
								<td>
									<div class="addressbox">
										<div class="post">
											<input type="number" name="postcode" id="sample6_postcode" class="p-input p-input--auto zipcode" placeholder="우편번호">
											<button type="button" onclick="sample6_execDaumPostcode()" title="새창" class="p-button primary postbtn">우편번호</button>
										</div>
										<div class="adress mb-2">
											<input type="text" name="roadAddress" id="sample6_address" placeholder="주소" class="p-input adressinput">
										</div>
										<div class="adress">
											<input type="text" name="detailAddress" id="sample6_detailAddress" class="p-input adressinput" title="상세주소 입력" placeholder="상세주소를 입력해주세요">
											<input type="hidden" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="p-input adressinput">
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row">가고싶은 여행지</th>
								<td>
									<span class="p-form-checkbox">
										<input type="checkbox" name="hopeTour" id="hope1" class="p-form-checkbox__input" value="서울" checked>
										<label for="hope1" class="p-form-checkbox__label">서울</label>
									</span>
									<span class="p-form-checkbox">
										<input type="checkbox" name="hopeTour" id="hope2" class="p-form-checkbox__input" value="강릉">
										<label for="hope2" class="p-form-checkbox__label">강릉</label>
									</span>
									<span class="p-form-checkbox">
										<input type="checkbox" name="hopeTour" id="hope3" class="p-form-checkbox__input" value="대전">
										<label for="hope3" class="p-form-checkbox__label">대전</label>
									</span>
									<span class="p-form-checkbox">
										<input type="checkbox" name="hopeTour" id="hope4" class="p-form-checkbox__input" value="충북">
										<label for="hope4" class="p-form-checkbox__label">충북</label>
									</span>
									<span class="p-form-checkbox">
										<input type="checkbox" name="hopeTour" id="hope5" class="p-form-checkbox__input" value="인천">
										<label for="hope5" class="p-form-checkbox__label">인천</label>
									</span>
									<span class="p-form-checkbox">
										<input type="checkbox" name="hopeTour" id="hope6" class="p-form-checkbox__input" value="부산">
										<label for="hope6" class="p-form-checkbox__label">부산</label>
									</span>
									<span class="p-form-checkbox">
										<input type="checkbox" name="hopeTour" id="hope7" class="p-form-checkbox__input" value="기타">
										<label for="hope7" class="p-form-checkbox__label">기타</label>
									</span>						
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="content" class="p-form__label">자기소개</label></th>
								<td>
									<textarea name="content" id="content" class="p-input" cols="10" rows="5" placeholder="자기소개를 입력하세요." required="required"></textarea>
								</td>
							</tr>
							<tr>
								<th scope="row">회원 사진<br/>(파일용량:2MByte이내)</th>
								<td>
									<input type="file" name="fName" id="file" onchange="imgCheck(this)" class="bg-secondary-subtle form-control"/>
									<div class="text-end m-0 p-0">
										<img id="photoDemo" width="100px"/>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
			</fieldset>
			<div class="text-center">
		    <button type="button" class="btn type1" onclick="fCheck()">회원가입</button> &nbsp;
		    <button type="reset" class="btn type3">다시작성</button> &nbsp;
		    <button type="button" class="btn type2" onclick="location.href='${ctp}/member/memberLogin';">돌아가기</button>
	    </div>
	    
	    <input type="hidden" name="email" />
			<input type="hidden" name="tel" />
			<input type="hidden" name="address" />
		</form>
	</div>
	
	
	
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>