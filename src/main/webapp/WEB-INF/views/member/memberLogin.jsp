<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=Edge" />
  <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, maximum-scale=2.0, minimum-scale=1.0, user-scalable=yes" />
  <meta name="description" content="" />
  <meta name="author" content="" />
  <jsp:include page="/WEB-INF/views/include/sub.jsp" />
  <title>Login</title>
</head>
<body>
<!-- nav -->
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<!-- header -->
<jsp:include page="/WEB-INF/views/include/header.jsp">
  <jsp:param name="bgImage" value="home-bg.jpg"/>
  <jsp:param name="siteTitle" value="로그인"/>
  <jsp:param name="subTitle" value="이지트립 로그인페이지입니다."/>
</jsp:include>
<!-- Main Content-->
<div class="container px-4 px-lg-5">
	<form name="myform" method="post">
    <table class="p-table mobile block">
    	<caption>{회원가입} - 정보 제공</caption>
			<colgroup>
				<col class="w20p">
				<col>
			</colgroup>
	    <tbody class="p-table--th-left">
	      <tr>
	        <th class="align-middle">아이디</th>
	        <td><input type="text" name="mid" id="mid" value="${mid}" autofocus required class="form-control"/></td>
	      </tr>
	      <tr>
	        <th class="align-middle">비밀번호</th>
	        <td><input type="password" name="pwd" id="pwd" required class="form-control"/></td>
	      </tr>
	      <tr class="text-center">
	        <td colspan="2">
	          <div class="mb-2">
		          <input type="submit" value="로그인" class="btn type1 medium"/>
		          <input type="reset" value="다시입력" class="btn type3 medium"/>
		          <input type="button" value="회원가입" onclick="location.href='${ctp}/member/memberJoin';" class="btn type2 medium"/>
	          </div>
		    		<div>
		    			<input type="checkbox" name="idSave" checked />아이디 저장 /
		    			<a href="memberIdSearch" class="text-decoration-none text-dark link-primary">아이디찾기</a> /
		    			<a href="#" class="text-decoration-none text-dark link-primary">비밀번호찾기</a>
		    		</div>
	        </td>
	      </tr>
	    </tbody>
    </table>
  </form>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>