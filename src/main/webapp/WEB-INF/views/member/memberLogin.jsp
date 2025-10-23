<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="" />
  <meta name="author" content="" />
  <jsp:include page="/WEB-INF/views/include/sub.jsp" />
  <title>Login</title>
</head>
<body id="sub" class="sub">
<div id="wrapper">
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<div id="container">
		<jsp:include page="/WEB-INF/views/include/header.jsp">
  		<jsp:param name="bgImage" value="sub_visual.png"/>
  		<jsp:param name="siteTitle" value="로그인"/>
  		<jsp:param name="subTitle" value="이지트립 페이지입니다."/>
		</jsp:include>
		<div class="wrap clearfix">
			<main id="colgroup" class="colgroup">
				<article>
					<div id="contents">
						<form name="myform" method="post">
					    <table class="table type2 w50p margin_auto">
					    	<caption>{회원가입} - 정보 제공</caption>
								<colgroup>
									<col class="w30p">
									<col>
								</colgroup>
						    <tbody>
						      <tr>
						        <th>아이디</th>
						        <td><div class="sd_input"><input type="text" name="mid" id="mid" value="${mid}" autofocus required/></div></td>
						      </tr>
						      <tr>
						        <th>비밀번호</th>
						        <td><div class="sd_input"><input type="password" name="pwd" id="pwd" required class="form-control"/></div></td>
						      </tr>
						    </tbody>
					    </table>
					    <div class="text_center">
					    	<div class="margin_t_50">
				          <input type="submit" value="로그인" class="btn type1 medium"/>
				          <input type="reset" value="다시입력" class="btn type3 medium"/>
				          <input type="button" value="회원가입" onclick="location.href='${ctp}/member/memberJoin';" class="btn type2 medium"/>
			          </div>
				    		<div class="margin_t_20">
				    			<input type="checkbox" name="idSave" checked />아이디 저장 /
				    			<a href="memberIdSearch" class="text-decoration-none text-dark link-primary">아이디찾기</a> /
				    			<a href="#" class="text-decoration-none text-dark link-primary">비밀번호찾기</a>
				    		</div>
					    </div>
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