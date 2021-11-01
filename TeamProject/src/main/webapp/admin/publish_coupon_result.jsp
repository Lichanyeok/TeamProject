<%@page import="vo.CouponBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%ArrayList<CouponBean> couponList = (ArrayList<CouponBean>)request.getAttribute("couponList"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="/TeamProject/css/reset.css">
<link rel="stylesheet" href="/TeamProject/css/header.css">
</head>
<body>
		<!-- 상위 고정 -->
        <jsp:include page="/inc/header.jsp"></jsp:include>
        <!-- 상위 고정 -->
<div>
<h1>발급된 쿠폰 목록</h1>
	<table>
		<tr>
		<th>쿠폰명</th><th>쿠폰내용</th><th>쿠폰코드</th><th>유저ID</th>
		</tr>
		<%
		if(couponList.size()>0){
			for(int i = 0; i<couponList.size();i++){ %>
			<tr>
				<td><%=couponList.get(i).getCoupon_name() %></td>
				<td><%=couponList.get(i).getCoupon_value() %></td>
				<td><%=couponList.get(i).getCoupon_code() %></td>
				<td><%=couponList.get(i).getUser_id() %></td>
			</tr>
			<%} 
			}else{%>
			<tr>
				<td colspan="4">발급된 쿠폰이 없습니다</td>
			</tr>
			<%} %>	
	</table>
</div>
</body>
</html>