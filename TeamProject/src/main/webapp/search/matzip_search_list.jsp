<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/style.css">
</head>
<body>
	<main>
			<!-- 상위 고정 -->
	        <jsp:include page="../inc/header.jsp"></jsp:include>
	        <!-- 상위 고정 -->
	        <br>
	         검색: 
	         <input type="text"> <input type="button" value="버튼">
	</main>
        
	
    <section>
    	<jsp:include page="/inc/search.jsp"></jsp:include>
    </section>
    <footer></footer>
    
</body>
</html>