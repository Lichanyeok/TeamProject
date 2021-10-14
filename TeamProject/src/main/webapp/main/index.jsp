<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Welcome, is Matzip</title>
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/style.css">
</head>
<body>
		<!-- 상위 고정 -->
        <jsp:include page="../inc/header.jsp"></jsp:include>
        <!-- 상위 고정 -->
    
    <main>
    	
    </main>
    <section>
    	<h1><%=request.getParameter("place_name") %></h1>
    	<h1><%=request.getParameter("road_address") %></h1>
    	<h1><%=request.getParameter("jiban_address") %></h1> 
    	<h1><%=request.getParameter("phone_num") %></h1>       
    </section>
    <div class = "sec1">
    </div>
    <div class = "sec2"></div>
    <div class = "sec3"></div>
    
    <footer></footer>
    
</body>
</html>