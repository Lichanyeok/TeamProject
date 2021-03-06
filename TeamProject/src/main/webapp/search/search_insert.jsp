<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Matzip</title>
<link rel="stylesheet" href="./css/reset.css">
<link rel="stylesheet" href="./css/header.css">
<link rel="stylesheet" href="./css/search_insert2.css">
<script src="./js/jquery-3.6.0.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function checkForm(){
	var business_lisence_check=/^[0-9]{10}$/;
	var tell_number_check=/^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$/;
	if(!business_lisence_check.exec(document.getElementById("business_lisence").value)){
		
		return false;
	}
	if(!tell_number_check.exec(document.getElementById("tell_number").value)){
		
		return false;
	}
	return true;
} 

	window.onload = function () {
    document.getElementById("road_address").addEventListener("click", function () {
        new daum.Postcode({
            oncomplete: function (data) {
                document.getElementById("road_address").value = data.roadAddress;
                document.getElementById("jibun_address").value = data.jibunAddress;                    
            }
        }).open();
    });
 }


	$(document).ready(function() {

		$("input#tell_number").blur(function() {

			var num = $("#tell_number").val();

			blur(num)

		});

		$("input#tell_number").click(function() {

			var num = $("#tell_number").val();

			focus(num);

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
		if(num.length==10){
			tmp += num.substr(3,3); 
			tmp +='-';
	
			tmp += num.substr(6);
			
		}else if(num.length==11){
			tmp += num.substr(3,4);
			tmp +='-';
			
			tmp += num.substr(7);
		}
		$("#tell_number").val(tmp);

	}
	
	
</script>
</head>
<body>
	<div id="wrap">
		<jsp:include page="../inc/header.jsp" ></jsp:include>
		<!-- ?????? ?????? -->
		<hr>
			<div id="storeInsert">
			<form action="./MatzipListInsert.mz" method="post" enctype="multipart/form-data" onsubmit="return checkForm()">				
				<strong>????????? ??????????????????!</strong>
	            <p>??????????????? ??????????????????    *(????????????)</p>
	            <table>	              	
	                <tr>
	                    <th>*?????????</th>
	                    <td><input type="text" id="place_name" name="place_name" required="required"></td>
	                </tr>
	                <tr>
	                    <th>*????????? ????????????</th>
	                    <td><input type="text" id="business_lisence" name="business_lisence" placeholder="- ?????? ?????? 10??????" required="required"></td>
	                </tr>
	                <tr>
	                    <th>*??????</th>
	                    <td>
	                    	<select id="category" name="category">								
								<option>??????</option>
								<option>??????</option>   
								<option>??????</option>
								<option>??????</option>
								<option>??????</option>
								<option>??????</option>
								<option>??????</option>
								<option>???</option>
								<option>?????????</option>
								<option>??????</option>
								<option>??????</option>
								<option>????????????</option>                	
	                    	</select>
	                    
	                    </td>	
	                </tr>	                
	                <tr>
	                    <th>*????????????</th>
	                    <td><input type="text" name="tell_number" id="tell_number" required="required"></td> 
	                </tr>
	                <tr>
	                    <th>*??????</th>
	                    <td><input type="text" readonly="readonly" id="road_address" name="road_address" required="required" style="width: 300px;">
	                    <input type="text" readonly="readonly" id="jibun_address" name="jibun_address" required="required" style="width: 300px;"></td>	                   
	                </tr>
	                <tr>
	                    <th>?????? ??????</th>
	                    <td><input type="file" name="logo" id="logo"></td> 
	                </tr>
	              
	            </table>
	            <input type="submit" value="????????????">
			</form>
		</div>
	</div>
</body>
</html>