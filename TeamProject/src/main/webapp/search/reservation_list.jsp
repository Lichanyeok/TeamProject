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
<link rel="stylesheet" href="../css/reset.css">
<link rel="stylesheet" href="../css/header.css">
<style type="text/css">
body{
	min-width: 1080px;
	margin: 0 auto;
}
.clear{
	clear: both;
}
#wrap {
	border: 1px solid;
	width: 1080px;
	height: 840px;
	margin: 0 auto;
}

#reservation_list {
	border: 1px solid blue;
	width: 1080px;
	height: 700px;
	
}
#reservation_header{
	height: 30px;
	font-size: 24px;
	margin: 30px 10px;
	
}
.list{
	width: 270px;
	height: 260px;
	background: #aaa;
	float: left;
}
.list_ul {
	float: left;
}
.list_ul > li{
	float: left;
	font-size: 18px;
	margin: 7px 0; 
	margin-left: 15px;
	width: 255px;
}
.list_ul> li> p:first-child{
	float: left;
	width: 100px;
}
.list_ul> li> p:last-child{
	float: left;
	width: 155px;
}
</style>
<script src="./js/jquery-3.6.0.js"></script>
<%
	ArrayList<ReserveBean> article= (ArrayList<ReserveBean>)request.getAttribute("article");
	if(article!=null){
		pageContext.setAttribute("article", article);
		
	}

%>
</head>
<body>
	<jsp:include page="../inc/header.jsp"></jsp:include>
	<hr>
	<div id="wrap">
		<p id="reservation_header">예약 리스트</p>
		<div class="clear"></div>
		<div id="reservation_list">
			<c:choose>
			<c:when test="${article != null }">
				<c:forEach items="article" var="article">
				<div class="list">
				<ul class="list_ul">
					<li><p>예약자 </p><p>{article.getReserve_user()  }</p></li>
					<li><p>예약날자 </p><p>${article.getReserve_date()  }</p></li>
					<li><p>예약시간 </p><p>${article.getReserve_time()  }</p></li>
					<li><p>인원수 </p><p>${article.getPeople() }</p></li>
					<li><p>메뉴 </p><p>${article.getTotal_order_menu()  }</p></li>
					<li><p>요청사항 </p><p>${article.getCustomerNeeds() }</p></li>
					<li><p>결제방법 </p><p>${article.getReserve_type() }</p></li>
					
				</ul>			
			</div>			
				</c:forEach>
			</c:when>
			<c:otherwise>
				<p>예약 없음</p>	
			</c:otherwise>
			</c:choose>
		</div>	
	</div>
</body>
</html>