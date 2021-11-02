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
<link rel="stylesheet" href="css/reserve.css">
</head>
<body>
		<!-- 상위 고정 -->
        <jsp:include page="../inc/header.jsp"></jsp:include>
        <!-- 상위 고정 -->
          <div class="reserve_wrap">
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
		   <div id="choice_area">
			  
		   </div>
          </div>
</body>
</html>