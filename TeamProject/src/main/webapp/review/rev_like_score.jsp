<%@page import="db.jdbcUtil"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.ReviewDAO"%>
<%@page import="vo.ReviewBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	int rev_num = Integer.parseInt(request.getParameter("rev_num"));
	int prev_like_score = Integer.parseInt(request.getParameter("prev_like"));

	// 공통작업-1. Connection Pool 로부터 Connection 객체 가져오기
	Connection con = jdbcUtil.getConnection();
	// 공통작업-2. BoardDAO 클래스로부터 BoardDAO 객체 가져오기
	ReviewDAO dao = ReviewDAO.getInstance();
	out.println(rev_num);
	out.println(prev_like_score);
	// 공통작업-3. BoardDAO 객체에 Connection 객체 전달하기
	dao.setConnection(con);	
	
	int likeScore = dao.getLikeScore(rev_num, prev_like_score);
	
	if(likeScore > 0 ) {
		con.commit();
		out.print(likeScore);
	} else {
		out.print(prev_like_score);
	}
	
	
	// 공통작업-4. Connection 객체 반환
	con.close();
		
	%>
	
</body>
</html>