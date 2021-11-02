<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    request.setCharacterEncoding("utf-8");
    String sId = session.getAttribute("sId").toString();
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit or Remove</title>
<style type="text/css">
/* modi_res_wrap */
*{
    margin: 0;
    padding: 0;
}

.store_list tr {
    display: block;
    text-align: center;
    margin: 10px 0;
}

.store_list tr th {
    width: 170px;
    font-size: 16px;
    font-weight: 900;
}

.store_list tr  td {
    font-size:15px;
    
}

#store_list {
	text-align: center;
	width: 240px;
	margin : 40px auto;
	border: 1px solid #444444;
}

#btnOk {
    margin-top: 30PX;
    border: none;
    width: 144px;
    height: 30px;
    font-weight: 500;
    color: #fff;
    background-color: #FF8831;
}



.reserve_wrap{
position: absolute;
display:block;
width: 1206px;
height: 216px;
left: 113px;
top: 167px;
background: #FFFFFF;
margin-top: 0px;
padding: 0px;

}


/* Frame 2 */


/* Auto Layout */
.reserve_wrap #choice_area{
display: flex;
flex-direction: row;
align-items: center;
padding: 0px;
position: absolute;
width: 800px;
height: 216px;
left: 519px;
top: 167px;
margin:0px;
background: #FFFFFF;
outline: 2px solid #FF8831;
}

#choice_area h1{
 font-size: 30px;
 font-weight:bold;
 margin: auto;
}

/* Auto Layout */
.reserve_wrap .form_wrap{
display: flex;
flex-direction: row;
align-items: center;
padding: 0px;
position: absolute;
width: 406px;
height: 216px;
left: 113px;
top: 167px;
background: #FFFFFF;
margin: 0px;
outline: 2px solid #FF8831;
}
</style>
<script src="./js/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(function(){
		$('#btnOk').on('click',function(){
// 			alert('쳌');
			var sendInfo = {
				"id":$('#id').val(),
				"pass":$('#pass').val(),
				"reserve_code":$('#reserve_code').val()
			};
			
			$.ajax({
				type: "GET",
				data: sendInfo,
				dataType: "text",
				url:"CheckReserveInfo.do"
			}).done(function(data) {
				$('#choice_area').html(data);
			}).fail(function() {
				
			});
		});
	});
</script>
</head>
<body>
		<!-- 상위 고정 -->
        <jsp:include page="../inc/header.jsp"></jsp:include>
        <!-- 상위 고정 -->
        
         <div class="reserve_wrap">
	          	<div class="form_wrap">
	           	<table class = "store_list"> 
	           	   <tr>
		               <th>아이디</th>
		               <td><input type="text" id="id" name="id" value="<%=sId%>" readonly="readonly"></td>
	               </tr>
	               <tr>
		               <th>비밀번호</th>
		               <td><input type="password" id="pass" name="pass"></td>
	               </tr>
	               <tr>
		               <th>예약번호</th>
		               <td><input type="text" id="reserve_code" name="reserve_code"></td>
	               </tr>
	               <tr><th colspan="2"><button id="btnOk">확인</button></th></tr>
	           </table>
	          </div>
		  <div id="choice_area">
		  	<h1>예약번호를 입력 후 확인버튼을 눌러주세요</h1>
		  </div>
         </div>
</body>
</html>