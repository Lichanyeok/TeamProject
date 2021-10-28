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
<style type="text/css">
tr th {
    width: 170px;
    font-size: 16px;
    font-weight: 900;
}

tr  td {
    font-size:15px;
    
}
</style>
<script src="../js/jquery-3.6.0.js"></script>
<script type="text/javascript">
$('#couponBtn').on('click',function(){
// 	alert($(':input:radio[name=checkCoupon]:checked').val());
	var checkedCouponCode = $(':input:radio[name=checkCoupon]:checked').val();
	$('#discount').html('<a id="discountPrice">'+checkedCouponCode+'</a>');
	
	var totalPrice = $('#totalPrice').text();
	var dcPrice = $('#discountPrice').text();
// 	alert('totalPrice = ' + totalPrice+'dcPrice = '+dcPrice);
	var total=totalPrice - dcPrice;
	$('#resultPrice').text(total);
});
</script>
</head>
<body>

<table>
	<tr>
		<th>쿠폰코드</th><th>쿠폰명</th><th>쿠폰내용</th><th>할인가격</th><th>사용자명</th><th>발급날짜</th>
	</tr>
	
<%
if(couponList.size()>0){
for(int i = 0;i < couponList.size();i++){ %>

	<tr id="coupon">
	<td><input type="radio" name="checkCoupon" value="<%=couponList.get(i).getCoupon_price()%>"><a><%=couponList.get(i).getCoupon_code() %></a></td>
	<td><%=couponList.get(i).getCoupon_name() %></td>
	<td><%=couponList.get(i).getCoupon_value() %></td>
	<td><%=couponList.get(i).getCoupon_price() %></td>
	<td><%=couponList.get(i).getUser_id() %></td>
	<td><%=couponList.get(i).getMade_date() %></td>
	</tr>
<%	}
}else{%>
	<tr>
		<td colspan="6">보유하신 쿠폰이 없습니다.</td>
	</tr>
<%} %>
</table>
<button id="couponBtn">사용하기</button>
</body>
</html>