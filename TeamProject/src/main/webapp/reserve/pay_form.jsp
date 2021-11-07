<%@page import="action.payAction"%>
<%@page import="vo.ReserveBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	ReserveBean reserve = (ReserveBean)request.getAttribute("reserveBean");
	//로그인 시 세션으로 저장된 ID
	request.setAttribute("id", reserve.getId());
	String id = request.getAttribute("id").toString();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
*{
    margin: 0;
    padding: 0;
}

li{
    list-style: none;
    font-size: 16px;
    font-weight: 500;
}

li a{
	font-size: 13px;
    font-weight: 400;
    font-stretch: normal;
    display : inline-block; 
    text-overflow : ellipsis;
}
/* 기본리셋 */

.payform_wrap {
    width: 900px;
    margin: 100px auto;
}




/* 매정정보 */



.payform_wrap ul {
    text-align: left;
    display: flex;
    margin: 15px 0 20px 0;
}

.payform_wrap ul li {
    padding-right: 30px;
/*     margin: 0px 10px 60px 10px; */
	margin:auto;
}

.payform_wrap p {
    font-size: 13px;
}

.payment_group label{
    font-size: 13px;
}
.payment_list li{
	padding: 0;
	margin: 0;
}
h3{
  width: 170px;
    font-size: 16px;
    font-weight: 900;
} 

#paymentBtn {
    margin-top: 30PX;
    border: none;
    width: 144px;
    height: 30px;
    font-weight: 500;
    color: #fff;
    background-color: #FF8831;
}
</style>
<script src="../js/jquery-3.6.0.js"></script>
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
				dataType:"text",
				url:"PaymentAction.do",
				error:function(request, status, error){

					console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

				}
			}).done(function(data) {
				 alert('예약 완료!');
// 				 $('#reserve_success').html(data);
				location.href='./ReserveList.do';
			}).fail(function() {
				alert('죄송합니다 잠시 후에 시도해주세요.');
			});
		});
		
		$('#kakaopay').on('click',function(){
			var id = $('#id').text();
			var win = window.open("/TeamProject/reserve/kakaopay.jsp?id="+id, "PopupWin", "width=500,height=600");
			
			if(openWin.document.getElementById('paymentSuccess').value == true){
				alert('suc');
			}else{
				alert('fail')
			}
		});
		
	});
</script>
</head>
<body>
	<div class="payform_wrap">
		<h3>선택하신 가게 정보</h3>
		<ul id="store_info">
			<li>가게명<br><a><%=reserve.getStoreName() %></a></li>
			<li>가게 도로명주소<br><a><%=reserve.getLoadAddress()%></a></li>
			<li>가게 주소<br><a><%=reserve.getAddress() %></a></li>
			<li>가게 번호<br><a><%=reserve.getStoreNumber() %></a></li>
		</ul>
		<h3>예약 세부 사항</h3>
		<ul id="reserve_info">
			<li>예약날짜<br><a><%=reserve.getReserve_date()%></a></li>
			<li>예약시간<br><a><%=reserve.getReserve_time() %></a></li>
			<li>예약인원<br><a><%=reserve.getPeople() %></a>명</li>
			<li>세트A(9000원)<br><a><%=reserve.getSetA()%></a>인</li>
			<li>세트B(10000원)<br><a><%=reserve.getSetB()%></a>인</li>
			<li>총 주문 내역<br><a><%=reserve.getTotal_order_menu() %></a>
			<li>추가사항<br><a><%=reserve.getCustomerNeeds() %></a></li>
		</ul>
		<h3 id="showList"><a id="id"><%=id %></a>님이<br>보유하신 쿠폰 보기</h3>
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
		<ul class="payment_list">
		<li> <a id="totalPrice"><%=totalPrice%></a></li>
		<li>-</li>
		<li id="discount">0</li>
		<li>=</li>
		
		<li id="resultPrice"><%=totalPrice%></li>
		</ul>
		<button id="kakaopay">카카오페이로 결제하기</button>
		<button id="paymentBtn">결제하기</button>
	</div>
	<div id="reserve_success"></div>
</body>
</html>