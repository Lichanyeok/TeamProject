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
<link rel="stylesheet" href="./css/reset.css">
<link rel="stylesheet" href="./css/header.css">
<link rel="stylesheet" href="./css/reserve_main2.css">
<script src="./js/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(function(){
		$('#btnOk').on('click',function(){
			var sendData={
				"reserve_id":$('#id').text(),
				"category":$('#category').text(),
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
				location.href='./ModifySendMessage.do?id='+$('#id').text()+'&store_name='+$('#storeName').text()+'&reserve_date='+$('#date').val()+'&reserve_time='+$('#time option:selected').text()+'&people='+$('#people option:selected').text()+'&storeNumber='+$('#storeNumber').text();
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
		var menu1 = "";
		var menu2 = "";
		var menu3 = "";
		
		var category = $('#category').text();
		if(category=="한식") {
			menu1="제육덮밥";
			menu2="김치찌개";
			menu3="삼겹살";
		}else if(category=="양식") {
			menu1="파스타";
			menu2="피자";
			menu3="샐러드";
		}else if(category=="중식") {
			menu1="짜장면";
			menu2="짬뽕";
			menu3="탕수육";
		}else if(category=="일식") {
			menu1="소바";
			menu2="초밥";
			menu3="텐동";
		}else if(category=="치킨") {
			menu1="로제크림치킨";
			menu2="갈릭간장치킨";
			menu3="크리스피치킨";
		}else if(category=="피자") {
			menu1="블랙앵거스 스테이크 피자";
			menu2="블랙타이거 쉬림프 피자 ";
			menu3="뉴욕오리진 피자";
		}else if(category=="퓨전") {
			menu1="김치주스";
			menu2="마늘전";
			menu3="불고기파스타";
		}else if(category=="찜") {
			menu1="아구찜";
			menu2="통큰 뼈 찜";
			menu3="해물 뼈 찜";
		}else if(category=="고깃집") {
			menu1="삼겹살";
			menu2="목살";
			menu3="돼지갈비";
		}else if(category=="족발") {
			menu1="오리지날 한방 족발";
			menu2="연잎 보쌈";
			menu3="불족발";
		}else if(category=="뷔페") {
			menu1="런치 샐러드바 1인";
			menu2="런치 샐러드바&스테이크 2인";
			menu3="디너 샐러드바 1인";
		}else if(category=="코스요리") {
			menu1="런치 샐러드바 1인";
			menu2="런치 샐러드바&스테이크 2인";
			menu3="디너 샐러드바 1인";
		}else {
			menu1="모듬사시미";
			menu2="런치세트A";
			menu3="런치세트B";
		};
		$('#menu1').html(menu1);
		$('#menu2').html(menu2);
		$('#menu3').html(menu3);
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
                <h2>카테고리</h2>
                <span id="category"><%=request.getParameter("category") %></span>
            </div>
            <div>
                <h2>예약번호</h2>
                <span id="reserve_code"><%=request.getParameter("reserve_code") %></span>
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
      
        <button id="btnOk" value="확인">변경하기</button>
    </div>
 </body>
</html>