<%@page import="vo.ReserveBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    
	String id = session.getAttribute("sId").toString();
    
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/reset.css">
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/reserve.css">
<script src="../js/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(function(){
		$('#btnOk').on('click',function(){
			var sendData={
				"reserve_code":$('#reserve_code').text(),
				"store_name":$('#storeName').text(),
				"load_address":$('#loadAddress').text(),
				"address":$('#address').text(),
				"store_number":$('#storeNumber').text(),
				"date":$('#date').val(),
				"reserve_time":$('#time option:selected').text(),
				"people":$('#people option:selected').text(),
				"customerNeeds":$('#customer_needs').val(),
				"setA":$('#setA').val(),
				"setB":$('#setB').val()				
			};
			$.ajax({
				type:"get",
				data:sendData,
				url:"ModiRes.do",
				dataType:"text"
			}).done(function(data) {
				alert('예약이 변경되었습니다');
				location.href='../ReserveList.do';
			}).fail(function() {
				alert('잠시 후에 시도하십시오.')
			});
		});
		
		var date = new Date();
		var yyyy = date.getFullYear();
		var mm = date.getMonth()+1 > 9 ? date.getMonth()+1 : '0' + date.getMonth()+1;
		var dd = date.getDate() > 9 ? date.getDate() : '0' + date.getDate();
		var today = yyyy+"-"+mm+"-"+dd;
		$('#date').val(today);
		
		$('#date').on('change',function(){
			if($('#date').val() < today){
				alert('선택 불가능.');
				$('#date').val(today);
			}
		});
	});
</script>
</head>
<body>
		<!-- 상위 고정 -->
        <jsp:include page="../inc/header.jsp"></jsp:include>
        <!-- 상위 고정 -->
    	<div class="reserve_wrap">
        	<table class = "store_list"> 
        	   <tr><th>예약번호</th><td id="reserve_code"><%=request.getParameter("reserve_code")%></td></tr>
               <tr><th>매장명</th><td id="storeName"><%=request.getParameter("store_name")%></td></tr>
               <tr><th>주소</th><td id="loadAddress"><%=request.getParameter("load_address")%></td></tr>
               <tr><th>도로명주소</th><td id="address"><%=request.getParameter("address")%></td></tr>
               <tr><th>매장번호</th><td id="storeNumber"><%=request.getParameter("store_number")%></td></tr>
       		</table>

           <ul>
		   	   <li><label>예약자명 : </lable><a id="id">${sId }</a></li>
               <li>
                   <label>날짜선택</label>
                   <input type="date"  id="date"  name="date">
               </li>
               <li>
                   <label>시간선택</label>
                   <select name="time" id="time">
                       <option value="">11:00</option>
                       <option value="">12:00</option>
                       <option value="">13:00</option>
                       <option value="">14:00</option>
                       <option value="">15:00</option>
                       <option value="">16:00</option>
                       <option value="">17:00</option>
                       <option value="">18:00</option>
                       <option value="">19:00</option>
                    </select>
                 </li>
                <li>
                    <label>인원선택</label>
                    <select name="people" id="people">
                        <option>1</option>
                        <option>2</option>
                        <option>3</option>
                        <option>4</option>
                        <option>5</option>
                    </select>
                </li>
            </ul>

            <div class = "requirements">
                <p>추가요구사항</p>
                <textarea rows="5" cols="50" id="customer_needs"></textarea>
            </div>
			메뉴(변동 가능성 있음)
        	set A<input type="number" name="setA" id="setA">
        	set B<input type="number" name="setB" id="setB">
            <button id="btnOk" value="확인">예약 변경</button>
     </div>
 </body>
</html>