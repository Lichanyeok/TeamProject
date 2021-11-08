<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Matzip</title>
<link rel="stylesheet" href="./css/reset.css">
<link rel="stylesheet" href="./css/header.css">
<link rel="stylesheet" href="./css/search_insert.css">
<script src="../js/jquery-3.6.0.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	$(document).ready(function)_{
		
		$('#go_reserve_btn').on('click', function() {
			
		});
	});	
	
</script>
</head>
<body>
	<div id="wrap">
		<jsp:include page="../inc/header.jsp" ></jsp:include>
		<!-- 상위 고정 -->
		<hr>
			<div id="storeInsert">
			<form action="./MatzipModifyPro.mz" method="post" enctype="multipart/form-data" onsubmit="return checkForm()">				
				<strong>매장정보 수정</strong>
	            <p>*(필수항목)</p>
	            <table>	              	
	                <tr>
	                    <th>*매장명</th>
	                    <td><input type="text" id="place_name" name="place_name" required="required"></td>
	                </tr>
	                <tr>
	                    <th>*사업자 등록번호</th>
	                    <td><input type="text" id="business_license" name="business_license" placeholder="- 제외 숫자 10자리" required="required"></td>
	                </tr>
	                <tr>
	                    <th>*업종</th>
	                    <td>
	                    	<select id="category" name="category">								
								<option>한식</option>
								<option>양식</option>
								<option>중식</option>
								<option>일식</option>
								<option>치킨</option>
								<option>피자</option>
								<option>퓨전</option>
								<option>찜</option>
								<option>고깃집</option>
								<option>족발</option>
								<option>뷔페</option>
								<option>코스요리</option>                	
	                    	</select>
	                    
	                    </td>	
	                </tr>	                
	                <tr>
	                    <th>*전화번호</th>
	                    <td><input type="text" name="tell_number" id="tell_number" required="required"></td> 
	                </tr>
	                <tr>
	                    <th>*주소</th>
	                    <td><input type="text" readonly="readonly" id="road_address" name="road_address" required="required">
	                    <input type="text" id="jibun_address" name="jibun_address" required="required"></td>	                   
	                </tr>
	                <tr>
	                    <th>로고 등록</th>
	                    <td><input type="file" name="logo" id="logo"></td> 
	                </tr>
	              	
	            </table>
	            <input type="submit" value="정보수정">
			</form>
<!-- 			<input type="button" id="aa"value="aa" onclick="aa()">  -->
			
			</div>
	</div>
</body>
</html>