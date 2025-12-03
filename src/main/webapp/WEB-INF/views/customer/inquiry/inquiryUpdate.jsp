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
	<title>문의글 수정하기</title>
	<script>
		//선택한파일 미리보기 기능
		var sel_files = []; // 전체 선택된 파일 저장 (누적)
		
		$(document).ready(function() {
			$("#file").on("change", handleImgsFileSelect);
		});
		
		function handleImgsFileSelect(e) {
			var files = e.target.files;
		  var filesArr = Array.prototype.slice.call(files);
		  $(".imgs_wrap").html('');
		  
		  // 🔥 현재 선택한 파일 개수가 기존 파일 개수 포함해서 10개 이상이면 막기
		  if(sel_files.length + filesArr.length >= 10) {
			  alert("파일은 최대 10개까지 업로드할 수 있습니다.");
			  return;
		  }
		  
		  filesArr.forEach(function(f) {
		  
				sel_files.push(f);  // 누적 저장
				
				var reader = new FileReader();
				reader.onload = function(e) {
					
					if(f.type.match("image.*")) {
						// 이미지면 미리보기
						var img_html = "<img src=\"" + e.target.result + "\" style='width:100px'> ";
						$(".imgs_wrap").append(img_html);
					}
					else {
						// 이미지가 아닌 일반 파일은 파일명만 출력
						var file_html = "<div>"+ f.name +"</div>";
						$(".imgs_wrap").append(file_html);
					}
				}
				// 이미지 파일은 DataURL 방식으로 미리보기 가능
		    // 일반 파일은 onload에서 파일명만 처리
				reader.readAsDataURL(f);
			});
		}
	
	
		function fCheck() {
			var title = myform.title.value;
			var part = myform.part.value;
			var content = myform.content.value;
			
			if(title="") {
				alert("제목을 입력하세요.");
				myform.title.focus();
				return false;
			}
			else if(part="") {
				alert("문의유형을 입력하세요.");
				myform.part.focus();
				return false;
			}
			else if(content="") {
				alert("내용을 입력하세요.");
				myform.content.focus();
				return false;
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
  		<jsp:param name="siteTitle" value="문의글 수정하기"/>
  		<jsp:param name="subTitle" value=""/>
		</jsp:include>
		<div class="wrap clearfix">
			<main id="colgroup" class="colgroup">
				<article>
					<div id="contents">
						<form name="myform" method="post" enctype="multipart/form-data">
							<div class="table_scroll">
								<table class="table type2">
									<caption>1:1문의 작성하기</caption>
									<colgroup>
										<col class="w20p"/>
										<col class="w80p"/>
									</colgroup>
									<tbody>
										<tr>
											<th scope="row">제목</th>
											<td>
												<input type="text" name="title" value="${vo.title}" class="p-input" maxlength="100" autofocus />
											</td>
										</tr>
										<tr>
											<th scope="row">문의유형</th>
											<td class="text_left">
												<select name="part" class="p-select">
													<option value="이용문의" ${vo.part == '이용문의' ? 'selected' : ''}>이용문의</option>
													<option value="여행관련문의" ${vo.part == '여행관련문의' ? 'selected' : ''}>여행관련문의</option>
													<option value="숙박예약문의" ${vo.part == '숙박예약문의' ? 'selected' : ''}>숙박예약문의</option>
													<option value="회원정보문의" ${vo.part == '회원정보문의' ? 'selected' : ''}>회원정보문의</option>
													<option value="기타문의" ${vo.part == '기타문의' ? 'selected' : ''}>기타문의</option>
												</select>
											</td>
										</tr>
										<tr>
											<th scope="row">내용</th>
											<td>
												<textarea name="content" rows="5" class="p-input">${vo.content}</textarea>
											</td>
										</tr>
										<tr>
											<th scope="row">파일첨부</th>
											<td class="text_left">
												<input type="file" name="file" id="file" multiple accept=".jpg,.png,.pdf,.doc,.docx,.hwp" />
												<div class="imgs_wrap"><c:if test="${!empty vo.FSName}"><img src="${ctp}/data/inquiry/${vo.FSName}"  width="400px"/></c:if></div>
												<p class="warning type1 margin_t_10">파일 형식은 jpg / png / pdf / doc / docx / hwp만 허용합니다.(최대 10개 업로드가능)</p>
											</td>
										</tr>
										<tr>
											<th scope="row">개인정보 수집 및*<br/> 이용동의 안내</th>
											<td>
												<ol class="num">
													<li>개인정보의 수집·이용 목적 : 상담 관련 안내</li>
													<li>수집하려는 개인정보의 항목 : 이름, 연락처, 이메일, 문의내용, 첨부파일</li>
													<li>개인정보의 보유 및 이용 기간 : 접수일로부터 3년 후 파기</li>
													<li>동의 거부권 및 거부 시 불이익사항 : 동의를 거부하실 수 있으며, 거부 시 쇼핑환불 접수 및 상담이 불가함을 안내 드립니다.</li>
												</ol>
												<div class="line margin_t_20 margin_b_20"></div>
												<div class="text_left">
													<p>위 개인정보 수집 및 이용에 동의하십니까?</p>
													<span class="sd_input">
															<input type="radio" name="radio" id="radio1" value="">
															<label for="radio1">동의합니다</label>
													</span>
													<span class="sd_input">
															<input type="radio" name="radio" id="radio2" value="">
															<label for="radio2">동의하지 않습니다.</label>
													</span>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="text_center margin_t_50">
								<input type="button" value="수 정" onclick="fCheck()" class="btn medium type1"/> &nbsp;
				    		<input type="reset" value="다시입력" class="btn medium type3"/> &nbsp;
				    		<input type="button" value="돌아가기" onclick="location.href='${ctp}/customer/inquiry/inquiryView?idx=${vo.idx}&pag=${pag}';" class="btn medium type2"/>
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