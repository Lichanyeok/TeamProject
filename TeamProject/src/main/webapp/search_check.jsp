<%@page import="vo.SearchBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
SearchBean article = (SearchBean)request.getAttribute("article");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/TeamProject/css/check.css">
</head>
<body>

	<section id="sec01">
		<img src="./search/img/pizzaHut.png" id="mainimg">
			
		<h1><%=article.getPlace_name()%></h1>
		<h1><%=article.getRoad_address()%></h1>
    	<h1><%=article.getJibun_address()%></h1> 
    	<h1><%=article.getTell_number()%></h1>
	</section>
</body>
</html>