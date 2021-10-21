<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<input type="button" value="검색" onclick="location.href='MatzipList.mz'">
    	<h1><%=request.getParameter("place_name") %></h1>
    	<h1><%=request.getParameter("road_address") %></h1>
    	<h1><%=request.getParameter("jiban_address") %></h1> 
    	<h1><%=request.getParameter("phone_num") %></h1>
</body>
</html>