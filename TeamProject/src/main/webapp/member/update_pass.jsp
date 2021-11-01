<%@page import="db.jdbcUtil"%>
<%@page import="dao.MemberDAO"%>
<%@page import="java.sql.Connection"%>
<%@page import="vo.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");

	boolean updateSuccess = false;
	MemberBean bean = new MemberBean();
	Connection con = jdbcUtil.getConnection();
	MemberDAO dao = MemberDAO.getInstance();
	dao.setConnection(con);
	
	int updateCount = dao.updatePass(pass, id);
	
	jdbcUtil.close(con);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>