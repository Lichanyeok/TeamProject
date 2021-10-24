<%@page import="java.util.ArrayList"%>
<%@page import="dao.ReviewDAO"%>
<%@page import="vo.ReviewBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 전달받은 request 객체로부터 데이터 가져오기
	// "pageInfo" 객체와 "articleList" 객체를 request 객체로부터 꺼내서 저장
	// "pageInfo" 객체로부터 페이지 관련 값들을 꺼내서 변수에 저장
	ArrayList<ReviewBean> articleList = (ArrayList<ReviewBean>)request.getAttribute("articleList");
	ReviewBean reviewCount = (ReviewBean)request.getAttribute("reviewCount");
// 	out.println("rev_list.jsp - articleList : " + articleList);
// 	out.println("rev_list.jsp - reviewCount : " + reviewCount);
	
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="./js/jquery-3.6.0.js"></script>
<script type="text/javascript">	
	$(document).ready(function() {
		$('#rev_Modify').on('click', function() {
			$('rev_name').val('asdasdasdasdad');
		});
	}
</script>
<style type="text/css">

#rev_name, #rev_subject, #rev_date {
	width: 200px;
	display: inline-block;
	margin: 20px;
	border: 1px solid;
}

#rev_content {
	width: 680px;
	height: 400px;
	margin: 20px;
	border: 1px solid;
}

#rev_menu {
	width: 238px;
	margin: 20px;
	display: inline-block;
	border: 1px solid;
}

#rev_menu_btn {
	width: 238px;
	margin: 20px;
/* 	float: right; */
	display: inline-block;
	border: 1px solid;
}


</style>
</head>
<body>
	<%
		for(int i = 0; i < articleList.size(); i++) {
	%>
	<div id="rev_name">아이디 : <%=articleList.get(i).getRev_name() %></div><div id="rev_subject">제목 : <%=articleList.get(i).getRev_subject()%></div><div id="rev_date"><%=articleList.get(i).getRev_date() %></div>
	<div id="rev_content"><%if(articleList.get(i).getRev_pic_origin() != null) { %><img src="./upload/<%=articleList.get(i).getRev_pic_origin()%>" width="300" height="300"/><br><%} %><%=articleList.get(i).getRev_content() %></div>
	<div id="rev_menu">주문메뉴 : <%=articleList.get(i).getRev_menu() %></div>
	<div id="rev_menu_btn">
		<input type="button" id="rev_Modify" name="rev_Modify" value="수정"/>&nbsp;
		<input type="button" name="rev_delete" value="삭제" />
	</div><br>
	<%}%>
</body>
</html>