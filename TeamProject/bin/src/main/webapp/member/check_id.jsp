<%@page import="db.jdbcUtil"%>
<%@page import="java.sql.Connection"%>
<%@page import="dao.MemberDAO"%>
<%@page import="vo.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%
    request.setCharacterEncoding("utf-8");
    String id = request.getParameter("id");
    MemberBean bean = new MemberBean();

    bean.setId(id);
	
    MemberDAO dao = MemberDAO.getInstance();

    Connection con = jdbcUtil.getConnection();

    dao.setConnection(con);

    boolean isIdDup = dao.hasId(bean);
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:choose>
		<c:when test="<%=isIdDup %>">
			<a style="color: green">사용 가능한 아이디 입니다.</a>
		</c:when>
		<c:otherwise>
			<a style="color: red">중복된 아이디 입니다.</a>
		</c:otherwise>
	</c:choose>
	
</body>
<%jdbcUtil.close(con); %>
</html>