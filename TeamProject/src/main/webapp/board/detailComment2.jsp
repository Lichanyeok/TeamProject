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
<link rel="stylesheet" href="css/detailComment2.css">
</head>
<body>
		<%request.getParameter("Rcomment"); %>
		<%for(int i=0; i<reply.size(); i++){%>
		<table class="Detailtable" >
			<tr>
				<td class="id"><%=reply.get(i).getId() %>(<%=reply.get(i).getDate()%>)</td>
			</tr>
			<tr>
				<td> <%=reply.get(i).getContent() %></td>
			</tr>
		<%} %>
		</table>
</body>
</html>