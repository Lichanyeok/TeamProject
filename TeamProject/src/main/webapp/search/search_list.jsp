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
		height: 530px;
		margin-top: 5px;
		margin-bottom: 5px;		 
 		 
 	}	 
	
	#category_list_info{
		border: 1px dashed red;
		width: 538px;
		height: 100px;
		float: left;
		margin: 0 auto;		
		color: black;
	}
	

	
	
</style>
</head>
<body>
	<!-- 게시판 리스트 -->
		<div id="listForm">
						
			<%
			if(articleList != null) {			
				for(int i = 0; i < articleList.size(); i++) {
					%>
					<div id="category_list_info">
							업체명 : <%=articleList.get(i).getPlace_name() %> | 
							업종 : <%=articleList.get(i).getCategory() %><br>
							주소 : 	<%=articleList.get(i).getRoad_address() %>&nbsp;
							(<%=articleList.get(i).getJibun_address()%>)<br>
							별점 : <%=articleList.get(i).getStar_score() %> |
							전화번호 : <%=articleList.get(i).getTell_number() %>
					</div><%}%>
		
			<%} %>
	</div>
</body>
</html>