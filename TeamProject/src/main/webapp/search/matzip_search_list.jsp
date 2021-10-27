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
	width: 500px;
	height: 40px;
	margin: 8px 0 8px 10px;
	font-size: 30px;
	color: #FF5531;
	padding-top: 5px;
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
	
	$("#cy_1").on("click", function() {
		if(id != ""){
			$(id).css("background","#FF8831");			
		}
		id="#cy_1";
		category=$("#cy_1").text();		
		$("#cy_1").css('background','#FF6631');
		
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
	
	$("#cy_2").on("click", function() {
		if(id != ""){
			$(id).css("background","#FF8831");			
		}
		id="#cy_2";
        category=$("#cy_2").text();
		$("#cy_2").css('background','#FF6631')
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
$("#cy_3").on("click", function() {
	if(id != ""){
		$(id).css("background","#FF8831");			
	}
	id="#cy_3";
         category=$("#cy_3").text();
	$("#cy_3").css('background','#FF6631')
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
$("#cy_4").on("click", function() {
	if(id != ""){
		$(id).css("background","#FF8831");			
	}
	id="#cy_4";
         category=$("#cy_4").text();
	$("#cy_4").css('background','#FF6631')
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
$("#cy_5").on("click", function() {
	if(id != ""){
		$(id).css("background","#FF8831");			
	}
	id="#cy_5";
         category=$("#cy_5").text();
	$("#cy_5").css('background','#FF6631')
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
$("#cy_6").on("click", function() {
	if(id != ""){
		$(id).css("background","#FF8831");			
	}
	id="#cy_6";
         category=$("#cy_6").text();
	$("#cy_6").css('background','#FF6631')
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
$("#cy_7").on("click", function() {
	if(id != ""){
		$(id).css("background","#FF8831");			
	}
	id="#cy_7";
         category=$("#cy_7").text();
	$("#cy_7").css('background','#FF6631')
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
$("#cy_8").on("click", function() {
	if(id != ""){
		$(id).css("background","#FF8831");			
	}
	id="#cy_8";
         category=$("#cy_8").text();
	$("#cy_8").css('background','#FF6631')
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
$("#cy_9").on("click", function() {
	if(id != ""){
		$(id).css("background","#FF8831");			
	}
	id="#cy_9";
         category=$("#cy_9").text();
	$("#cy_9").css('background','#FF6631')
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
$("#cy_10").on("click", function() {
	if(id != ""){
		$(id).css("background","#FF8831");			
	}
	id="#cy_10";
         category=$("#cy_10").text();
	$("#cy_10").css('background','#FF6631')
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
$("#cy_11").on("click", function() {
	if(id != ""){
		$(id).css("background","#FF8831");			
	}
	id="#cy_11";
         category=$("#cy_11").text();
	$("#cy_11").css('background','#FF6631')
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
$("#cy_12").on("click", function() {
	if(id != ""){
		$(id).css("background","#FF8831");			
	}
	id="#cy_12";
         category=$("#cy_12").text();
	$("#cy_12").css('background','#FF6631')
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
	    <nav id="category_menu">
			<ul id="category_menu_ul">
				<li id="cy_1">한식</li>
				<li id="cy_2">양식</li>
				<li id="cy_3">중식</li>
				<li id="cy_4">일식</li>
				<li id="cy_5">치킨</li>
				<li id="cy_6">피자</li>
				<li id="cy_7">퓨전</li>
				<li id="cy_8">찜&탕</li>
				<li id="cy_9">고깃집</li>
				<li id="cy_10">족발</li>
				<li id="cy_11">뷔페</li>
				<li id="cy_12">코스요리</li>				
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




