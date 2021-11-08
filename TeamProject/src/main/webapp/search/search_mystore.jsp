<%@page import="vo.SearchBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Matzip</title>
<link rel="stylesheet" href="./css/reset.css">
<link rel="stylesheet" href="./css/header.css">
<link rel="stylesheet" href="./css/search_mystore2.css">
<script src="../js/jquery-3.6.0.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<%
	SearchBean search=(SearchBean)request.getAttribute("search");
%>
<script type="text/javascript">
	$(document).ready(function(){
		$("#btnMody").on('click',function(){
			location.href="MatzipModify.mz"
		});
		
		$("#btnCheck").on('click',function(){
			var sendData = {
					"store_name" : $('#store_name').text(),
					"load_address" : $('#load_address').text(),
					"address" : $('#address').text(),
					"store_number" : $('#store_number').text(),
					"category" : $('#category').text()
		});
	});


</script>
</head>
<body>
	<div id="wrap">
		<jsp:include page="../inc/header.jsp"></jsp:include>
		<!-- 상위 고정 -->
		<hr>
		<div id="storeInsert">
			<strong>매장 정보</strong>
			<hr>
			<div class="clear"></div>
			<img src="./upload/<%=search.getLogo_img()%>" id="storeLogo">
			<div id="storeInfo">
				<table>
					<tr>
						<th>매장명</th>
						<td><%=search.getPlace_name() %></td>
					</tr>
					<tr>
						<th>사업자 등록번호</th>
						<td><%=search.getBusiness_lisence() %></td>
					</tr>
					<tr>
						<th>업종</th>
						<td><%=search.getCategory()%></td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td><%=search.getTell_number() %></td>
					</tr>
					<tr>
						<th>주소</th>
						<td><%=search.getRoad_address() %> (<%=search.getJibun_address() %>)
						</td>
					</tr>
				</table>
				<input type="button" value="정보수정" id="btnMody"> 
				<input type="button" value="예약확인" id="btnCheck">
			</div>
			<hr>
		</div>
	</div>
</body>
</html>