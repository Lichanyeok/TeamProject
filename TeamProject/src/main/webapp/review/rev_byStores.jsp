<%@page import="vo.ReviewBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	ArrayList<ReviewBean> articleList = (ArrayList<ReviewBean>)request.getAttribute("articleList"); // 매장 별 리뷰 정보
	%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Review_Test</title>
<script src="./js/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="/TeamProject/css/reset.css">
<link rel="stylesheet" href="/TeamProject/css/header.css">
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
		<jsp:include page="Top.jsp"/>
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
		
				<div id="rev_name">
					닉네임 : <%=articleList.get(i).getRev_name() %>
				</div>
				<div id="rev_date">
					<%=articleList.get(i).getRev_date() %>
				</div>
				<div id="rev_subject">
					<img src="./review/rev_im/<%=rev_score %>star.png" width="100" height="20" />
				</div>
				<div id="rev_content">
					<%if(articleList.get(i).getRev_pic_origin() != null) { %>
					<img src="./upload/<%=str %>" width="300" height="300" /><br>
					<%} %><%=articleList.get(i).getRev_content() %>
				</div>
				<div id="rev_menu">
					주문메뉴 : <%=articleList.get(i).getRev_menu() %>
				</div><br>
				<div id="store_name">
					<a href="./ReviewStore.re">
						<!-- 매장이름 불러오기 -->
<%-- 						<%=articleList.get(i).getRev_store() %> --%>
					<%=articleList.get(i).getRev_store() %>
					</a>&nbsp;&nbsp;
					<img src="./review/rev_im/rev_star.png" width="15" height="15" />
					<%=articleList.get(i).getRev_score() %>(<%=articleList.get(i).getListCount() %>)<br>
					<!-- 매장주소 -->
					부산광역시 00구 00동<br>
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