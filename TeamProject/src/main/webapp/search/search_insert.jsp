<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Matzip</title>
<link rel="stylesheet" href="/TeamProject/css/reset.css">
<link rel="stylesheet" href="/TeamProject/css/header.css">
<link rel="stylesheet" href="./css/search_insert.css">
<script src="./js/jquery-3.6.0.js"></script>
<!-- <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> -->
<script>
	$(document).ready(function() {

		$("input#tell_number").blur(function() {

			var num = $("#tell_number").val();

			blur(num)

		});

		$("input#tell_number").click(function() {

			var num = $("#tell_number").val();

			focus(num);

		});
		
		$("#business_lisence").on('click',function(){
			alert('aaa');
		});

	});

	function focus(num) {

		num = num.replace(/[^0-9]/g, '');

		$("#tell_number").val(num);

	}

	function blur(num) {

		num = num.replace(/[^0-9]/g, '');

		var tmp = '';

		tmp += num.substr(0, 3);

		tmp += '-';

		tmp += num.substr(3, 4);

		tmp += '-';

		tmp += num.substr(7);

		$("#tell_number").val(tmp);

	}
	
	function checkForm(){
		alert("aaa");
		return true;
	} 
</script>
</head>
<body>
	<div id="wrap">
		<jsp:include page="../inc/header.jsp" ></jsp:include>
		<!-- 상위 고정 -->
		<hr>
			<div id="storeInsert">
			<form action="./MatzipListInsert.mz" method="post" enctype="multipart/form-data" onsubmit="return checkForm()">				
				<strong>매장을 등록해보세요!</strong>
	            <p>매장정보를 입력해주세요</p>
	            <table>	              	
	                <tr>
	                    <th>매장명</th>
	                    <td><input type="text" id="place_name" name="place_name" required="required"></td>
	                </tr>
	                <tr>
	                    <th>사업자 등록번호</th>
	                    <td><input type="text" id="business_lisence" name="business_lisence" placeholder="- 제외 숫자 10자리" required="required"></td>
	                </tr>
	                <tr>
	                    <th>업종</th>
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
	                    <th>전화번호</th>
	                    <td><input type="text" name="tell_number" id="tell_number" required="required"></td> 
	                </tr>
	                <tr>
	                    <th>주소</th>
	                    <td><input type="text" readonly="readonly" id="road_address" name="road_address">
	                    <input type="text" id="jibun_address" name="jibun_address" required="required"></td>	                   
	                </tr>
	                <tr>
	                    <th>로고 등록</th>
	                    <td><input type="file" name="logo" id="logo"></td> 
	                </tr>
	              
	            </table>
	            <input type="submit" value="업체등록">
			</form>
		</div>
	</div>
</body>
</html>