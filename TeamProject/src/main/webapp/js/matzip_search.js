$(document).ready(function(){
		
		$("#searchBtn").on("click", function(){
			$("#keyword").val($("#searchInfo").val());
			$("#")

		});
	
		var category="";
		if(category==""){
			$.ajax({
				type : "GET",
				url : "./MatzipList.mz?category="+category,
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
	            url : "../MatzipList.mz?category="+category,
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