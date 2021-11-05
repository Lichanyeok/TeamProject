<%@page import="java.util.ArrayList"%>
<%@page import="vo.ReplyComment"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% ArrayList<ReplyComment> reply = (ArrayList<ReplyComment>)request.getAttribute("Rcomment"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<%request.getParameter("Rcomment"); %>
		<table border="1">
		<%for(int i=0; i<reply.size(); i++){%>
			<tr>
				<td>아이디 : </td><td><%=reply.get(i).getId() %></td>
				<td>내용 : </td><td><%=reply.get(i).getContent() %></td>
			</tr>
		<%} %>
		</table>
</body>
</html>