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
		$('#rev_menu_btn button').on('click', function() {
// 			alert($(this).find('span').text());
			a = this.value;
			$.ajax({
				type: "GET",
				url: "./ReviewLikeScore.re",
				dataType: "TEXT",
				data : {
					rev_num : this.value,
					prev_like : $(this).find('span').text()
				}
			}).done(function(msg){ //DB접근 후 가져온 데이터
				$('.rev_like_btn' + a).find('span').html(msg);
// 				alert('성공');
			}).fail(function() {
				alert("한번만 가능합니다.");
			});
			
		});
		
		// 마우스 오버 시 빈 리뷰 이미지를 채워진 이미지로 변경 / 클릭 시 리뷰 작성 페이지로 이동		
		$('#rev_empty img').hover(
			function() {
				$(this).attr({src:"./review/rev_im/rev_write.png"});
				$('#rev_empty span').html('&nbsp;&nbsp;예약하러 가기(이미지 클릭)');
			},
			function() {
				$(this).attr({src:"./review/rev_im/rev_empty.png"});
				$('#rev_empty span').html('&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;작성된 리뷰가 없습니다.');
			}
		);
		$('#rev_empty img').on('click', function() {
			$(location).attr('href','javascript:history.back()');
		});
		
		
			 
	});
</script>
<style type="text/css">
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
#rev_name, #rev_date {
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
#rev_empty > span  {
text-align: center;
font-style: bold;
font-size: 2em;
}
</style>
</head>
<body>
	<div id="wrap">
		<!-- inc 폴더 내의 top.jsp 페이지를 현재 위치에 포함시키기 -->
		<jsp:include page="../inc/header.jsp"></jsp:include>
		<!-- 본문 메인 이미지  -->
		<div id="sub_img_center"></div>
		<!-- 본문 좌측 메뉴 -->
		<input type="hidden" value="<%=Math.round(totalScore) %>" name="rev_score"/>
		
		<nav id="sub_menu">
			<table>
				<tr>
					<th id="rev_store" colspan="2">&nbsp;<%=request.getParameter("rev_store")%></th>
				</tr>
				<tr>
					<td rowspan="2" id="rev_score" ><%=Math.round(totalScore*10)/10.0 %></td>
					<td>
						<%if(totalScore != 0) {  %>
						<img src="./review/rev_im/<%=(int)(Math.round(totalScore*10)/10.0) %>star.png" width="100" height="20" />
						<%} else { %>
						<img src="./review/rev_im/0star.png" width="100" height="20" />
						<%} %>
					</td>
				</tr>
				<tr>
					<td><h3>리뷰 <%=reviewData.getListCount() %>개</h3></td>
				</tr>
				<tr>
					<td>
						<input type="checkbox" id="isRev_pic" /> 포토리뷰
					</td>
				</tr>
				<tr>
					<td>
						<select id="select">
							<option disabled="disabled">리뷰 정렬</option>
							<option value="0">최신순</option>
							<option value="1">리뷰 도움순</option>
							<option value="2">별점 높은 순</option>
							<option value="3">별점 낮은 순</option>
						</select>
					</td>
				</tr>
			</table>
		</nav>
		
		<!-- 리뷰 게시물 목록 표시 -->
		<div id="rev_contents">
		<%if(articleList.size() != 0) { %>
		<%
			for(int i = 0; i < articleList.size(); i++) {
				String str = articleList.get(i).getRev_pic_origin();
				int rev_score = (int)articleList.get(i).getRev_score();
		%>
				<input type="hidden" value="<%=rev_score %>" id="setScore"/>
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
				</div>
				<div id="rev_menu_btn">
					<button type="button" class="rev_like_btn<%=articleList.get(i).getRev_num() %>" value="<%=articleList.get(i).getRev_num() %>">
						<img src="<%=request.getContextPath() %>/review/rev_im/reviewGood.png" width="15" height="15">&nbsp;&nbsp;
						<span class="likeScore" >
							<!-- 여기에 좋아요 갯수 뿌리기 -->
							<%=articleList.get(i).getRev_like() %>
						</span>
					</button>
				</div><br>
			<%}%>
			
		
	<%} else { %>
	<div id="rev_empty">
		<img src="./review/rev_im/rev_empty.png" width="500" height="500" ><br>
		<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;작성된 리뷰가 없습니다.</span>
		</div>
	<%} %>
	</div>
		<div class="clear"></div>
		<!----------------------- 푸터(Footer) 들어가는 곳 ---------------------->
		
		<!----------------------- 푸터(Footer) 들어가는 곳 ---------------------->
	</div>
</body>
</html>