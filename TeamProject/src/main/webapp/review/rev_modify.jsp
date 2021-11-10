<%@page import="vo.ReviewBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%
	int rev_num = Integer.parseInt(request.getParameter("rev_num"));
	ReviewBean article = (ReviewBean)request.getAttribute("article");
	int rev_score = (int)article.getRev_score();
	String pic = article.getRev_pic(); 
	String pic_origin = article.getRev_pic_origin(); 
%>
<!DOCTYPE html>
<html>
<head>
<title>리뷰 작성</title>
<script src="./js/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="/TeamProject/css/rev_store.css">
<link rel="stylesheet" href="/TeamProject/css/reset.css">
<link rel="stylesheet" href="/TeamProject/css/header.css">
<script type="text/javascript">	
	$(document).ready(function() {
		
		if($('input[name=prev_pic]').val() != "null") { // 수정(사진이 있는 리뷰 css)
			$('.modifyP').css({'position':'relative', 'bottom':'126px','left':'126px'});
			$('.modifyMenu').css({'font-weight':'bold', 'text-align':'right', 'position':'relative', 'bottom':'146px'});
			$('.modifyBtn').css({'position':'relative', 'left':'240px', 'top':'40px'});
		}		
		if($('input[name=prev_pic]').val() == "null") { // 수정(사진이 없는 리뷰 css)
			$('.modifyP').css({'position':'relative', 'bottom':'20px'});
			$('.modifyMenu').css({'font-weight':'bold', 'text-align':'right', 'position':'relative', 'bottom':'38px'});
			$('.modifyBtn').css({'position':'relative', 'left':'422px', 'top':'148px'});
		}
		
		// 업로드된 파일명 표기하기
		$('#uploader').change(function() {
			var str = this.value;
			if(this.value != null) {
				$('.uploaderBtn img').attr({src:"<%=request.getContextPath()%>/review/rev_im/upload_img_color.png"});
				$('.uploadFile').html('(' + str.split("\\")[2] + ')');
			}
		});
		
		// 별점에 따라서 이미지 변경
		$('#div1 > input[name=rating]').click(function() {
			if($(this).val() > 0) {
				$('#img_score').css({visibility: "visible"});
			}
			$('#div1 img').attr({src:"./review/rev_im/" + $(this).val() + ".png"});
			$('#starScore').val($(this).val());
		});
		
		// 이전 리뷰 작성 시 체크했던 별점 불러오기.
		$('input[name=rev_score]').each(function() {
			if($(this).val() != 0) {
				$('#' + $(this).val() + '-stars').attr('checked', true);
				$('#img_score').css({visibility: "visible"});
				$('#div1 img').attr({src:"./review/rev_im/" + $(this).val() + ".png"});
				$('#starScore').val($(this).val());
			}
		});
		
		// 사진 삭제 버튼 정의
		$('input[value=삭제]').on('click', function() {
			if (confirm("정말 삭제하시겠습니까??") == true){    //확인
			    $('img[name=prev_pic]').remove();
			    $('input[value=삭제]').remove();
			    $('input[name=prev_pic]').remove();
			    $('input[name=prev_pic_origin]').remove();
// 			    $('.modifyP').css({'position':'relative', 'bottom':'0px','left':'0px'});
// 			    $('.modifyMenu').css({'font-weight':'bold', 'text-align':'right', 'position':'relative', 'bottom':'18px'});
			    $('.modifyP textarea').css({'position':'relative', 'top':'105px','right':'125px'});
				$('.modifyMenu').css({'font-weight':'bold', 'text-align':'right', 'position':'relative', 'bottom':'43px'});
			    $('.modifyBtn').css({'position':'relative', 'left':'422px', 'top':'142px'});
			}else{   //취소
			    return;
			}
		});
		
		// 이미지 팝업창
		$(function() {
		    //----- OPEN
		    $('[data-popup-open]').on('click', function(e)  {
		        var targeted_popup_class = jQuery(this).attr('data-popup-open');
		        $('[data-popup="' + targeted_popup_class + '"]').fadeIn(350);

		        e.preventDefault();
		    });

		    //----- CLOSE
		    $('[data-popup-close]').on('click', function(e)  {
		        var targeted_popup_class = jQuery(this).attr('data-popup-close');
		        $('[data-popup="' + targeted_popup_class + '"]').fadeOut(350);

		        e.preventDefault();
		    });
		    $('.popup').on('click', function(e)  { // 사진 요소 밖 클릭 시 종료
		        var targeted_popup_class = $('.popup img').attr('data-popup-close');
		        $('[data-popup="' + targeted_popup_class + '"]').fadeOut(350);

		        e.preventDefault();
		    });
		});
		
	}); // Jquery 마지막
		
</script>
</head>
<body>
	<!-- 상위 고정 -->
    <jsp:include page="../inc/header.jsp"></jsp:include>
    <!-- 상위 고정 -->
   
   <!-- 게시판 등록 -->
   <section id="modifyForm" >
   
		<div class="modifyStoreName"><h1><%=article.getRev_store() %></h1></div>
		
	<form action="ReviewModifyPro.re" method="post" enctype="multipart/form-data" name="boardForm">
      <!-- 파일 업로드 기능을 사용하려면 cos.jar 라이브러리 등록 필수 -->
      	<input type="hidden" value="<%=session.getAttribute("sNn") %>" name="rev_name"/>
      	<input type="hidden" value="<%=rev_num %>" name="rev_num"/>
      	<input type="hidden" value="<%=rev_score %>" name="rev_score"/>
      	<input type="hidden" name="prev_pic" value="<%=pic %>" />
		<input type="hidden" name="prev_pic_origin" value="<%=pic_origin %>" />
     	
			<!-- 별점마다 이모티콘 변경 -->
			<div class="star-list" id="div1">
				<input type="radio" id="5-stars" name="rating" value="5"
					v-model="ratings" /> <label for="5-stars" class="star">★</label>
				<!-- class="star  pr-4" -->
				<input type="radio" id="4-stars" name="rating" value="4"
					v-model="ratings" /> <label for="4-stars" class="star">★</label> <input
					type="radio" id="3-stars" name="rating" value="3" v-model="ratings" />
				<label for="3-stars" class="star">★</label> <input type="radio"
					id="2-stars" name="rating" value="2" v-model="ratings" /> <label
					for="2-stars" class="star">★</label> <input type="radio"
					id="1-stars" name="rating" value="1" v-model="ratings" /> <label
					for="1-stars" class="star">★</label>
			</div>
			<div class="star-rating" id="div1">
			<img id="img_score" src=" " width="45" height="45" >
			<input type="hidden" id="starScore" value="" />
		</div>
			
		<br>
      	<div id="modifyTable">
	        <table>
	            <tr>
	               <td>
	               	<div class="modifyBorder">
	                	<%if(pic != null) {%>
						<img src="./upload/<%=pic_origin %>" name="prev_pic" data-popup-open="photo_popup" class="modifyImg"/>
						<input type="button" value="삭제"/>
						<%} %>
						<span class="modifyBtn">
							<input type="submit" value="수정">
				         	<input type="button" value="취소" onclick="history.back()">
			        	</span>
						<p class="modifyP"><textarea name="rev_content" placeholder="예약에 대한 솔찍한 리뷰를 남겨주세요. (최대 150자)" maxlength="165"><%=article.getRev_content() %></textarea></p>
	               		<p class="modifyMenu">주문메뉴 : <%=article.getRev_menu() %></p>
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
   <!-- 팝업창에 띄울 이미지 정의 -->
	<div class="popup" data-popup="photo_popup">
	  <div class="popup-inner">
	    <div class="popup-contents">
	    <img src="<%=request.getContextPath() %>/upload/<%=pic_origin %>" class="popup_img" data-popup-close="photo_popup"/>
	    </div>
	  </div>
	</div>
</body>
</html>