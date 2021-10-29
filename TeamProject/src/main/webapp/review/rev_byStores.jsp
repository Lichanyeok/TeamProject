<%@page import="vo.ReviewBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	// 전달받은 request 객체로부터 데이터 가져오기
	// "pageInfo" 객체와 "articleList" 객체를 request 객체로부터 꺼내서 저장
	// "pageInfo" 객체로부터 페이지 관련 값들을 꺼내서 변수에 저장
	ArrayList<ReviewBean> articleList = (ArrayList<ReviewBean>)request.getAttribute("articleList");
    ReviewBean reviewData = (ReviewBean)request.getAttribute("reviewData");
    double totalScore = reviewData.getTotalScore() / reviewData.getListCount(); // 가져온 리뷰 점수 평균 작업
	
	%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Review_Test</title>
<script src="./js/jquery-3.6.0.js"></script>
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


/* -------- 리뷰 목록 css -------- */
#rev_name, #rev_date, #store_name {
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
/* 	display: inline-block; */
	float: none;
	
	border: 1px solid;
}

#rev_menu_btn { /* 좋아요 버튼 */
	width: 238px;
	margin: 20px;
/* 	float: right; */
	display: inline-block;
	border: 1px solid;
}

.storeBtn {
	
}
</style>
</head>
<body>
	<div id="wrap">
		<!----------------------- 헤더(hearder) 포함 --------------------->
		<jsp:include page="./Top.jsp"/>
		<!-- 본문 메인 이미지  -->
		<div id="sub_img_center"></div>
		<!-- 본문 좌측 메뉴 -->
		
		
		<!-- 리뷰 게시물 목록 표시 -->
		<%
			for(int i = 0; i < articleList.size(); i++) {
				String str = articleList.get(i).getRev_pic_origin();
				int rev_score = (int)articleList.get(i).getRev_score();
		%>
		<input type="hidden" value="<%=rev_score %>" id="setScore"/>
		
		<div id="rev_contents">
		
				<div id="rev_name">아이디 : <%=articleList.get(i).getRev_name() %></div><div id="rev_date"><%=articleList.get(i).getRev_date() %></div>
				<div id="rev_content">
				<%if(articleList.get(i).getRev_pic_origin() != null) { %><img src="./upload/<%=str %>" width="300" height="300" /><br> <!-- 리뷰 사진 뿌려짐 -->
				<%} %><%=articleList.get(i).getRev_content() %> <!-- 리뷰 내용 뿌려짐 -->
				</div>
				<span id="rev_menu">주문메뉴 : <%=articleList.get(i).getRev_menu() %></span><br>
				<div id="store_name">
				<a href="./ReviewStore.re"><!-- 매장이름 불러오기 -->00국밥집</a>&nbsp;&nbsp; <img src="./review/rev_im/rev_star.png" width="15" height="15" /><%=Math.round(totalScore*10)/10.0 %>(<%=reviewData.getListCount() %>)<br>
				<!-- 매장 연락처 -->051-000-0000<br>
				<!-- 매장주소 -->부산광역시 00구 00동
				</div>
				<span>
				<input type="button" value="좋아요" class="storeBtn" />
				<input type="button" value="저장" class="storeBtn" />
				</span>
				
			<%}%>
		</div>
		<div class="clear"></div>
		<!----------------------- 푸터(Footer) 들어가는 곳 ---------------------->
		
		<!----------------------- 푸터(Footer) 들어가는 곳 ---------------------->
	</div>
</body>
</html>