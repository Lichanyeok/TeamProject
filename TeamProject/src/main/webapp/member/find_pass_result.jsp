<%@page import="dao.MemberDAO"%>
<%@page import="vo.MemberBean"%>
<%@page import="db.jdbcUtil"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	String email = request.getParameter("email");
	
	boolean isRightInfo = false;
	MemberBean bean = new MemberBean();
	Connection con = jdbcUtil.getConnection();
	MemberDAO dao = MemberDAO.getInstance();
	dao.setConnection(con);
	bean.setId(id);
	bean.setEmail(email);
	
	isRightInfo = dao.getPass(bean); 
	String pass = "정보가 일치하지 않거나 없는 계정입니다.";
	if(isRightInfo){
		pass = bean.getPass();
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
	<h3><%=id %>님의 패스워드 <%=pass %>입니다.</h3>
	<% }else{%>
	<h3><%=pass %></h3>
	<%} %>
	
</body>
</html>