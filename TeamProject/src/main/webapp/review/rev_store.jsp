<%@page import="vo.ReviewBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
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
<link rel="stylesheet" href="/TeamProject/css/rev_store.css">
<link rel="stylesheet" href="/TeamProject/css/reset.css">
<link rel="stylesheet" href="/TeamProject/css/header.css">
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
				//이미지 팝업창
				$(function() {
				    //----- OPEN
				    $('.reviewPic img').on('click', function(e)  {
				        var targeted_popup_class = $(this).attr('data-popup-open');
				        $('[data-popup="' + targeted_popup_class + '"]').fadeIn(350);

				        e.preventDefault();
				    });

				    //----- CLOSE
				    $('.popup img').on('click', function(e)  { // 사진 클릭 시 종료
				        var targeted_popup_class = $(this).attr('data-popup-close');
				        $('[data-popup="' + targeted_popup_class + '"]').fadeOut(350);

				        e.preventDefault();
				    });
				    $('.popup').on('click', function(e)  { // 사진 요소 밖 클릭 시 종료
				        var targeted_popup_class = $('.popup img').attr('data-popup-close');
				        $('[data-popup="' + targeted_popup_class + '"]').fadeOut(350);

				        e.preventDefault();
				    });
				}); // 이미지 팝업창 끝
				
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
		$('.select li').on('click', function() {
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
					
					//이미지 팝업창
					$(function() {
					    //----- OPEN
				    	$('.reviewPic img').on('click', function(e)  {
					    	
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
					}); // 이미지 팝업창 끝
					
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
	
	// 셀렉트 영역 리스너 출처 : https://daisy-mansion.tistory.com/94
	const body = document.querySelector('body');
	const select = document.querySelector(`[data-role="selectBox"]`);
	const values = select.querySelector(`[date-value="optValue"]`);
	const option = select.querySelector('ul');
	const opts = option.querySelectorAll('li');

	/* 셀렉트영역 클릭 시 옵션 숨기기, 보이기 */
	function selects(e){
	    e.stopPropagation();
	    option.setAttribute('style',`top:${select.offsetHeight}px`)
	    if(option.classList.contains('hide')){
	        option.classList.remove('hide');
	        option.classList.add('show');
	    }else{
	        option.classList.add('hide');
	        option.classList.remove('show');
	    }
	    selectOpt();
	}

	/* 옵션선택 */
	function selectOpt(){
	    opts.forEach(opt=>{
	        const innerValue = opt.innerHTML;
	        function changeValue(){
	            values.innerHTML = innerValue;
	        }
	        opt.addEventListener('click',changeValue)
	    });
	}

	/* 렌더링 시 옵션의 첫번째 항목 기본 선택 */
	function selectFirst(){
	    const firstValue = opts[0].innerHTML;
	    values.innerHTML = firstValue;
	}

	/* 옵션밖의 영역(=바디) 클릭 시 옵션 숨김 */
	function hideSelect(){
	    if(option.classList.contains('show')){
	        option.classList.add('hide');
	        option.classList.remove('show');
	    }
	}

	selectFirst();
	select.addEventListener('click',selects);
	body.addEventListener('click',hideSelect);
	
}); // 제이쿼리 끝
</script>
</head>
<body>
	<!-- 매장명을 저장할  -->
	<input type="hidden" name="rev_store" value="<%=request.getParameter("rev_store") %>" />
	<input type="hidden" name="score_count" value="<%=Integer.parseInt(request.getParameter("score_count")) %>" />
	<input type="hidden" name="rev_name" value="<%=session.getAttribute("sNn") %>" />
	
		<!-- inc 폴더 내의 top.jsp 페이지를 현재 위치에 포함시키기 -->
		<jsp:include page="../inc/header.jsp"></jsp:include>
		<!-- 본문 메인 이미지  -->
		<div class="header"></div>
		<!-- 본문 좌측 메뉴 -->
	<div class="review_container">
		<div class="nav"> <!-- nav 끝 -->
		<div class="item_detail_left"></div>
			<ul id="rev_store_left">
				<li class="store_name">
					<p>[ Matzip ]</p>
					 <div>
						<h2><%=request.getParameter("rev_store")%></h2>
						<br><br>
					</div>
				</li>   
				<li id="benefit">  
					<ul>
					<li class="star_score">
						<p>
							<img src="./review/rev_im/rev_star.png" width="30" height="30" />
							<!-- 별점 표시 --><%=totalScore%>
						</p>
					</li>
					<li class="count_score">
						<p>리뷰 <%=Integer.parseInt(request.getParameter("score_count"))%>개</p>
					</li>
					<li id="hr"></li>
					<li>
						<div class="ccheck">
							<input type="checkbox" id="isRev_pic" />
							<label for="isRev_pic">
<!-- 								<img src="/TeamProject/review/rev_im/box_test.png" /> -->
								포토리뷰
							</label>
						</div>
						<div class="select" data-role="selectBox">
						  <span date-value="optValue" class="selected-option"><!-- 선택된 옵션 값이 출력되는 부분 --></span>
						  <!-- 옵션 영역 -->
						  <ul class="hide">
						    <li value="0">
						    	최신순
						    </li>
						    <li value="1">
						    	리뷰 도움순
						    </li>
						    <li value="2">
						    	별점 높은 순
						    </li>
						    <li value="3">
						    	별점 낮은 순
						    </li>
						  </ul>
						</div>
					</li>
					<li id="hr"></li>
					</ul>
				</li>
			</ul>
		</div>
		<div class="store_gap"></div>
<!-- 		리뷰 게시물 목록 표시 -->
		<div class="rev_store_center">
		<div id="rev_contents">
			<div id="rev_empty">
				<img src="" ><br>
				<span></span>
			</div>
		</div>
		</div>
	</div> <!-- review_container 끝 -->
</body>
</html>