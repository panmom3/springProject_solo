<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<script>
  function userDeleteCheck() {
	  let ans = confirm("회원 탈퇴하시겠습니까?");
	  if(ans) {
		  ans = confirm("탈퇴하시면 1개월간 같은 아이디로는 다시 가입하실수 없습니다.\n그래도 탈퇴 하시겠습니까?");
		  if(ans) {
			  $.ajax({
				  url  : '${ctp}/member/userDelete',
				  type : 'post',
				  success: (res) => {
					  if(res != '0') {
						  alert("회원에서 탈퇴 되셨습니다.");
						  location.href = '${ctp}/member/memberLogin';
					  }
					  else alert("회원 탈퇴 실패~~");
				  },
				  error : () => alert("전송오류!")
			  });
		  }
	  }
  }
</script>

<!-- Navbar -->
<div class="w3-top">
  <div class="w3-bar w3-black w3-card">
    <a class="w3-bar-item w3-button w3-padding-large w3-hide-medium w3-hide-large w3-right" href="javascript:void(0)" onclick="myFunction()" title="Toggle Navigation Menu"><i class="fa fa-bars"></i></a>
    <a href="http://localhost:9090/springGroupS09/" class="w3-bar-item w3-button w3-padding-large">HOME</a>
    <a href="#" class="w3-bar-item w3-button w3-padding-large w3-hide-small">추천여행지</a>
    <a href="#" class="w3-bar-item w3-button w3-padding-large w3-hide-small">이벤트소식</a>
    <a href="#" class="w3-bar-item w3-button w3-padding-large w3-hide-small">소통공간</a>
    <a href="#" class="w3-bar-item w3-button w3-padding-large w3-hide-small">온라인예약</a>
    <div class="w3-dropdown-hover w3-hide-small">
      <button onclick="location.href='${ctp}/member/memberMain'" class="w3-padding-large w3-button" title="More">MyPage <i class="fa fa-caret-down"></i></button>     
      <div class="w3-dropdown-content w3-bar-block w3-card-4">
        <c:if test="${sLevel < 3}">
	        <a href="${ctp}/schedule/schedule" class="w3-bar-item w3-button">일정관리</a>
	        <a href="${ctp}/study1/aop/aopMenu" class="w3-bar-item w3-button">웹메세지</a>
	        <a href="${ctp}/study1/xml/xmlMenu" class="w3-bar-item w3-button">Photo Gallery</a>
	        <a href="${ctp}/member/memberList" class="w3-bar-item w3-button">회원리스트</a>
        </c:if>
        <a href="${ctp}/member/memberPwdCheck/p" class="w3-bar-item w3-button">비밀번호변경</a>
        <a href="${ctp}/member/memberPwdCheck/u" class="w3-bar-item w3-button">회원정보수정</a>
        <a href="javascript:userDeleteCheck()" class="w3-bar-item w3-button">회원탈퇴</a>
        <c:if test="${sLevel == 0}">
        	<a href="${ctp}/admin/adminMain" class="w3-bar-item w3-button">관리자메뉴</a>
        </c:if>
      </div>
    </div>

    <c:if test="${empty sLevel}">
	    <a href="${ctp}/member/memberLogin" class="w3-bar-item w3-button w3-padding-large w3-hide-small">Login</a>
	    <a href="${ctp}/member/memberJoin" class="w3-bar-item w3-button w3-padding-large w3-hide-small">Join</a>
    </c:if>
    <c:if test="${!empty sLevel}">
    	<a href="${ctp}/member/memberLogout" class="w3-bar-item w3-button w3-padding-large w3-hide-small">Logout</a>
    </c:if>
  </div>
</div>





<!-- Navbar on small screens (remove the onclick attribute if you want the navbar to always show on top of the content when clicking on the links) -->
<div id="navDemo" class="w3-bar-block w3-black w3-hide w3-hide-large w3-hide-medium w3-top" style="margin-top:46px">
  <a href="#band" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">BAND</a>
  <a href="#tour" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">TOUR</a>
  <a href="#contact" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">CONTACT</a>
  <a href="#" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">MERCH</a>
  <a href="#" class="w3-bar-item w3-button w3-padding-large w3-hide-small">Login</a>
</div>