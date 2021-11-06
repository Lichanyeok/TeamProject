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
<link rel="stylesheet" href="/TeamProject/css/reset.css">
<link rel="stylesheet" href="/TeamProject/css/header.css">
<script src="./js/jquery-3.6.0.js"></script>
<script type="text/javascript">	
$(document).ready(function() {
	// 첫 화면 뿌리기
	var rev_store = $('input[name=rev_store]').val();
	var rev_name = $('input[name=rev_name]').val(); // 닉네임 전달
	
	// 리뷰 여부 확인 전 이미지 및 글 숨기기
	$('#rev_empty img').attr({'visibility':'hidden'});
	$('#rev_empty span').css({'visibility':'hidden'});
	
	if($('input[name=score_count]').val() != 0) {
		$.ajax({
			type : "GET",
			url : "./ReviewSort.re",
			data : {
				rev_store : rev_store,
				selectedOption : "0",
				isCheckedPic : "false",
				rev_name : rev_name
			},
			success : function(msg) {
				$('#rev_contents').html(msg);
				if(rev_name != "null") {
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
				} else {
					$('#rev_menu_btn button').click(function() {
						alert('로그인 후 이용해주세요!');
					});
				}
			} // ajax success 끝
		});
	} else {
		// 리뷰가 없으므로 이미지와 글 표시
		$('#rev_empty img').css({'visibility':'visible'});
		$('#rev_empty span').css({'visibility':'visible'});
		$('#rev_empty img').attr({src:"./review/rev_im/rev_empty.png"});
		$('#rev_empty span').html('&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;작성된 리뷰가 없습니다.');
	} // 첫 화면 불러오는 ajax 끝

	if($('input[name=score_count]').val() != 0) {
		// 리뷰 정렬 방식을 선택하는 ajax 정의
		$('#select').change(function() {
			var isCheckedPic = $('#isRev_pic').prop("checked");
			$.ajax({
				type: "GET",
				url: "./ReviewSort.re?rev_store=" + rev_store,
				data : {
					selectedOption : this.value,
					isCheckedPic : isCheckedPic,
					rev_name : rev_name
				},
				success : function(msg){ //DB접근 후 가져온 데이터
					$('#rev_contents').html(msg); // 초기화 후 정렬 방식에 따라 리뷰 새로 뿌리기
					if(rev_name != "null") {
						// 좋아요 갯수 증가를 위한 ajax 정의
						$('#rev_menu_btn button').click(function() {
							var rev_num = $(this).val();
							
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
					} else {
						$('#rev_menu_btn button').click(function() {
							alert('로그인 후 이용해주세요!');
						});
					}
				}
			});
		});	
	} else {
		// 리뷰가 없으므로 이미지와 글 표시
		$('#rev_empty img').css({'visibility':'visible'});
		$('#rev_empty span').css({'visibility':'visible'});
		$('#rev_empty img').attr({src:"./review/rev_im/rev_empty.png"});
		$('#rev_empty span').html('&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;작성된 리뷰가 없습니다.');
	} // 리뷰 정렬 방식을 선택하는 ajax 끝
	
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
	<input type="hidden" name="score_count" value="<%=Integer.parseInt(request.getParameter("score_count")) %>" />
	<input type="hidden" name="rev_name" value="<%=session.getAttribute("sNn") %>" />
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
					<td rowspan="2" id="rev_score" ><%=totalScore%></td>
					<td>
						<%if(!forStar.equals(null)) { %>
						<img src="./review/rev_im/<%=forStar%>star.png" width="100" height="20" />
						<%} else { %>
						<img src="./review/rev_im/0star.png" width="100" height="20" />
						<%} %>
					</td>
				</tr>
				<tr>
					<td><h3 id="countReview">리뷰 <%=Integer.parseInt(request.getParameter("score_count"))%>개</h3></td>
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
		
<!-- 		리뷰 게시물 목록 표시 -->
		<div id="rev_contents">
			<div id="rev_empty">
				<img src="" width="500" height="500"><br>
				<span></span>
			</div>
		</div>
		<div class="clear"></div>
		<!----------------------- 푸터(Footer) 들어가는 곳 ---------------------->
		
		<!----------------------- 푸터(Footer) 들어가는 곳 ---------------------->
	</div>
</body>
</html>