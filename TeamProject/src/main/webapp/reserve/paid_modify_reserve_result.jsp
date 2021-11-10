<%@page import="java.util.ArrayList"%>
<%@page import="vo.CouponBean"%>
<%@page import="action.payAction"%>
<%@page import="vo.ReserveBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	ReserveBean reserve = (ReserveBean)request.getAttribute("reserveBean");
	//로그인 시 세션으로 저장된 ID
	request.setAttribute("id", reserve.getId());
// 	String id = request.getAttribute("id").toString();
	ArrayList<CouponBean> couponList = (ArrayList<CouponBean>)request.getAttribute("couponList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../js/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(function(){
		$('#paymentBtn2').on('click',function(){
			var sendData = {
				"reserve_user":$('#id').text(),
				"category":$('#category').text(),
				"storeName":$('#storeName').html(),
				"loadAddress":$('#loadAddress').html(),
				"address":$('#address').html(),
				"storeNumber":$('#storeNumber').html(),
				"reserve_date":$('#reserveDate').html(),
				"reserve_time":$('#reserveTime').html(),
				"reserve_people":$('#reserve_people').html(),
				"total_order_menu":$('#totalMenu').html(),
				"reserve_code":$('#reserve_code').text(),
				"reserve_needs":$('#requestList').html(),
				"payment_price":$('#resultPrice').html(),
				"used_coupon_code":$(':input:radio[name=checkCoupon]:checked').next('a').text()
			}
// 			alert(JSON.stringify(sendData));
			$.ajax({
				type:"get",
				data:sendData,
				dataType:"text",
				url:"PaidReserveModify.do",
				error:function(request, status, error){
					console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

				}
			}).done(function(data) {
				 alert('예약 완료!');
// 				 $('#reserve_success').html(data);
				location.href='./ModifySendMessage.do?id='+$('#id').text()+'&store_name='+$('#storeName').html()+'&reserve_date='+$('#reserveDate').html()+'&reserve_time='+$('#reserveTime').html()+'&people='+$('#reserve_people').html()+'&storeNumber='+$('#storeNumber').html();
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
		
		$('#couponBtn').on('click',function(){
//		 	alert($(':input:radio[name=checkCoupon]:checked').val());
			var checkedCouponCode = $(':input:radio[name=checkCoupon]:checked').val();
			$('#discount').html('<a id="discountPrice">'+checkedCouponCode+'</a>');
			
			var totalPrice = $('#totalPrice').text();
			var dcPrice = $('#discountPrice').text();
//		 	alert('totalPrice = ' + totalPrice+'dcPrice = '+dcPrice);
			var total=totalPrice - dcPrice;
			$('#resultPrice').text(total);
		});
		
	
	});
</script>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./css/payForm.css">
    <title>Document</title>
</head>
<body>
    <div class = "store_wrap">
        <div class = "store1">
            <h2>선택한 가게정보</h2>
            <ul>
                <li>
                    <h3>가게명</h3>
                    <span><a id="storeName"><%=reserve.getStoreName() %></a></span>
                </li>
                <li>
                    <h3>도로명주소</h3>
                    <span><a id="loadAddress"><%=reserve.getLoadAddress()%></a></span>
                </li>
                <li>
                    <h3>주소</h3>
                    <span><a id="address"><%=reserve.getAddress() %></a></span>
                </li>
                <li>
                    <h3>번호</h3>
                    <span><a id="storeNumber"><%=reserve.getStoreNumber() %></a></span>
                </li>
            </ul>
        </div>
        <div class = "store2">
            <h2>예약 세부사항</h2>
            <ul>
                <li>
                    <h3>예약날짜</h3>
                    <span><a id="reserveDate"><%=reserve.getReserve_date()%></a></span>
                </li>
                <li>
                    <h3>예약시간</h3>
                    <span><a id="reserveTime"><%=reserve.getReserve_time() %></a></span>
                </li>
                <li>
                    <h3>예약인원</h3>
                    <span><a id="reserve_people"><%=reserve.getPeople() %></a></span>
                </li>
                <li>
                    <h3>메뉴1</h3>
                    <span><a><%=reserve.getSetA()%>인</a></span>
                </li>
                <li>
                    <h3>메뉴2</h3>
                    <span><%=reserve.getSetB()%>인</span>
                </li>
                <li>
                    <h3>메뉴3</h3>
                    <span><%=reserve.getSetC()%>인</span>
                </li>
                <li>
                    <h3>총주문내역</h3>
                    <span><a id="totalMenu"><%=reserve.getTotal_order_menu() %></a></span>
                </li>
                <li>
                    <h3>요청사항</h3>
                    <span><a id="requestList"><%=reserve.getCustomerNeeds() %></a></span>
                </li>
            </ul>
        </div>

        <div class = "coupon">
            <table style="width:852px; border: 1px solid #dbdbdb;">
                <caption>보유한 쿠폰보기</caption>
                <colgroup>
                    <col style = "width: 20%;">
                    <col style = "width: 20%;">
                    <col style = "width: 20%;">
                    <col style = "width: 20%;">
                    <col style = "width: 20%;">
                </colgroup>
                <thead>
                    <tr style= "background-color: #F1F1F1;">
                        <th>쿠폰코드</th>
                        <th>쿠폰명</th>
                        <th>쿠폰내용</th>
                        <th>사용자명</th>
                        <th>발급날짜</th>
                    </tr>
                </thead>
                <tbody>
                <c:choose>
                 <c:when test="${empty couponList }">
                    <tr>
                        <td colspan="5">보유하신 쿠폰이 없습니다.</td>
                    </tr>
                 </c:when>
                 <c:otherwise>
                  <%for(int i =0;i<couponList.size();i++){ 
                  		if(!couponList.get(i).getUsed_code().equals(reserve.getRan_num())&&couponList.get(i).getUsed_code().equals("")){
                  %>
	                    <tr>
	                        <td><input type="radio" name="checkCoupon" value="<%=couponList.get(i).getCoupon_price()%>"><a><%=couponList.get(i).getCoupon_code() %></a></td>
	                        <td><%=couponList.get(i).getCoupon_name() %></td>
	                        <td><%=couponList.get(i).getCoupon_value() %></td>
	                        <td><%=couponList.get(i).getUser_id()%></td>
	                        <td><%=couponList.get(i).getMade_date()%></td>
	                    </tr>
                   <%}
                   }%>
                   <tr>
                   <td colspan="5" align="center"><button id="couponBtn">사용</button></td>
                   </tr>
                  </c:otherwise>
                 </c:choose>
                </tbody>
            </table>
        </div>

        <div class = "amount">
            <table style="width:852px; border: 1px solid #dbdbdb;">
                <caption>결제금액</caption>
                <colgroup>
                    <col style = "width: 25%;">
                    <col style = "width: 25%;">
                    <col style = "width: 25%;">
                    <col style = "width: 25%;">
                </colgroup>
                <%
			int aPrice = 9000;
			int bPrice = 10000;
			int cPrice = 11000;
			int totalAPrice = aPrice * reserve.getSetA();
			int totalBPrice = bPrice * reserve.getSetB();
			int totalCPrice = cPrice * reserve.getSetC();
			int totalPrice = totalAPrice + totalBPrice + totalCPrice;
			%>
                <thead>
                    <tr style= "background-color: #F1F1F1; border: 1px solid #F1F1F1;">
                        <th>총 결제금액</th>
                        <th>총 할인금액</th>
                        <th>결제예정금액</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td id="totalPrice"><%=totalPrice %></td>
                        <td id="discount">0</td>
                        <td id="resultPrice"><%=totalPrice %></td>
                        <td class="btnSet">
                        <button id="kakaopay">카카오페이</button>
                        <button disabled="disabled" style="background-color: gray;" value="0" id="paymentBtn2">결제완료</button>
                        </td>
                        
                    </tr>
                </tbody>
            </table>
        </div>
        
    </div>
</body>
</html>