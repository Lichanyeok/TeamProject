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
<link rel="stylesheet" href="../css/reserve_main.css">
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
				"setB":$('#setB').val(),
				"setC":$('#setC').val()
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
    	<div class = "reserve_wrap">
        <div class = "store_info">
        	<div>
                <h2>예약자명</h2> 
                <span id="id"><%=id %></span>
            </div>
            <div>
                <h2>매장명</h2> 
                <span id="storeName"><%=request.getParameter("store_name") %></span>
            </div>
            <div>
                <h2>주소</h2>
                <span id="address"><%=request.getParameter("address") %></span>
            </div>
            <div>
                <h2>도로명주소</h2>
                <span id="loadAddress"><%=request.getParameter("load_address")  %></span>
            </div>
            <div>
                <h2>전화번호</h2>
                <span id="storeNumber"><%=request.getParameter("store_number") %></span>
            </div>
            <div>
                <h2>예약번호</h2>
                <span id="category"><%=request.getParameter("reserve_code") %></span>
            </div>
        </div>

        <div class="date_time">
            <div>
                <label for="">날짜선택</label>
                <input type="date"  id="date" >
            </div>
            <div>
                <label for="">시간선택</label>
                <select name="" id="time">
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
            </div>
            <div>
                <label for="">인원선택</label>
                <select id="people">
                        <option>1</option>
                        <option>2</option>
                        <option>3</option>
                        <option>4</option>
                        <option>5</option>
                </select>
            </div>
        </div> 

        

        <div class = "add_info">
            <h2>추가사항</h2>
            <textarea name="customer_needs" id="customer_needs" cols="30" rows="10"></textarea>
        </div>

        <h2 class = "menu_font">메뉴</h2>
        <ul class = "menu">
            <li>
                <h3 id="menu1">메뉴1</h3>
                <input type="number" value="0" name="setA" id="setA" min="0"> 
            </li>
            <li>
                <h3 id="menu2">메뉴2</h3>
                <input type="number" value="0" name="setB" id="setB" min="0">
            </li>
            <li>
                <h3 id="menu3">메뉴3</h3>
                <input type="number"  value="0" name="setC" id="setC" min="0">
            </li>
        </ul>
      
        <button id="btnOk" value="확인">예약하기</button>
    </div>
 </body>
</html>