<%@page import="vo.PageInfo"%>
<%@page import="vo.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <% 
     ArrayList<BoardBean> articleList = (ArrayList)request.getAttribute("articleList");
 	PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
 	int nowPage = pageInfo.getPage();
 	int maxPage = pageInfo.getMaxPage();
 	int startPage = pageInfo.getStartPage();
 	int endPage = pageInfo.getEndPage();
 	int listCount = pageInfo.getListCount();
 	
 	int a = nowPage*10;
 	if(a > articleList.size()){
 		a = articleList.size();
 	}
 %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CustomerCommentList</title>
</head>
<body>

	<!-- 상위 고정 -->
    <jsp:include page="../inc/header.jsp"></jsp:include>
    <!-- 상위 고정 -->

	<h1>CustomerCommentlist</h1>
	<table>
	<%if(articleList != null && listCount > 0) {%>
		<tr id="tr_top">
			<td>번호</td>
			<td>제목</td>
			<td width="150px">작성자</td>
			<td width="150px">날짜</td>
			<td width="100px">조회수</td>
		</tr>
		<%for(int i = (nowPage*10)-10; i < a; i++) {%>
		<tr>
			<td><%=articleList.get(i).getNum()%></td>
			<td><%=articleList.get(i).getSubject() %></td>
			<td><%=articleList.get(i).getName() %></td>
			<td><%=articleList.get(i).getDate()%></td>
			<td><%=articleList.get(i).getReadcount() %></td>
		</tr>
		<%} %>
	</table>
	<%if(nowPage <= 1) {%>
			<input type="button" value="이전">&nbsp;
	<%} else {%>
			<input type="button" value="이전" onclick="location.href='BoardList.do?page=<%=nowPage - 1 %>'">&nbsp;
	<%} %>
	
	<%for(int i = startPage; i <= endPage; i++) { 
			if(i == nowPage) { %>
				[<%=i %>]
		<%} else { %>
				<a href="BoardList.do?page=<%=i %>">[<%=i %>]</a>&nbsp;
		<%} %>
	<%} %>
	
	<%if(nowPage >= maxPage) { %>
			<input type="button" value="다음">
	<%} else { %>
			<input type="button" value="다음" onclick="location.href='BoardList.do?page=<%=nowPage + 1 %>'">
	<%} %>
	<%} else{%>
	<section id="emptyArea">등록된 글이 없습니다</section>
	<%}%>
	<input type="button" value="글쓰기" onclick="location.href='WriteForm.do'">
</body>
</html>