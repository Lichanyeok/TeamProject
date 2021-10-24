<%@page import="vo.CouponBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% ArrayList<CouponBean> couponList = (ArrayList<CouponBean>)request.getAttribute("couponList"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<table>
	<tr>
		<th>쿠폰명</th><th>쿠폰내용</th><th>할인가격</th><th>쿠폰코드</th><th>사용자명</th><th>발급날짜</th>
	</tr>
<%for(int i = 0;i < couponList.size();i++){ %>
	
	<tr id="coupon">
	<td><input type="radio" name="checkCoupon" value="<%=couponList.get(i).getCoupon_code()%>"></td>
	<td><%=couponList.get(i).getCoupon_name() %></td>
	<td><%=couponList.get(i).getCoupon_value() %></td>
	<td><%=couponList.get(i).getCoupon_price() %></td>
	<td><%=couponList.get(i).getCoupon_code() %></td>
	<td><%=couponList.get(i).getUser_id() %></td>
	<td><%=couponList.get(i).getMade_date() %></td>
	</tr>
<%} %>

</table>

</body>
</html>