<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%
    /*
    만약 가게 정보들을 String 타입 배열로 받아온다 친다 가정
    request 객체로 받아서 배열로 저장 후 각자의 값 꺼냄
    */
    String[] storeArr = {"새마을식당","김해시 인제로 167번길","경상남도 김해시 어방동 106동","051-333-4444"};
    String storeName = storeArr[0];
    String loadAddress = storeArr[1];
    String address = storeArr[2];
    String storeNumber = storeArr[3];
    %>
<!DOCTYPE html>
<link rel="stylesheet" href="../css/reserve.css">
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/style.css">
<script src="./js/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(function(){
		$('#btnOk').on('click',function(){
// 			alert($('input[type=radio]:checked').val());
			if($('input[type=radio]:checked').val() > 0){
				$.ajax({
					type: "GET",
					data: {
						"storeName":storeName,
						"loadAddress":loadAddress,
						"address":address,
						"storeNumber":storeNumber,
						"date":$('#date').val(),
						"time":$('#time option:selected').text(),
						"people":$('#people option:selected').text(),
						"customerNeeds":$('#customer_needs').val()
					},
					dataType: "text",
					url:"Payment.do"
				}).done(function(data) {
					$('#result').html(data);
				})
			}else{
				alert('결제방식을 선택해주세요');
			}
		});
	});
</script>
</head>
<body>
		<!-- 상위 고정 -->
        <jsp:include page="/inc/header.jsp"></jsp:include>
        <!-- 상위 고정 -->
        <div id="reserve_list">
<!--         	<h3>예약 상세정보 작성</H3> -->
<!--         	<H3>넘어온 가게 정보</H3> -->
	        <form>
	        	<ul id="store_list">
	        		<li id="storeName"><%=storeName %></li>
	        		<li id="loadAddress"><%=loadAddress %></li>
	        		<li id="address"><%=address %></li>
	        		<li id="storeNumber"><%=storeNumber%></li>
	        	</ul>
	        	날짜 선택
	        	<input type="date"  id="date">
	        	시간 선택
	        	<select id="time">
	        		<option>11:00</option>
	        		<option>12:00</option>
	        		<option>13:00</option>
	        		<option>14:00</option>
	        		<option>15:00</option>
	        		<option>16:00</option>
	        		<option>17:00</option>
	        		<option>18:00</option>
	        		<option>19:00</option>
	        	</select>
	        	인원선택
	        	<select id="people">
	        		<option>1</option>
	        		<option>2</option>
	        		<option>3</option>
	        		<option>4</option>
	        		<option>5</option>
	        	</select>
	        	추가요구사항
	        	<textarea rows="5" cols="10" id="customer_needs"></textarea>
	        	결제여부
	        	<input type="radio" name="payment" value="1" checked="checked">선결제
	        	<input type="radio" name="payment" value="0">직접결제
	        	<button id="btnOk" value="확인">확인</button>
	        </form>
        </div>
        <div id="result"></div>
</body>
</html>