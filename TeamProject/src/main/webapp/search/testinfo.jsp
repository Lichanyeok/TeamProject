<%@page import="java.util.ArrayList"%>
<%@page import="vo.SearchBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%

ArrayList<SearchBean> articleList = (ArrayList<SearchBean>) request.getAttribute("articleList");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>aaa</h1>
	 <%
        if (articleList != null) {
            for (int i = 0; i < articleList.size(); i++) {%>
	   			<p>
				insert into search values (<br>
				"<%=articleList.get(i).getRoad_address() %>",<br>
				"<%=articleList.get(i).getJibun_address() %>",<br>
				"<%=articleList.get(i).getCategory()%>",<br>
				"<%=articleList.get(i).getPlace_name()%>",<br>
				0,<br>
				"<%=articleList.get(i).getTell_number() %>",<br>
				"<%=articleList.get(i).getLogo_img() %>",<br>
				now(),<br>
				0<br>
				);<br>	
				</p>    
    <%}}%>
	
</body>
</html>