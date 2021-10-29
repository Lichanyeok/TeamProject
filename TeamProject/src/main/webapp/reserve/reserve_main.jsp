<%@page import="vo.SearchBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    ArrayList<SearchBean> storeInfo = (ArrayList<SearchBean>)session.getAttribute("storeInfo");
  	String storeName = "정보가 없습니다";
    String loadAddress = "정보가 없습니다";
    String address = "정보가 없습니다";
    String storeNumber = "정보가 없습니다";
  	if(storeInfo!=null){
    	storeName = storeInfo.get(0).getPlace_name();
    	loadAddress = storeInfo.get(0).getRoad_address();
    	address = storeInfo.get(0).getJibun_address();
    	storeNumber = storeInfo.get(0).getTell_number();
    	
    	request.setAttribute("storeName", storeName);
    	request.setAttribute("loadAddress", loadAddress);
    	request.setAttribute("address", address);
    	request.setAttribute("storeNumber", storeNumber);
  	}
  	
  	
    //세션에 저장된  id로 가정
    String id = session.getAttribute("sId").toString();
    request.setAttribute("id", id);
   
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/reserve.css">
<script src="./js/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(function(){
		$('#btnOk').on('click',function(){
// 			alert($('input[type=radio]:checked').val());
			var info = {
					"storeName":$('#storeName').text(),
					"loadAddress":$('#loadAddress').text(),
					"address":$('#address').text(),
					"storeNumber":$('#storeNumber').text(),
					"id":$('#id').text(),
					"date":$('#date').val(),
					"time":$('#time option:selected').text(),
					"people":$('#people option:selected').text(),
					"customerNeeds":$('#customer_needs').val(),
					"setA":$('#setA').val(),
					"setB":$('#setB').val()	,
					"reserve_type":$('input[type=radio]:checked').val()
			};
// 			alert(JSON.stringify(info));
			if($('input[type=radio]:checked').val() > 0){
				$.ajax({
					type: "GET",
					data:info,
					dataType: "text",
					url:"Payment.do"
				}).done(function(data) {
					$('#result').html(data);
// 					alert('예약 완료!');
				}).fail(function() {
					alert('죄송합니다 조금 후에 이용해주세요');
				});
			}else{
				$.ajax({
					type: "GET",
					data:info,
					dataType: "text",
					url:"Payment.do"
				}).done(function(data) {
					location.href='ReserveList.do';
				}).fail(function() {
					alert('죄송합니다 조금 후에 이용해주세요');
				});
			}
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
               <tr><th>매장명</th><td id="storeName"><%=storeName %></td></tr>
               <tr><th>주소</th><td id="loadAddress"><%=loadAddress %></td></tr>
               <tr><th>도로명주소</th><td id="address"><%=address %></td></tr>
               <tr><th>매장번호</th><td id="storeNumber"><%=storeNumber%></td></tr>
           </table>

           <ul>
		<li>
		<label>예약자명</lable>
		<a id="id">${id }</a>
		</li>
               <li>
                   <label>날짜선택</label>
                   <input type="date"  id="date"  min="">
               </li>
               <li>
                   <label>시간선택</label>
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
                 </li>
                <li>
                    <label>인원선택</label>
                    <select id="people">
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
        	set A<input type="number" value="setA" name="setA" id="setA">
        	set B<input type="number"  value="setB" name="setB" id="setB">
            <div class = "payment_group">
            <input type="radio" name="payment" value="1" checked="checked"><label>선결제</label>
           <input type="radio" name="payment" value="0"><label>현장결제</label>
            </div>

            <button id="btnOk" value="확인">예약하기</button>
     </div>
     <div id="result"></div>
 </body>
</html>