<%@page import="vo.ReviewBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    String totalScore = request.getParameter("score_avg");
    String forStar = request.getParameter("forStar");
	%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Review_Test</title>
<script src="./js/jquery-3.6.0.js"></script>
<script type="text/javascript">	
	$(document).ready(function() {
		
		// 첫 화면 뿌리기
		var rev_store = $('input[name=rev_store]').val();
		$.ajax({
			type : "GET",
			url : "./ReviewSort.re?rev_store=" + rev_store,
			data : {
				selectedOption : "0",
				isCheckedPic : "false"
			},
			success : function(msg) {
				$('#rev_contents').html(msg);
			}
		});

		
		// 선택된 옵션 값에 따라 정렬방식 변경
		$('#select').change(function() {
			var isCheckedPic = $('#isRev_pic').prop("checked");
			$.ajax({
				type: "GET",
				url: "./ReviewSort.re?rev_store=" + rev_store,
				data : {
					selectedOption : this.value,
					isCheckedPic : isCheckedPic
				},
				success : function(msg){ //DB접근 후 가져온 데이터
					$('#rev_contents').html(msg); // 초기화 후 정렬 방식에 따라 리뷰 새로 뿌리기
				}
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
		
		// 좋아요 갯수 증가를 위한 ajax 정의
		$('#rev_menu_btn button').on('click', function() {
			alert($(this).find('span').text());
			var a = this.value; // 해당 리뷰 번호
			var b = $('input[name=likeScore]').val(); // 해당 리뷰의 좋아요 수
			
			$.ajax({
				type: "GET",
				url: "./ReviewLikeScore.re",
				data : {
					rev_num : a,
					prev_like : b
				}
			}).done(function(msg){ //DB접근 후 가져온 데이터
				if(b == c) {
					$('.rev_like_btn' + a).find('span').html(msg);
				} else {
					$('.rev_like_btn' + a).find('span').html(c);
				}
// 				alert('성공');
			}).fail(function() {
				alert("한번만 가능합니다.");
			});
		});
		
	}); // 제이쿼리 끝
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
	<!-- 매장명을 저장할  -->
	<input type="hidden" name="rev_store" value="<%=request.getParameter("rev_store") %>" />
	<div id="wrap">
		<!-- inc 폴더 내의 top.jsp 페이지를 현재 위치에 포함시키기 -->
		<jsp:include page="../inc/header.jsp"></jsp:include>
		<!-- 본문 메인 이미지  -->
		<div id="sub_img_center"></div>
		<!-- 본문 좌측 메뉴 -->
		<nav id="sub_menu">
			<table>
				<tr>
					<th id="rev_store" colspan="2"><%=request.getParameter("rev_store")%></th>
				</tr>
				<tr>
					<td rowspan="2" id="rev_score" ><%=totalScore %></td>
					<td>
						<%if(!forStar.equals(null)) {  %>
						<img src="./review/rev_im/<%=forStar %>star.png" width="100" height="20" />
						<%} else { %>
						<img src="./review/rev_im/0star.png" width="100" height="20" />
						<%} %>
					</td>
				</tr>
				<tr>
					<td><h3>리뷰 <%=Integer.parseInt(request.getParameter("score_count")) %>개</h3></td>
				</tr>
				
				<tr>
					<td>
						<input type="checkbox" id="isRev_pic" /> 포토리뷰
					</td>
				</tr>
				<tr>
					<td>
						<select id="select" >
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
			<div id="rev_empty">
				<img src="./review/rev_im/rev_empty.png" width="500" height="500" ><br>
				<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;작성된 리뷰가 없습니다.</span>
			</div>
		</div>
		<div class="clear"></div>
		<!----------------------- 푸터(Footer) 들어가는 곳 ---------------------->
		
		<!----------------------- 푸터(Footer) 들어가는 곳 ---------------------->
	</div>
</body>
</html>