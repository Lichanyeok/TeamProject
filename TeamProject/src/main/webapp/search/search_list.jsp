<%@page import="vo.PageInfo"%>
<%@page import="vo.SearchBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 전달받은 request 객체로부터 데이터 가져오기
	// "pageInfo" 객체와 "articleList" 객체를 request 객체로부터 꺼내서 저장
	// "pageInfo" 객체로부터 페이지 관련 값들을 꺼내서 변수에 저장
	ArrayList<SearchBean> articleList = (ArrayList<SearchBean>)request.getAttribute("articleList");
	PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
	int nowPage = pageInfo.getPage();
	int maxPage = pageInfo.getMaxPage();
	int startPage = pageInfo.getStartPage();
	int endPage = pageInfo.getEndPage();
	int listCount = pageInfo.getListCount();
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MVC 게시판</title>
<style type="text/css">
	.clear{
		clear: both;
	}
	#listForm {
		width: auto;
		max-height: 610px;		
		margin: auto;
	}	
	
	#category_list_info{
		border: 1px dashed red;
		width: 538px;
		height: 100px;
		float: left;
		margin: 0 auto;		
		color: black;
	}
	
	#pageList {
		margin: 0 auto;
		width: 1024px;
		text-align: center;
	}	
	#emptyArea {
		margin: auto;
		width: 1024px;
		text-align: center;
	}
	
	#buttonArea {
		margin: auto;
		width: 1024px;
		text-align: right;
	}
	
	
</style>
</head>
<body>
	<!-- 게시판 리스트 -->
		<section id="listForm">
						
			<%
			if(articleList != null && listCount > 0) {
			%>
<!-- 			<tr id="tr_top"> -->
<!-- 				<td width="200px">업체명</td> -->
<!-- 				<td width="250px">주소</td> -->
<!-- 				<td width="250px">지번주소</td> -->
<!-- 				<td width="90px">업종</td> -->
<!-- 				<td width="70px">별점</td> -->
<!-- 				<td width="140px">전화번호</td> -->
<!-- 			</tr> -->
				<%
				for(int i = 0; i < articleList.size(); i++) {
					%>
					<div id="category_list_info">
							업체명 : <%=articleList.get(i).getPlace_name() %> | 
							업종 : <%=articleList.get(i).getCategory() %><br>
							주소 : 	<%=articleList.get(i).getRoad_address() %>&nbsp;
							(<%=articleList.get(i).getJibun_address()%>)<br>
							별점 : <%=articleList.get(i).getStar_score() %> |
							전화번호 : <%=articleList.get(i).getTell_number() %>
					</div><%}%>
		
	</section>
	<%} %>
</body>
</html>