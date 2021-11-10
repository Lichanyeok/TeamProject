<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.ReserveBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/reset.css">
<link rel="stylesheet" href="./css/header.css">
<link rel="stylesheet" href="./css/reservation_list2.css">
<script src="./js/jquery-3.6.0.js"></script>
<%
	
%>
<script type="text/javascript">
		 var date = new Date();
	 	 var yyyy = date.getFullYear();
	 	 var mm = date.getMonth()+1 > 9 ? date.getMonth()+1 : '0' + date.getMonth()+1;
		 var dd = date.getDate() > 9 ? date.getDate() : '0' + date.getDate();
		 var today = yyyy+"-"+mm+"-"+dd;
	 	alert("aaa");	 	
 	$(document).ready(function(){
		 $.ajax({
	         type : "GET",
	         url : "ReservationList.mz?store_name=<%=request.getParameter("store_name")%>&reserve_date="+today,
	         success : function(msg) {
	            $("#reservation_list").html(msg);
	         }
	      });
		
		 $("#reserve_date").on("change",function(){
	         $.ajax({
	            type : "GET",
	            url : "ReservationList.mz?store_name=<%=request.getParameter("store_name")%>&reserve_date="+$("#reserve_date").val(),
	            success : function(msg) {
	               $("#reservation_list").html(msg);
	            }
	         }).fail(function() {
	            alert('실패!');
	         });
		 });
	
	});
</script>

</head>
<body>
	<jsp:include page="../inc/header.jsp"></jsp:include>
	<hr>
	<div id="wrap">
		<p id="reservation_header">예약 리스트</p>
		<input type="date" id="reserve_date">
		<br><br>
		<div class="clear"></div>
		<div id="reservation_list">
		</div>	
	</div>
</body>
</html>
















