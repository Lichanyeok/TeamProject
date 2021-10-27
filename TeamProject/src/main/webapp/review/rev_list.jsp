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
<script src="./js/jquery-3.6.0.js"></script>
<script type="text/javascript">	
	$(document).ready(function() {
		$('#rev_'+ $('#rev_star').val()).prop('checked', true);
	}
</script>
</head>
<body>
<%
	String selectedOption = request.getParameter("selectedOption");
	String isCheckedPic = request.getParameter("isCheckedPic"); // 추가

	// 공통작업-1. Connection Pool 로부터 Connection 객체 가져오기
	Connection con = jdbcUtil.getConnection();
	// 공통작업-2. BoardDAO 클래스로부터 BoardDAO 객체 가져오기
	ReviewDAO dao = ReviewDAO.getInstance();

	// 공통작업-3. BoardDAO 객체에 Connection 객체 전달하기
	dao.setConnection(con);
	
	ArrayList<ReviewBean> articleList = dao.getReviewSort(selectedOption , isCheckedPic); // isCheckedPic 추가
	
	
%>	
	
	<% for(int i = 0; i < articleList.size(); i++) {
		String str = articleList.get(i).getRev_pic_origin(); 
		int rating = (int)articleList.get(i).getRev_score();
	%>
				
	<div id="rev_contents">
		<input type="hidden" value="<%=rating %>" id="rev_star"/>
		<div id="rev_name">아이디 : <%=articleList.get(i).getRev_name() %></div><br>
		<div id="rev_subject">
			<img src="./review/rev_im/<%=rating %>star.png" width="100" height="20" />
		</div><div id="rev_date"><%=articleList.get(i).getRev_date() %></div>
		<div id="rev_content"><%if(articleList.get(i).getRev_pic_origin() != null) { %><img src="./upload/<%=str %>" width="300" height="300" /><br><%} %><%=articleList.get(i).getRev_content() %></div>
		<div id="rev_menu">주문메뉴 : <%=articleList.get(i).getRev_menu() %></div><br>
		<div id="rev_menu_btn"><button type="button" id="rev_like_btn" value="<%=articleList.get(i).getRev_num() %>"><img src="<%=request.getContextPath() %>/review/rev_im/reviewGood.png" width="15" height="15">&nbsp;&nbsp;
			<span id="likeScore"><%=articleList.get(i).getRev_like() %><!-- 여기에 좋아요 갯수 뿌리기 --></span></button>
		</div>
		<div id="rev_menu_btn" align="right">
			<input type="button" name="rev_modify" value="수정" onclick="location.href='./ReviewModify.re?rev_num=<%=articleList.get(i).getRev_num() %>'"/>&nbsp;
			<input type="button" name="rev_delete" value="삭제" onclick="location.href='./ReviewDelete.re?rev_num=<%=articleList.get(i).getRev_num() %>'"/>
		</div><br>
	<%}%>
	</div>
	
	<%
		// 공통작업-4. Connection 객체 반환
		con.close();
		
	%>
	
</body>
</html>