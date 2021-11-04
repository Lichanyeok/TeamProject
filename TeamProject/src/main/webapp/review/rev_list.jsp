<%@page import="db.jdbcUtil"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.ReviewDAO"%>
<%@page import="vo.ReviewBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
		ArrayList<ReviewBean> articleList = (ArrayList<ReviewBean>)request.getAttribute("articleList");
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../js/jquery-3.6.0.js"></script>
<script type="text/javascript">	
	$(document).ready(function() {
		$('#rev_'+ $('#rev_star').val()).prop('checked', true);
	}
</script>
</head>
<body>

	<% for(int i = 0; i < articleList.size(); i++) {
		String str = articleList.get(i).getRev_pic_origin(); 
		int rev_score = (int)articleList.get(i).getRev_score();
	%>
		<input type="hidden" value="<%=rev_score %>" id="rev_star"/>
		<div id="rev_name">
			닉네임 : <%=articleList.get(i).getRev_name() %>
		</div>
		<div id="rev_date">
			<%=articleList.get(i).getRev_date() %>
		</div><br>
		<div id="rev_subject">
			<img src="./review/rev_im/<%=rev_score %>star.png" width="100" height="20" />
		</div>
		<div id="rev_content">
			<%if(articleList.get(i).getRev_pic_origin() != null) { %>
			<img src="./upload/<%=str %>" width="300" height="300" /><br>
			<%} %><%=articleList.get(i).getRev_content() %>
		</div>
		<div id="rev_menu">
			주문메뉴 : <%=articleList.get(i).getRev_menu() %>
		</div>
		<div id="rev_menu_btn">
			<button type="button" id="rev_like_btn" value="<%=articleList.get(i).getRev_num() %>">
				<img src="<%=request.getContextPath() %>/review/rev_im/reviewGood.png" width="15" height="15">&nbsp;&nbsp;
				<span id="likeScore">
					<!-- 여기에 좋아요 갯수 뿌리기 -->
					<%=articleList.get(i).getRev_like() %>
				</span>
			</button>
		</div><br>
	<%}%>
	
</body>
</html>