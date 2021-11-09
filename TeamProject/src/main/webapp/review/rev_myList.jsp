<%@page import="vo.ReviewBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	ArrayList<ReviewBean> myReviewList = (ArrayList<ReviewBean>)request.getAttribute("myReviewList");
	ReviewBean myListCount = (ReviewBean)request.getAttribute("myListCount");
	%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Review_Test</title>
<script src="./js/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="/TeamProject/css/rev_store.css">
<link rel="stylesheet" href="/TeamProject/css/reset.css">
<link rel="stylesheet" href="/TeamProject/css/header.css">
<script type="text/javascript">	
	$(document).ready(function() {
		var rev_name = $('input[name=rev_name]').val(); // 닉네임 전달
		
		// 이전 리뷰 작성 시 체크했던 별점 불러오기.
		$('input[name=rev_score]').each(function() {
			if($(this).val() != 0) {
				$('#' + $(this).val() + '-stars').attr('checked', true);
				$('#img_score').css({visibility: "visible"});
				$('#div1 img').attr({src:"./review/rev_im/" + $(this).val() + ".png"});
			}
		});
		
		// 좋아요 갯수 증가를 위한 ajax 정의
		$('#rev_menu_btn button').click(function() {
			var rev_num = $(this).val(); // 리뷰 번호 전달
			$.ajax({ url: "<%=request.getContextPath()%>/ReviewLikeScore.re",
				type: "POST",
				cache: false,
				dataType: "json",
				data: {
					rev_num : rev_num,
					rev_name : rev_name
				},
				success: function(data){ //ajax통신 성공시 넘어오는 데이터 통째 이름 =data
					// 좋아요 or 취소에 따라 버튼 색상 바꾸기
					$.ajax({ url: "<%=request.getContextPath()%>/ReviewIsLikeCheked.re",
						type: "POST",
						cache: false,
						dataType: "json",
						data: {
							rev_num : rev_num,
							rev_name : rev_name
						},
						success: function(data){ //ajax통신 성공시 넘어오는 데이터 통째 이름 =data 
							var isClick = data.isCheck;
							if(isClick > 0){
								$('.btnLike' + rev_num + ' img').attr({src:"<%=request.getContextPath()%>/review/rev_im/rev_write.png"});
								alert("'좋아요'가 반영되었습니다!") ;
							} else {
								$('.btnLike' + rev_num + ' img').attr({src:"<%=request.getContextPath()%>/review/rev_im/rev_empty.png"});
								alert("'좋아요'가 취소되었습니다!") ;
							}
						}, 
						error:
						function (request, status, error){
						alert("ajax실패") } 
					});
					// 좋아요 or 취소 판단 후 좋아요 수 변경
					$(".likeScore" + rev_num).html(data.like); //id값이 like_result인 html을 찾아서 data.like값으로 바꿔준다. 
				}, 
				error:
				function (request, status, error){
				alert("ajax실패") } 
			}); 
		}); // 좋아요 ajax 끝		
		
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
		}); // 이미지 팝업창 끝
	}); // 제이쿼리 끝
	
	function isWriter(rev_num) {
		var rev_name = $('input[name=rev_name]').val();
		var rev_writer = $('input[name=rev_writer]').val();
		if(rev_name == rev_writer) {
			location.href='./ReviewModify.re?rev_num='+ rev_num
		} else {
			alert('수정 권한이 없습니다!');
		}
	}
		
</script>
</head>
<body>
	<!-- 상위 고정 -->
   	<jsp:include page="../inc/header.jsp"></jsp:include>
   	<!-- 상위 고정 -->
	<div id="wrap">
		<!-- 본문 메인 이미지  -->
		<div id="sub_img_center"></div>
		<!-- 본문 좌측 메뉴 -->
		
		<nav id="member_title">
			<h3>내가 쓴 총 리뷰 <%=myListCount.getListCount() %>개</h3>	
		</nav>
		
		<!-- 리뷰 게시물 목록 표시 -->
		<% for(int i = 0; i < myReviewList.size(); i++) {
			String str = myReviewList.get(i).getRev_pic_origin(); 
			int rev_score = (int)myReviewList.get(i).getRev_score();
			int dateDiff = myReviewList.get(i).getDateDiff();
		%>
		<input type="hidden" value="<%=rev_score %>" id="rev_star"/>
		<input type="hidden" name="rev_writer" value="<%=myReviewList.get(i).getRev_name() %>" />
		<input type="hidden" name="rev_name" value="<%=session.getAttribute("sNn") %>" />
		<table class="rev_table">
			<tr class="table_subject">
				<td>
					<!-- 닉네임 --><span class="userName"><%=myReviewList.get(i).getRev_name() %>님</span><br>
					<!-- 별점 --><img src="./review/rev_im/<%=rev_score %>star.png" width="100" height="20" />
					<!-- 작성일 --> 
					<span class="rev_date"> 
						<%if(dateDiff == 0){ %>
							오늘
						<%} else if(dateDiff == 1){ %>
							어제
						<%} else if(dateDiff == 2){ %>
							그제
						<%} else if(dateDiff >= 3 && dateDiff <= 7){ %>
							이번 주
						<%} else if(dateDiff >= 8 && dateDiff <= 14){ %>
							저번 주
						<%} else if(dateDiff >= 15 && dateDiff <= 21){ %>
							3주 전
						<%} else if(dateDiff >= 22 && dateDiff <= 29){ %>
							4주 전
						<%} else if(dateDiff >= 30 && dateDiff < 60){ %>
							한달 전
						<%} else if(dateDiff >= 365){ %>
							<%=dateDiff/365 %>년 전
						<%} else if(dateDiff >= 30){ %>
							<%=dateDiff/30 %>달 전
						<%} %>
					</span>
					<span id="rev_menu_btn">
						<button type="button" class="btnLike<%=myReviewList.get(i).getRev_num() %>" value="<%=myReviewList.get(i).getRev_num() %>" onclick="return like()">
								<%if(myReviewList.get(i).getListCount() <= 0){ %>
									<img src="<%=request.getContextPath() %>/review/rev_im/rev_empty.png" width="20" height="20">
								<%}else { %>
									<img src="<%=request.getContextPath() %>/review/rev_im/rev_write.png" width="20" height="20">
								<%} %>
							<span class="likeScore<%=myReviewList.get(i).getRev_num()%>">
								<!-- 여기에 좋아요 갯수 뿌리기 -->
								<%=myReviewList.get(i).getRev_like() %>
							</span>
						</button>
					</span>
				</td>
			</tr>
			<%if(myReviewList.get(i).getRev_pic_origin() != null) { %>
			<tr class="reviewPic">
				<td>
					<div>
					<!-- 리뷰 사진 --><img src="<%=request.getContextPath() %>/upload/<%=str %>" data-popup-open="photo_popup<%=myReviewList.get(i).getRev_num() %>"/>
					<!-- 리뷰 글 --><p class="reviewContent"><%=myReviewList.get(i).getRev_content()%></p>
					<!-- 주문 메뉴 --><p class="reviewMenu">주문메뉴 : <%=myReviewList.get(i).getRev_menu()%></p>
					</div>
					<!-- 수정 / 삭제 --><span class="rev_my_btn">
					<input type="button" name="rev_modify" value="수정"  onclick="isWriter(<%=myReviewList.get(i).getRev_num() %>)"/>
					<input type="button" name="rev_delete" value="삭제" onclick="location.href='./ReviewDelete.re?rev_num=<%=myReviewList.get(i).getRev_num() %>'"/>
					</span>
				</td>
			</tr>
			<%} else { %>
			<tr class="reviewText">
				<td>
					<div>
					<!-- 리뷰 글 --><p class="reviewContent"><%=myReviewList.get(i).getRev_content()%></p>
					<!-- 주문 메뉴 --><p class="reviewMenu">주문메뉴 : <%=myReviewList.get(i).getRev_menu()%></p>
					</div>
					<!-- 수정 / 삭제 --><span class="rev_my_btn">
					<input type="button" name="rev_modify" value="수정"  onclick="isWriter(<%=myReviewList.get(i).getRev_num() %>)"/>
					<input type="button" name="rev_delete" value="삭제" onclick="location.href='./ReviewDelete.re?rev_num=<%=myReviewList.get(i).getRev_num() %>'"/>
					</span>
				</td>
			</tr>
			<%} %>
		</table>
		
		<!-- 팝업창에 띄울 이미지 정의 -->
		<div class="popup" data-popup="photo_popup<%=myReviewList.get(i).getRev_num() %>">
		  <div class="popup-inner">
		    <div class="popup-contents">
		    	<img src="<%=request.getContextPath() %>/upload/<%=str %>" class="popup_img" data-popup-close="photo_popup<%=myReviewList.get(i).getRev_num() %>"/>
		    </div>
		  </div>
		</div>
	<%}%>
	</div>
	
</body>
</html>