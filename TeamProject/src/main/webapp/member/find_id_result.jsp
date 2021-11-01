<%@page import="dao.MemberDAO"%>
<%@page import="vo.MemberBean"%>
<%@page import="db.jdbcUtil"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	
	boolean isRightInfo = false;
	MemberBean bean = new MemberBean();
	Connection con = jdbcUtil.getConnection();
	MemberDAO dao = MemberDAO.getInstance();
	dao.setConnection(con);
	bean.setName(name);
	bean.setEmail(email);
	isRightInfo = dao.getId(bean);
	String id = "정보가 일치하지 않거나 없는 계정입니다.";
	if(isRightInfo){
		id = bean.getId();
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%if(isRightInfo){ %>
	<h3><%=name %>님의 아이디는 <%=id %>입니다.</h3>
	<button onclick="location.href='../MemberLoginFormAction.do'">로그인 하러 가기.</button>
	<% }else{%>
	<h3><%=id %></h3>
	<%} %>
	
</body>
</html>