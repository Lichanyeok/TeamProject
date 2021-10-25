<%@page import="action.payAction"%>
<%@page import="vo.ReserveBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	ReserveBean reserve = (ReserveBean)request.getAttribute("reserveBean");
	//로그인 시 세션으로 저장된 ID
	request.setAttribute("id", reserve.getId());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="./js/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(function(){
		$('#showList').on('click',function(){
// 			alert($('#id').text());
			var sendId = $('#id').text();
			$.ajax({
				type:"get",
				data:{
					"id":sendId
				},
				url:"GetList.do"
			}).done(function(data){
				$('#couponList').html(data);
			});
		});
	
		$('#paymentBtn').on('click',function(){
			var sendData = {
				"reserve_user":$('#id').text(),
				"storeName":$('#store_info > li > a').eq(0).html(),
				"loadAddress":$('#store_info > li > a').eq(1).html(),
				"address":$('#store_info > li > a ').eq(2).html(),
				"storeNumber":$('#store_info > li > a').eq(3).html(),
				"reserve_date":$('#reserve_info > li > a').eq(0).html(),
				"reserve_time":$('#reserve_info > li > a').eq(1).html(),
				"reserve_people":$('#reserve_info > li > a').eq(2).html(),
				"total_order_menu":$('#reserve_info > li > a').eq(5).html(),
				"reserve_needs":$('#reserve_info > li > a').eq(6).html(),
				"payment_price":$('#resultPrice').html(),
				"used_coupon_code":$(':input:radio[name=checkCoupon]:checked').next('a').text()
			}
// 			alert(JSON.stringify(sendData));
			$.ajax({
				type:"get",
				data:sendData,
				dataType:"json",
				url:"PaymentAction.do"
			}).done(function(data) {
				alert('예약이 완료되었습니다.');
				$('#reserve_success').html(data);
			}).fail(function() {
				alert('죄송합니다 잠시 후에 시도해주세요.');
			});
		});
		
		
		
	});
</script>
</head>
<body>
	<div>
		<h3>선택하신 가게 정보</h3>
		<ul id="store_info">
			<li>가게명 : <a><%=reserve.getStoreName() %></a></li>
			<li>가게 도로명주소 : <a><%=reserve.getLoadAddress()%></a></li>
			<li>가게 주소 : <a><%=reserve.getAddress() %></a></li>
			<li>가게 번호 : <a><%=reserve.getStoreNumber() %></a></li>
		</ul>
		<h3>예약 세부 사항</h3>
		<ul id="reserve_info">
			<li>예약날짜 : <a><%=reserve.getReserve_date()%></a></li>
			<li>예약시간 : <a><%=reserve.getReserve_time() %></a></li>
			<li>예약인원 : <a><%=reserve.getPeople() %></a>명</li>
			<li>세트A(9000원) : <a><%=reserve.getSetA()%></a>인</li>
			<li>세트B(10000원) : <a><%=reserve.getSetB()%></a>인</li>
			<li>총 주문 내역 : <a><%=reserve.getTotal_order_menu() %></a>
			<li>추가사항 : <a><%=reserve.getCustomerNeeds() %></a></li>
		</ul>
		<h3 id="showList"><a id="id">${id }</a>님이 보유하신 쿠폰 보기</h3>
		<div id="couponResult">
		<div id="couponList"></div>
		
		</div>
		<h3> - 결제 금액 - </h3>
		<%
			int aPrice = 9000;
			int bPrice = 10000;
			
			int totalAPrice = aPrice * reserve.getSetA();
			int totalBPrice = bPrice * reserve.getSetB();
			int totalPrice = totalAPrice + totalBPrice;
		%>
		<ul>
		<li> <a id="totalPrice"><%=totalPrice%></a></li>
		<li id="discount"></li>
		<li>------------------------------</li>
		
		<li id="resultPrice"></li>
		</ul>
		<button id="paymentBtn">결제하기</button>
	</div>
	<div id="reserve_success"></div>
</body>
</html>