<%@page import="vo.ReviewBean"%>
<%@page import="vo.SearchBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
SearchBean article = (SearchBean) request.getAttribute("article");
ReviewBean reviewListCount = (ReviewBean) request.getAttribute("reviewListCount");
String store_name = "";
String load_address = "";
String address = "";
String store_number = "";

String category = "";

String logo_img="";

if (article != null) {
	store_name = article.getPlace_name();
	load_address = article.getRoad_address();
	address = article.getJibun_address();
	store_number = article.getTell_number();
	category = article.getCategory();
	logo_img=article.getLogo_img();
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/TeamProject/css/info.css">
<link rel="stylesheet" href="/TeamProject/css/reset.css">
<link rel="stylesheet" href="/TeamProject/css/header.css">
<script src="./js/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(function() {
		$('#go_reserve_btn').on('click', function() {
			// 			alert('ㅎㅇ')
			var sendData = {
				"store_name" : $('#store_name').text(),
				"load_address" : $('#load_address').text(),
				"address" : $('#address').text(),
				"store_number" : $('#store_number').text(),
				"category":$('#category').text()
			};

			$.ajax({
				type : "get",
				data : sendData,
				dataType : "text",
				url : "GoReserve.mz"
			}).done(function(data) {
				location.href = 'Reserve.do';
			}).fail(function() {
				alert('잠시 후에 시도하십시오.')
			});
		});
	});
	
	// 펑션 작업
	function doPost() {
      
      // 동적 form - post 처리
       var form = document.createElement("form");
        form.setAttribute("charset", "UTF-8"); // post 한글처리
        form.setAttribute("method", "post");  // post 방식
        form.setAttribute("action", "ReviewStore.re"); // 요청 보낼 주소

        // 매장명
        doPost = document.createElement("input");
        doPost.setAttribute("type", "hidden");
        doPost.setAttribute("name", "rev_store");
        doPost.setAttribute("value", $('input[name=rev_store]').val());
        form.appendChild(doPost);
        // 매장의 총 리뷰 갯수
        doPost = document.createElement("input");
        doPost.setAttribute("type", "hidden");
        doPost.setAttribute("name", "score_count");
        doPost.setAttribute("value", $('input[name=score_count]').val());
        form.appendChild(doPost);
         // 매장의 평점 평균
        doPost = document.createElement("input");
        doPost.setAttribute("type", "hidden");
        doPost.setAttribute("name", "score_avg");
        doPost.setAttribute("value", $('input[name=score_avg]').val());
        form.appendChild(doPost);
		// 별점 사진용 forStar
        doPost = document.createElement("input");
        doPost.setAttribute("type", "hidden");
        doPost.setAttribute("name", "forStar");
        doPost.setAttribute("value", $('input[name=forStar]').val());
        form.appendChild(doPost);
        
        document.body.appendChild(form);
        form.submit();
   }
</script>
</head>
<body>
	<header>
		<div>
			<jsp:include page="../inc/header.jsp"></jsp:include>
			<hr>
		</div>
	</header>
	<ul>
		<li id="hr"></li>
	</ul>
	<form action="">
		<div id="item">
			<div class="item_detail">
				<div class="item_detail_left">
					<img src="./search/img/<%=category %>/<%=logo_img %>">
				</div>
				<ul id="item_detail_right">
					<li class="item_txt">
						<p>[ Matzip ]</p>
						<div>
							<h2 id="store_name"><%=store_name%></h2>
							<br> <br>
						</div>
					</li>
					<li id="benefit">
						<p>상세 내용</p> <br>
						<ul>
							<li class="list_name">
								<p>별점</p>
								<%
								double star = Math.round(article.getStar_score() * 10) / 10.0;
								int iStar = (int) star;
								double fStar = Math.round((star - iStar) * 10) / 10.0;
								for (int j = 0; j < iStar; j++) {
								%> <img src="./search/img/star.jpg" class="starImg"> 
								<%}
								if(fStar>0){%>
			                	<img src="./search/img/half_star.jpg" class="starImg">
			                <%}%>&nbsp;&nbsp;(<%=star%>)
							</li>
							<li>
								<p>업종</p>
								<p id="category"><%=category%></p>
							</li>
							<li>
								<p>주소</p>
								<p id="load_address"><%=load_address%></p>
							</li>
							<li>
								<p>지번</p>
								<p id="address"><%=address%></p>
							</li>
							<li>
								<p>번호</p>
								<p id="store_number"><%=store_number%></p>
							</li>
							<li><input type="submit" value="리뷰" id="btnReview"></li>
						</ul>
					</li>
					

					<li id="order_item">
						<button type="button">장바구니</button>
						<button type="button" id="go_reserve_btn">예약하기</button>
					</li>
				</ul>
			</div>
		</div>
	</form>
</body>
</html>