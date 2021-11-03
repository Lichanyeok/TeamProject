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
<link rel="stylesheet" href="/TeamProject/css/matzip_search.css">

<script src="../js/jquery-3.6.0.js"></script>
<!-- <script src="../js/matzip_search.js"></script> -->
<script type="text/javascript">
$(document).ready(function(){
	
	var category="";
	if(category==""){
		$.ajax({
			type : "GET",
			url : "./MatzipList.mz?category=실험",
			success : function(msg) {
				$("#category_list").html(msg);	
			}			
		});
	}
	
	$("#cy_1").on("click", function() {
		category=$("#cy_1").text();		
		$.ajax({
			type : "GET",
			url : "./MatzipList.mz?category="+category,
			success : function(msg) {
				$("#category_list").html(msg);	
			}			
		}).fail(function() {
			alert('실패!');
		});
		
	});
	
	$("#cy_2").on("click", function() {
         category=$("#cy_2").text();
         $.ajax({
            type : "GET",
            url : "./MatzipList.mz?category="+category,
            success : function(msg) {
               $("#category_list").html(msg);   
            }         
         }).fail(function() {
            alert('실패!');
         });
         
      });
$("#cy_3").on("click", function() {
         category=$("#cy_3").text();
         $.ajax({
            type : "GET",
            url : "./MatzipList.mz?category="+category,
            success : function(msg) {
               $("#category_list").html(msg);   
            }         
         }).fail(function() {
            alert('실패!');
         });
         
      });
$("#cy_4").on("click", function() {
         category=$("#cy_4").text();
         $.ajax({
            type : "GET",
            url : "./MatzipList.mz?category="+category,
            success : function(msg) {
               $("#category_list").html(msg);   
            }         
         }).fail(function() {
            alert('실패!');
         });
         
      });
$("#cy_5").on("click", function() {
         category=$("#cy_5").text();
         $.ajax({
            type : "GET",
            url : "./MatzipList.mz?category="+category,
            success : function(msg) {
               $("#category_list").html(msg);   
            }         
         }).fail(function() {
            alert('실패!');
         });
         
      });
$("#cy_6").on("click", function() {
         category=$("#cy_6").text();
         $.ajax({
            type : "GET",
            url : "./MatzipList.mz?category="+category,
            success : function(msg) {
               $("#category_list").html(msg);   
            }         
         }).fail(function() {
            alert('실패!');
         });
        
      });
$("#cy_7").on("click", function() {
         category=$("#cy_7").text();
         $.ajax({
            type : "GET",
            url : "./MatzipList.mz?category="+category,
            success : function(msg) {
               $("#category_list").html(msg);   
            }         
         }).fail(function() {
            alert('실패!');
         });
         
      });
$("#cy_8").on("click", function() {
         category=$("#cy_8").text();
         $.ajax({
            type : "GET",
            url : "./MatzipList.mz?category="+category,
            success : function(msg) {
               $("#category_list").html(msg);   
            }         
         }).fail(function() {
            alert('실패!');
         });
         
      });
$("#cy_9").on("click", function() {
         category=$("#cy_9").text();
         $.ajax({
            type : "GET",
            url : "./MatzipList.mz?category="+category,
            success : function(msg) {
               $("#category_list").html(msg);   
            }         
         }).fail(function() {
            alert('실패!');
         });
         
      });
$("#cy_10").on("click", function() {
         category=$("#cy_10").text();
         $.ajax({
            type : "GET",
            url : "./MatzipList.mz?category="+category,
            success : function(msg) {
               $("#category_list").html(msg);   
            }         
         }).fail(function() {
            alert('실패!');
         });
         
      });
$("#cy_11").on("click", function() {
         category=$("#cy_11").text();
         $.ajax({
            type : "GET",
            url : "./MatzipList.mz?category="+category,
            success : function(msg) {
               $("#category_list").html(msg);   
            }         
         }).fail(function() {
            alert('실패!');
         });
         
      });
$("#cy_12").on("click", function() {
         category=$("#cy_12").text();
         $.ajax({
            type : "GET",
            url : "./MatzipList.mz?category="+category,
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
	</div>
</body>
</html>




