<%@page import="vo.SearchBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	ArrayList<SearchBean> article = (ArrayList<SearchBean>)request.getAttribute("article");	
%>
</head>
<body>
	<%if(article!=null){ 
		for(int i=0;i<article.size();i++){%>
			insert into business values ('<%=article.get(i).getId() %>','<%=article.get(i).getPlace_name() %>','<%=article.get(i).getBusiness_lisence() %>','<%=article.get(i).getCategory() %>','<%=article.get(i).getTell_number() %>','<%=article.get(i).getRoad_address() %>','<%=article.get(i).getJibun_address() %>','<%=article.get(i).getLogo_img() %>','<%=article.get(i).getOri_logo_img() %>','<%=article.get(i).getStar_score() %>','<%=article.get(i).getDate() %>','<%=article.get(i).getRecommend() %>','<%=article.get(i).getId() %>','Y');<br>
	<%}}%>
</body>
</html>