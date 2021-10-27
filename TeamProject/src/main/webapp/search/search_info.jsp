<%@page import="vo.SearchBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
SearchBean article = (SearchBean)request.getAttribute("article");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/TeamProject/css/test.css">
<link rel="stylesheet" href="/TeamProject/css/reset.css">
<link rel="stylesheet" href="/TeamProject/css/header.css">
</head>
<body>
<form action="">
	<nav>
		<jsp:include page="../inc/header.jsp"></jsp:include>
	</nav>

<div id="item">
    <div class="item_detail">
        <ul class="item_detail_left">
            <li>
                <img src="./search/img/pizzaHut.png">
            </li>
        </ul>
        <ul id="item_detail_right">
            <li class="item_txt">
                <p>[ Matzip ]</p>
                <div>
                    <h2><%=article.getPlace_name()%></h2>
                    <br><br>
                </div>
            </li>
            <li id="benefit">
                <p>상세 내용</p>
                <br>
                <ul>
                    <li>
                        <p>주소</p>
                        <p><%=article.getRoad_address()%></p>
                    </li>
                    <li>
                        <p>지번</p>
                        <p><%=article.getJibun_address()%></p>
                    </li>
                    <li>
                        <p>번호</p>
                        <p><%=article.getTell_number()%></p>
                    </li>
                </ul>
                <br><br>
            </li>
            
            <li id="order_item">
                <button type="button">장바구니</button>
                <button type="submit">예약하기</button>
                
            </li>
        </ul>
    </div>
    </div>
</form>
</body>
</html>