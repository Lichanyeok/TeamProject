<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Matzip</title>
<link rel="stylesheet" href="/TeamProject/css/reset.css">
<link rel="stylesheet" href="/TeamProject/css/header.css">
<link rel="stylesheet" href="../css/search_insert2.css">
<script src="../js/jquery-3.6.0.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

</head>
<body>
	<div id="wrap">
		<jsp:include page="../inc/header.jsp"></jsp:include>
		<!-- 상위 고정 -->
		<hr>
			<div id="storeInsert">
			<form action="" method="post">
				<strong>맛집 회원이 되어보세요!</strong>
	            <p>회원정보를 입력해주세요</p>
	            <table>
	              	<tr>
	                    <th>업주명</th>
	                    <td><input type="text" id="place_name" name="place_name"></td>
	                </tr>
	                <tr>
	                    <th>업체명</th>
	                    <td><input type="text" id="place_name" name="place_name"></td>
	                </tr>
	                <tr>
	                    <th>업종</th>
	                    <td><input type="text" name="category" id="cetegory" ></td>	
	                </tr>	                
	                <tr>
	                    <th>전화번호</th>
	                    <td><input type="text" name="tell_number" id="tell_number"></td> 
	                </tr>
	                <tr>
	                    <th>주소</th>
	                    <td><input type="text" readonly="readonly" id="road_address" name="road_address">
	                    <input type="text" id="jibun_address" name="jibun_address"></td>	                   
	                </tr>
	              
	            </table>
	            <input type="submit" value="업체등록">
			</form>
		</div>
	</div>
</body>
</html>