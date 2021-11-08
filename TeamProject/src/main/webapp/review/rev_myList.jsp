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
<link rel="stylesheet" href="./css/reset.css">
<link rel="stylesheet" href="./css/header.css">
<script type="text/javascript">	
	$(document).ready(function() {
		
		// 이전 리뷰 작성 시 체크했던 별점 불러오기.
		$('input[name=rev_score]').each(function() {
			if($(this).val() != 0) {
				$('#' + $(this).val() + '-stars').attr('checked', true);
				$('#img_score').css({visibility: "visible"});
				$('#div1 img').attr({src:"./review/rev_im/" + $(this).val() + ".png"});
			}
		});
		
		// 스토어 별점 버튼 기능 없애기 (눌렀을때 변경 못하게 설정)
		$('input[name=rating]').click(false);
		
		// 선택된 옵션 값에 따라 정렬방식 변경
		$('#select').change(function() {
			var isCheckedPic = $('#isRev_pic').prop("checked"); // 추가
			$.ajax({
				type: "GET",
				url: "./ReviewSort.re",
				data : {
					selectedOption : this.value,
					isCheckedPic : isCheckedPic // 추가
				},
				success : function(msg){ //DB접근 후 가져온 데이터
					$('#rev_contents').html(''); // 기존에 뿌려진 리뷰 초기화
					$('#rev_contents').html(msg); // 초기화 후 정렬 방식에 따라 리뷰 새로 뿌리기
				}
			});
		});
		
		// 좋아요 갯수 증가를 위한 ajax 정의
		$('#rev_like_btn').on('click', function() {
			$.ajax({
				type: "GET",
				url: "./ReviewLikeScore.re",
				data : {
					rev_num : $('#rev_like_btn').val(),
					prev_like : $('#likeScore').text()
				},
				success : function(msg){ //DB접근 후 가져온 데이터
					$('#likeScore').html(msg);
				}
			});
			
		});
		
	});
</script>
<style type="text/css">
/* ---------- 별 모양 css -------------------- */

.star-rating {
  display: flex;
  flex-direction: row-reverse;
  font-size: 1.25rem;
  line-height: 1.5rem;
  justify-content: space-around;
  padding: 0 0.2em;
  text-align: center;
  width: 5em;
  margin: auto;
}
 
.star-rating input {
  display: none;
}
 
.star-rating label {
  -webkit-text-fill-color: transparent; /* Will override color (regardless of order) */
  -webkit-text-stroke-width: 2.3px;
  -webkit-text-stroke-color: #2b2a29;
  cursor: pointer;
}
 
.star-rating :checked ~ label {
  -webkit-text-fill-color: gold;
}
 
.star-rating space-x-4 mx-auto {
text-align: center;

}

#rev_store {
	text-align: center;
	font-size: 3em;
	padding: 0.5em;
}

#rev_score {
	text-align: center;
	font-size: 3em;
}

#rev_contents {
	float: right;
	width: 1000px;
}

/* -------- 리뷰 목록 css -------- */
#rev_name, #rev_subject, #rev_date {
	width: 200px;
	display: inline-block;
	margin: 20px;
	border: 1px solid;
}

#rev_content {
	width: 680px;
	height: 400px;
	margin: 20px;
	border: 1px solid;
}

#rev_menu {
	width: 238px;
	margin: 20px;
	display: inline-block;
	border: 1px solid;
}

#rev_menu_btn {
	width: 238px;
	margin: 20px;
/* 	float: right; */
	display: inline-block;
	border: 1px solid;
}

#sub_menu {
	font-size: 30px;
	text-align: center;
}
</style>
</head>
<body>
	<!-- 상위 고정 -->
   	<jsp:include page="../inc/header.jsp"></jsp:include>
   	<!-- 상위 고정 -->
	<div id="wrap">
		<!-- 본문 메인 이미지  -->
		<div id="sub_img_center"></div>
		<!-- 본문 좌측 메뉴 -->
		
		<nav id="sub_menu">
			<h3>내가 쓴 총 리뷰 <%=myListCount.getListCount() %>개</h3>	
		</nav>
		
		<!-- 리뷰 게시물 목록 표시 -->
		<%
			for(int i = 0; i < myReviewList.size(); i++) {
				String str = myReviewList.get(i).getRev_pic_origin();
				int rev_score = (int)myReviewList.get(i).getRev_score();
		%>
		
		<div id="rev_contents">
		
				<div id="rev_name">
					<a href="#"><%=myReviewList.get(i).getRev_store() %></a><br>
					<img src="./review/rev_im/<%=rev_score %>star.png" width="100" height="20" />&nbsp;&nbsp;<small><%=myReviewList.get(i).getRev_date() %></small>
				</div>
				<div id="rev_menu_btn" align="right">
					<input type="button" name="rev_modify" value="수정" onclick="location.href='./ReviewModify.re?rev_num=<%=myReviewList.get(i).getRev_num() %>'"/>&nbsp;
					<input type="button" name="rev_delete" value="삭제" onclick="location.href='./ReviewDelete.re?rev_num=<%=myReviewList.get(i).getRev_num() %>'"/>
				</div>
				<div id="rev_content"><%if(myReviewList.get(i).getRev_pic_origin() != null) { %><img src="./upload/<%=str %>" width="300" height="300" /><br><%} %><%=myReviewList.get(i).getRev_content() %></div>
				<div id="rev_menu">주문메뉴 : <%=myReviewList.get(i).getRev_menu() %></div>
			<%}%>
		</div>
		<div class="clear"></div>
		<!----------------------- 푸터(Footer) 들어가는 곳 ---------------------->
		
		<!----------------------- 푸터(Footer) 들어가는 곳 ---------------------->
	</div>
</body>
</html>