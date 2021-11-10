<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// session 객체에 저장된 nickName 값("nickName" 속성) 가져오기
	String nickName = (String)session.getAttribute("sNn"); // Object -> String 다운캐스팅
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 작성</title>
<script src="./js/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="/TeamProject/css/rev_store.css">
<link rel="stylesheet" href="/TeamProject/css/reset.css">
<link rel="stylesheet" href="/TeamProject/css/header.css">
<script type="text/javascript">	
	$(document).ready(function() {
		
		// 별점에 따라서 이미지 변경
		$('#div1 > input[name=rating]').click(function() {
			if($(this).val() > 0) {
				$('img').css({visibility: "visible"});
			}
			$('#div1 img').attr({src:"./review/rev_im/" + $(this).val() + ".png"});
			$('#starScore').val($(this).val());
		});
		
		// 업로드된 파일명 표기하기
		$('#uploader').change(function() {
			var str = this.value;
// 			alert(str);
			if(this.value != null) {
				$('.uploaderBtn img').attr({src:"<%=request.getContextPath()%>/review/rev_im/upload_img_color.png"});
				$('.uploadFile').html('(' + str.split("\\")[2] + ')');
			}
		});
		  
	});
		
</script>
</head>
<body>
	<!-- 상위 고정 -->
    <jsp:include page="../inc/header.jsp"></jsp:include>
    <!-- 상위 고정 -->
   
   <!-- 게시판 등록 -->
   <section id="writeForm" >
   
		<h1><%=request.getParameter("rev_store") %></h1>
		
	<form action="ReviewWritePro.re" method="post" enctype="multipart/form-data" name="boardForm">
	<!-- 예약번호 값 넘기기 --> <input type="hidden" name="ran_num" value="<%=request.getParameter("ran_num") %>" />
	<!-- 리뷰 작성자 값 넘기기 --> <input type="hidden" value="<%=nickName %>" name="rev_name"/>
	<!-- 리뷰 매장명 값 넘기기 --> <input type="hidden" value="<%=request.getParameter("rev_store") %>" name="rev_store"/>
	<!-- 리뷰 주문메뉴 값 넘기기 --> <input type="hidden" value="<%=request.getParameter("rev_menu") %>" name="rev_menu"/>
     	
		<div class="star-rating space-x-4 mx-auto" id="div1">
		
			<!-- 별점마다 이모티콘 변경 -->
			<img id="img_score" src=" " width="45" height="45" >
			<input type="hidden" id="starScore" value="" />
			
			<input type="radio" id="5-stars" name="rating" value="5" v-model="ratings"/>
			<label for="5-stars" class="star" >★</label> <!-- class="star  pr-4" -->
			<input type="radio" id="4-stars" name="rating" value="4" v-model="ratings"/>
			<label for="4-stars" class="star">★</label>
			<input type="radio" id="3-stars" name="rating" value="3" v-model="ratings"/>
			<label for="3-stars" class="star">★</label>
			<input type="radio" id="2-stars" name="rating" value="2" v-model="ratings" />
			<label for="2-stars" class="star">★</label>
			<input type="radio" id="1-stars" name="rating" value="1" v-model="ratings" />
			<label for="1-stars" class="star">★</label>
			
		</div><br>
      	<div id="writeTable">
	        <table>
	            <tr>
	               <td>
	               	<div class="writeBorder">
						<span class="writeBtn">
							<input type="submit" value="등록">
				         	<input type="button" value="취소" onclick="history.back()">
			        	</span>
						<p><textarea name="rev_content" placeholder="예약에 대한 솔찍한 리뷰를 남겨주세요. (최대 150자)" maxlength="165"></textarea></p>
	                </div>
	               </td>
	            </tr>
	            <tr>
	               <td>
						<input type="file" id="uploader" name="uploader" accept="image/jpeg, image/png, image/gif" style="display: none"/>
						<span class="uploaderBtn" onclick="onclick=document.all.uploader.click()"><img src="<%=request.getContextPath()%>/review/rev_im/upload_img.png" />사진</span><p class="uploadFile"></p>
	               </td>
	            </tr>
	         </table>
         </div>
      </form>
   </section>
   
</body>
</html>