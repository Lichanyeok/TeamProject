<%@page import="vo.ReserveBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	ArrayList<ReserveBean> resList = (ArrayList<ReserveBean>)request.getAttribute("resList");
	request.setAttribute("modiRes", resList);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="./js/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(function(){
		$('#res_cancle_btn').on('click',function(){
			var sendData = {"reserveCode":$('#reserveCode').text()};
// 			alert($('#reserveCode').text());
			$.ajax({
				type:"get",
				data:sendData,
				dataType:"text",
				url:"ResCancle.do"
			}).done(function(data) {
				alert('예약이 취소되었습니다.');
				location.href='./ReserveList.do';
			}).fail(function() {
				alert('취소 실패.');
			});
		});
	})
</script>
</head>
<body>
<%if(resList!=null){ %>
	<div class="reserve_wrap">
		<table class="store_list">
			<tr>	
				<td id="reserveCode"><%=resList.get(0).getRan_num() %></td>
				<td><%=resList.get(0).getStoreName()%></td> 
				<td><%=resList.get(0).getLoadAddress()%></td>
				<td><%=resList.get(0).getAddress()%></td>
				<td><%=resList.get(0).getStoreNumber()%></td>
				<td><%=resList.get(0).getReserve_date()%></td>
				<td><%=resList.get(0).getReserve_time()%></td>
				<td><%=resList.get(0).getTotal_order_menu()%></td>
				<td><%=resList.get(0).getPeople()%>명</td>
				<td><%=resList.get(0).getPayment_price() %>원</td>
				<td><%=resList.get(0).getCustomerNeeds() %>원</td>
			</tr>
		</table>
	</div>
<%if(resList.get(0).getReserve_type()>0){ %>
<button style="background-color: gray;" onclick="alert('결제 후 예약하신 고객께서는 취소 후 새로 예약하셔야합니다.')">예약 변경하러 가기</button>
<%}else{ %>
	<button id="editBtn" onclick="location.href='./reserve/modify_reserve.jsp?store_name=<%=resList.get(0).getStoreName()%>&load_address=<%=resList.get(0).getLoadAddress()%>&address=<%=resList.get(0).getAddress()%>&store_number=<%=resList.get(0).getStoreNumber()%>&reserve_code=<%=resList.get(0).getRan_num()%>'">
	예약 변경</button>
<%} %>
<button id="res_cancle_btn">예약 취소</button>
<%
}
%>
</body>
</html>