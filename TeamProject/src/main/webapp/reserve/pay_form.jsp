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
		
		$('#couponBtn').on('click',function(){
			alert($(':input:radio [name=checkCoupon]:checked').val());
			
		});
	});
</script>
</head>
<body>
	<div>
		<h3>선택하신 가게 정보</h3>
		<ul>
			<li>가게명 : <%=reserve.getStoreName() %></li>
			<li>가게 도로명주소 : <%=reserve.getLoadAddress()%></li>
			<li>가게 주소 : <%=reserve.getAddress() %></li>
			<li>가게 번호 : <%=reserve.getStoreNumber() %></li>
		</ul>
		<h3>예약 세부 사항</h3>
		<ul>
			<li>예약날짜 : <%=reserve.getDate() %></li>
			<li>예약시간 : <%=reserve.getTime() %></li>
			<li>예약인원 : <%=reserve.getPeople() %>명</li>
			<li>세트A(9000원) : <%=reserve.getSetA()%>인</li>
			<li>세트B(10000원) : <%=reserve.getSetB()%>인</li>
			<li>추가사항 : <%=reserve.getCustomerNeeds() %></li>
		</ul>
		<h3 id="showList"><a id="id">${id }</a>님이 보유하신 쿠폰 보기</h3>
		<div id="couponResult">
		<div id="couponList"></div>
		<button id="couponBtn">사용하기</button>
		</div>
		<h3> - 결제 금액 - </h3>
		<%
			int aPrice = 9000;
			int bPrice = 10000;
			
			int totalAPrice = aPrice * reserve.getSetA();
			int totalBPrice = bPrice * reserve.getSetB();
		%>
		<ul>
		<li>&nbsp;&nbsp;&nbsp;<%=totalAPrice%></li>
		<li>+ <%=totalBPrice%></li>
		<li>------------------------------</li>
		<li><%=totalAPrice+totalBPrice %></li>
		</ul>
	</div>
</body>
</html>