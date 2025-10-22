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
  <jsp:include page="/WEB-INF/views/include/sub.jsp" />
	<title>비밀번호변경</title>
	<script>
		'use strict';
		
		function pwdCheck() {
    	let pwd = $("#pwd").val().trim();
    	if(pwd == "") {
    		alert("현재 비밀번호를 입력하세요");
    		$("#pwd").focus();
    		return false;
    	}
    	
    	$.ajax({
    		url  : '${ctp}/member/memberPwdCheck',
    		type : 'post',
    		data : {
    			pwd : pwd,
    			mid : '${sMid}'
    		},
    		success: (res) => {
    			if(res != '0') {
    				if('${flag}' == 'pwdck') {
    					$("#myform").hide();
    					$("#newPassform").show();
    				} else {
    					location.href = '${ctp}/member/memberUpdate?mid=${sMid}';
    				}
    			}
    			else {
    				alert("비밀번호가 틀립니다. 확인해 주세요");
    				$("#pwd").focus();
    			}
    		},
    		error : () => alert("전송오류!")
    	});
    }
		
		function pwdChange() {
			let newPwd = $("#newPwd").val().trim();
			let rePwd = $("#rePwd").val().trim();
			
			if(newPwd == "" || rePwd == "" || newPwd != rePwd) {
				alert("비밀번호가 다릅니다. 비밀번호를 확인하세요");
			}
			else {
				newPassform.action = "${ctp}/member/memberPwdChange";
				newPassform.submit();
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
  		<jsp:param name="siteTitle" value="비밀번호변경"/>
  		<jsp:param name="subTitle" value=""/>
		</jsp:include>
		<div class="wrap clearfix">
			<main id="colgroup" class="colgroup">
				<article>
					<div id="contents">
						<form name="myform" id="myform" method="post">
							<table class="table">
								<tbody>
									<tr>
						        <th colspan="2">
						          <h3>비밀번호 확인</h3>
						          <div>(현재 비밀번호를 확인합니다.)</div>
						        </th>
						      </tr>
						      <tr>
						        <th>비밀번호</th>
						        <td><input type="password" name="pwd" id="pwd" class="form-control" autofocus required /></td>
						      </tr>
						      <tr>
						        <td colspan="2">
						          <input type="button" value="비밀번호확인" onclick="pwdCheck()" class="btn type1 medium"/>
						          <input type="reset" value="다시입력" class="btn type3 medium"/>
						          <input type="button" value="돌아가기" onclick="location.href='memberMain'" class="btn type2 medium"/>
						        </td>
						      </tr>
								</tbody>
							</table>
						</form>
						<form name="newPassform" id="newPassform" method="post" style="display:none">
							<table class="table">
								 <tr>
					        <th colspan="2">
					          <h3>비밀번호 변경</h3>
					          <div>(변경할 비밀번호를 입력하세요)</div>
					        </th>
					      </tr>
					      <tr>
					        <th>새비밀번호</th>
					        <td><input type="password" name="newPwd" id="newPwd" class="form-control" required /></td>
					      </tr>
					      <tr>
					        <th>비밀번호확인</th>
					        <td><input type="password" name="rePwd" id="rePwd" class="form-control" required /></td>
					      </tr>
					      <tr>
					        <td colspan="2">
					          <input type="button" value="비밀번호변경" onclick="pwdChange()" class="btn type1 medium"/>
					          <input type="reset" value="다시입력" class="btn type3 medium"/>
					          <input type="button" value="돌아가기" onclick="location.href='location.href='${ctp}/member/memberMain';" class="btn type2 medium"/>
					        </td>
					      </tr>
							</table>
							<input type="hidden" name="mid" value="${sMid}" />
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