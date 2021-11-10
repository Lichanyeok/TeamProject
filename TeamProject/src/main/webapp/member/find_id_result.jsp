<%@page import="dao.MemberDAO"%>
<%@page import="vo.MemberBean"%>
<%@page import="db.jdbcUtil"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MemberBean bean = (MemberBean)request.getAttribute("bean");
		String id = bean.getId();
		String name = bean.getName();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%if(id!=null){ %>
	<h3><%=name %>님의 아이디는 <%=id %>입니다.</h3>
	<button onclick="location.href='./MemberLoginFormAction.do'">로그인 하러 가기.</button>
	<% }else{%>
	<h3>등록된 정보가 없습니다.</h3>
	<%} %>
	
</body>
</html>