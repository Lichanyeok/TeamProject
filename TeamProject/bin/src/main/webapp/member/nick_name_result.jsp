<%@page import="vo.MemberBean"%>
<%@page import="dao.MemberDAO"%>
<%@page import="java.sql.Connection"%>
<%@page import="db.jdbcUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
request.setCharacterEncoding("utf-8");
String nickName = request.getParameter("nickName");
MemberBean bean = new MemberBean();

bean.setNickName(nickName);

MemberDAO dao = MemberDAO.getInstance();

Connection con = jdbcUtil.getConnection();

dao.setConnection(con);

boolean hasNickName = dao.hasNickName(bean);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <script src="../js/jquery-3.6.0.js"></script>
    
</head>
<body>

	<c:choose>
		<c:when test="<%=hasNickName %>">
			<a style="color:red;">이미 사용중인 닉네임 입니다.</a>
		</c:when>
		<c:otherwise>
			<a style="color:green">사용 가능한 닉네임 입니다.</a>
		</c:otherwise>
	</c:choose>
</body>
<%jdbcUtil.close(con); %>
</html>