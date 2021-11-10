<%@page import="com.mysql.fabric.proto.xmlrpc.ResultSetParser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/customer2.css">
<title>Insert title here</title>
</head>
<script src="./js/jquery-3.6.0.js"></script>
<script type="text/javascript">	
// 	var textarea = document.getElementById("#textContext");

		$(document).ready(function() {
			$("#chk").on("click", function(){
// 				alert($("#chk").prop("checked")); // chk의 체크 여부를 확인함
					$("#ischk").val($("#chk").prop("checked"))  // 체크 값 저장 (true, false)
				// ischk의 value값에 chk의 체크여부 값을 저장함
			});
			
// 			$("#submit").on("click", function(){
// 					alert($("#textContext").val())
// 				if($("#textContext").val()==""){
// 					alert("내용을 입력하세요");
// 				}else{
// 					alert("등록성공");
// 					location.href='WriteFormPro.do';
// 				}
// 			})
			
		})
		
		
</script>

<body>
<jsp:include page="/inc/header.jsp"></jsp:include>
	 <div class = "customer_write">
      <h2>게시판 글 등록</h2>
      <form action="WriteFormPro.do" method="post" name="boardForm">
     	 <div class = "write">
	      	<input type="hidden" id="ischk" name="ischk" value=" " >
	         <input type="hidden" value="<%=session.getAttribute("sId") %>" name="id">
	         
	          <h3>작성자 : <%=session.getAttribute("sId") %></h3>  
	          
	          <div> 
	          		 제목  <input type="text" name="subject" required="required">
	           		 <textarea rows="40" cols="40" name="content" id="textContext" required="required"></textarea>
	          </div>
	         	<label for="secrit">비밀글</label>
	         	<input type="checkbox" id="chk">
	         	<div class ="input_item">
		            <input type="submit" value="등록" id="submit">&nbsp;&nbsp;
		            <input type="reset" value="다시쓰기">
		            <input type="button" value="취소" onclick="history.back()">
	            </div>
            </div>
      </form>
      </div>
</body>
</html>