<%@page import="java.util.ArrayList"%>
<%@page import="vo.ReserveBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
	ArrayList<ReserveBean> article= (ArrayList<ReserveBean>)request.getAttribute("articleList");
%>
</head>
<body>
		<div id="reservation_list">
				<%if(article!=null){ 
					for(int i=0;i<article.size();i++){%>
					<div class="list">
						<ul class="list_ul">
							<li><p>예약자 </p><p><%=article.get(i).getId() %></p></li>
							<li><p>예약날자 </p><p><%=article.get(i).getReserve_date() %></p></li>					
							<li><p>예약시간 </p><p><%=article.get(i).getReserve_time() %></p></li>
							<li><p>인원수 </p><p><%=article.get(i).getPeople() %></p></li>
							<li><p>메뉴 </p><p><%=article.get(i).getTotal_order_menu() %></p></li>
							<li><p>요청사항 </p><p><%=article.get(i).getCustomerNeeds() %></p></li>
							<li><p>결제방법 </p>
							<%if(article.get(i).getReserve_type()==0) {%>
							<p>현장결제</p>
							<% }else if(article.get(i).getReserve_type()==1){%>
							<p>선결제</p>
							<%} %>
							</li>					
						</ul>				
					</div>	
					<%}} %>		
		</div>	
</body>
</html>