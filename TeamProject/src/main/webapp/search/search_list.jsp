<%@page import="vo.PageInfo"%>
<%@page import="vo.SearchBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	ArrayList<SearchBean> articleList = (ArrayList<SearchBean>)request.getAttribute("articleList");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
	.clear{
		clear: both;
	}
 	#listForm { 
 		width: auto; 
		height: 510px;					 
 	}	 
	
	.category_list_info{
		border: 1px solid #FF8831;
		width: 538px;
		height: 100px;
		float: left;
		margin: 0 auto;		
		color: black;
		font-size: 15px;
		
		
	}
	.category_list_logo{
		width: 100px;	
		height: 100px;
		float: left;
		margin-right: 10px;
		
	}
	#category_list_ul{
		margin-top:3px;
	}
	#category_list_ul li{
		line-height: 1.2;
		
	}
	.starImg {
		width: 12px;
		height: 12px;		
	}
	.list_name{
		font-weight: bold;
		font-size: 18px;
		color: #3CB371;
	}
	
	.list_link{
		
	}
</style>
</head>
<body>	
	<div id="listForm">
		<%
			if(articleList != null) {			
				for(int i = 0; i < articleList.size(); i++) {%>
				<div class="category_list_info">
					<img src="./search/img/pizzaHut.png" class="category_list_logo">
					
					<ul id="category_list_ul">
						<li  class="list_name"><%=articleList.get(i).getPlace_name() %>
						<%
							double star=Math.round(articleList.get(i).getStar_score()*10)/10.0;
							int iStar=(int)star;
				 			double fStar=Math.round((star-iStar)*10)/10.0;
							for(int j=0;j<iStar;j++){%>
								<img src="./search/img/star.jpg" class="starImg">
						<%}%><%=star %></li>
						<li class="list_category">업종 : <%=articleList.get(i).getCategory() %></li>
						<li class="list_address">주소 : <%=articleList.get(i).getRoad_address() %></li>
						<li class="list_tell">전화번호 : <%=articleList.get(i).getTell_number() %></li>
						<li class="list_rink"><a href="./MatzipInfo.mz?road_address=<%=articleList.get(i).getRoad_address() %>
							&tell_number=<%=articleList.get(i).getTell_number()%>">상세정보 보기</a></li>
					</ul>
				</div>
				<%}
			} %>
	</div>	
</body>                              
</html>