<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/TeamProject/css/reset.css">
<link rel="stylesheet" href="/TeamProject/css/header.css">
<!-- <link rel="stylesheet" href="/TeamProject/css/matzip_search.css"> -->
<style type="text/css">

body {
	min-width: 1080px;
	margin: 0 auto;
}

.div_clear{
	clear: both;
}

#wrap_search{
/* 	border: 1px solid red; */
	width: auto;
	margin: 0 auto;
}

#category_wrap {
	border: 2px solid #FF8831;
	border-radius:5px;
	margin: 0 auto;
	width: 1080px;
	height: auto;
	vertical-align: middle;
	margin-top: 10px;
}
#category_title{
	
	width: 400px;
	height: 40px;
	margin: 8px 0 8px 10px;
	font-size: 30px;
	color: #FF5531;
	padding-top: 5px;
	float: left;
}
#category_text{
  	
	width: 290px;
	height: 15px;
	margin-top: 40px;
	color: #FF5531;
	float: right;
}
#category_list {	
	margin: auto;	
	width: 1080px;
	height: auto;
}

#category_menu {
	text-align: center;	
}

#category_menu_ul>li{	
	float: left;	
	width: 90px;
	height: 30px;		
	color: #ffffff;	
	background: #FF8831;
	padding-top: 10px;
}
#category_menu_ul>li:hover {
	background: #FF6631;
}

</style>
<script src="./js/jquery-3.6.0.js"></script>
<!-- <script src="../js/matzip_search.js"></script> -->
<script type="text/javascript">
$(document).ready(function(){
	
	var category="";
	var id="";
	if(category==""){
		$.ajax({
			type : "GET",
			url : "MatzipList.mz?category=실험",
			success : function(msg) {
				$("#category_list").html(msg);	
			}			
		});
	}
	
	$("li").on("click", function() {
		if(category != ""){
			$("li[value="+category+"]").css("background","#FF8831");			
		}
		
		category=$(this).text();		
		$(this).css('background','#FF6631');
		
		$.ajax({
			type : "GET",
			url : "MatzipList.mz?category="+category,
			success : function(msg) {
				$("#category_list").html(msg);	
			}			
		}).fail(function() {
			alert('실패!');
		});
		
	});


	$(".item").on("click",function(){			
		var tell_number = $(".tel",this).text();
		var road_address= $(".road",this).text();
		location.href="MatzipInfo.mz?road_address="+road_address
				+"&tell_number="+tell_number;
	});

		
});

</script>
</head>
<body>
	<div id="wrap_search">
		<!-- 상위 고정 -->
	    <jsp:include page="../inc/header.jsp"></jsp:include>
	    <!-- 상위 고정 -->
	    <hr>	   
	    <div class="div_clear"></div>
	  	<jsp:include page="../inc/search.jsp"/>
	    <div class="div_clear"></div>
	    
	    <div id="category_wrap">
	    <div id="category_title">MATZIP TOP 10</div>
	    <div id="category_text">*이미지 클릭시 상세보기 페이지로 이동</div>
	    <div class="div_clear"></div>
	    <nav id="category_menu">
			<ul id="category_menu_ul">
				<li value="한식">한식</li>
				<li value="양식">양식</li>
				<li value="중식">중식</li>
				<li value="일식">일식</li>
				<li value="치킨">치킨</li>
				<li value="피자">피자</li>
				<li value="퓨전">퓨전</li>
				<li value="찜요리">찜요리</li>
				<li value="고깃집">고깃집</li>
				<li value="족발">족발</li>
				<li value="뷔페">뷔페</li>
				<li value="코스요리">코스요리</li>				
			</ul>
		</nav>
		<div class="div_clear"></div>
	    <div id="category_list">
	    </div>
	    <div class="div_clear"></div>	    
	    </div>
	    <br>
	</div>
</body>
</html>




