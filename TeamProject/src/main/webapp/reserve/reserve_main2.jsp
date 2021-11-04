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
    String category = "정보가 없습니다";
  	if(storeInfo!=null){
    	storeName = storeInfo.get(0).getPlace_name();
    	loadAddress = storeInfo.get(0).getRoad_address();
    	address = storeInfo.get(0).getJibun_address();
    	storeNumber = storeInfo.get(0).getTell_number();
    	category = storeInfo.get(0).getCategory();
    	
    	request.setAttribute("storeName", storeName);
    	request.setAttribute("loadAddress", loadAddress);
    	request.setAttribute("address", address);
    	request.setAttribute("storeNumber", storeNumber);
    	request.setAttribute("category", category);
  	}
  	
  	
    //세션에 저장된  id로 가정
    String id = null;
    id = session.getAttribute("sId").toString();
    if(id!=null){
    	request.setAttribute("id", id);
    }else{
    	response.sendRedirect("./MemberLoginFormAction.do");
    }
    %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/reserve_sub.css">
    <title>Document</title>
    <script src="https://ajax.googleapis.com/ajax/libs/webfont/1.6.26/webfont.js"></script>
    <script>
    WebFont.load({
        google: {
        families: ['Roboto', 'sans-serif']
        }
    });
    </script>
</head>
<body>
    <div class = "reserve_wrap">
        <div class = "store_info">
            <div>
                <h2>매장명</h2> 
                <span id="storeName"><%=storeName %></span>
            </div>
            <div>
                <h2>주소</h2>
                <span id="address"><%=address %></span>
            </div>
            <div>
                <h2>도로명주소</h2>
                <span id="loadAddress"><%=loadAddress %></span>
            </div>
            <div>
                <h2>전화번호</h2>
                <span id="storeNumber"><%=storeNumber %></span>
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
                <h3>메뉴1</h3>
                <input type="number" value="0" name="setA" id="setA" min="0"> 
            </li>
            <li>
                <h3>메뉴2</h3>
                <input type="number" value="0" name="setB" id="setB" min="0">
            </li>
            <li>
                <h3>메뉴3</h3>
                <input type="number"  value="0" name="setC" id="setC" min="0">
            </li>
        </ul>
        
        <div class = "payment">
            <div>
                <label for="">선결제</label>
                <input type="radio" name="payment" value="1" checked="checked">
            </div>
            <div>
                <label for="">현장결제</label>
                <input type="radio" name="payment" value="0">
            </div>
        </div>
        <button id="btnOk" value="확인">예약하기</button>
    </div>
</body>
</html>