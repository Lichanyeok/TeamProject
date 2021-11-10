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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../js/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="/TeamProject/css/reset.css">
<link rel="stylesheet" href="/TeamProject/css/header.css">
<script type="text/javascript">	
	$(document).ready(function() {
		$('#rev_'+ $('#rev_star').val()).prop('checked', true);
	} // 제이쿼리 끝
</script>
</head>
<body>

	<% for(int i = 0; i < articleList.size(); i++) {
		String str = articleList.get(i).getRev_pic_origin(); 
		int rev_score = (int)articleList.get(i).getRev_score();
		int dateDiff = articleList.get(i).getDateDiff();
	%>
		<input type="hidden" value="<%=rev_score %>" id="rev_star"/>
		<table class="rev_table">
			<tr class="table_subject">
				<td>
					<!-- 닉네임 --><span class="userName"><%=articleList.get(i).getRev_name() %>님</span><br>
					<!-- 별점 --><img src="./review/rev_im/<%=rev_score %>star.png" width="100" height="20" />
					<!-- 작성일 --> 
					<span class="rev_date"> 
						<%if(dateDiff == 0){ %>
							오늘
						<%} else if(dateDiff == 1){ %>
							어제
						<%} else if(dateDiff == 2){ %>
							그제
						<%} else if(dateDiff >= 3 && dateDiff <= 7){ %>
							이번 주
						<%} else if(dateDiff >= 8 && dateDiff <= 14){ %>
							저번 주
						<%} else if(dateDiff >= 15 && dateDiff <= 21){ %>
							3주 전
						<%} else if(dateDiff >= 22 && dateDiff <= 29){ %>
							4주 전
						<%} else if(dateDiff >= 30 && dateDiff < 60){ %>
							한달 전
						<%} else if(dateDiff >= 365){ %>
							<%=dateDiff/365 %>년 전
						<%} else if(dateDiff >= 30){ %>
							<%=dateDiff/30 %>달 전
						<%} %>
					</span>
					<span id="rev_menu_btn">
						<button type="button" class="btnLike<%=articleList.get(i).getRev_num() %>" value="<%=articleList.get(i).getRev_num() %>" onclick="return like()">
								<%if(articleList.get(i).getListCount() <= 0){ %>
									<img src="<%=request.getContextPath() %>/review/rev_im/rev_empty.png" width="20" height="20">
								<%}else { %>
									<img src="<%=request.getContextPath() %>/review/rev_im/rev_write.png" width="20" height="20">
								<%} %>
							<span class="likeScore<%=articleList.get(i).getRev_num()%>">
								<!-- 여기에 좋아요 갯수 뿌리기 -->
								<%=articleList.get(i).getRev_like() %>
							</span>
						</button>
					</span>
				</td>
			</tr>
			<%if(articleList.get(i).getRev_pic_origin() != null) { %>
			<tr class="reviewPic">
				<td>
					<div>
					<!-- 리뷰 사진 --><img src="<%=request.getContextPath() %>/upload/<%=str %>" data-popup-open="photo_popup<%=articleList.get(i).getRev_num() %>"/>
					<!-- 리뷰 글 --><p class="reviewContent"><%=articleList.get(i).getRev_content()%></p>
					<!-- 주문 메뉴 --><p class="reviewMenu">주문메뉴 : <%=articleList.get(i).getRev_menu()%></p>
					</div>
				</td>
			</tr>
			<%} else { %>
			<tr class="reviewText">
				<td>
					<div>
					<!-- 리뷰 글 --><p class="reviewContent"><%=articleList.get(i).getRev_content()%></p>
					<!-- 주문 메뉴 --><p class="reviewMenu">주문메뉴 : <%=articleList.get(i).getRev_menu()%></p>
					</div>
				</td>
			</tr>
			<%} %>
		</table>
		<!-- 팝업창에 띄울 이미지 정의 -->
		<div class="popup" data-popup="photo_popup<%=articleList.get(i).getRev_num() %>">
		  <div class="popup-inner">
		    <div class="popup-contents">
		    	<img src="<%=request.getContextPath() %>/upload/<%=str %>" class="popup_img" data-popup-close="photo_popup<%=articleList.get(i).getRev_num() %>"/>
		    </div>
		  </div>
		</div>
	<%}%>
	
</body>
</html>