<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>join</title>
<style>
	button{
    margin: 60px auto;
    font-size: 13px;
    font-weight: 400;
    color: #fff;
    display: block;
    background-color: var(--main-color);
    border: none;
    width: 174px;
    height: 36px;
}
</style>
<link rel="stylesheet" href="../css/join.css">
<link rel="stylesheet" href="../css/login.css">
<script src="../js/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(function(){
		$('#btnGo').on('click',function(){
// 			alert('gd');
			var sendData = {
					"id":$('#id').val(),
					"email":$('#email').val()
			};
			alert(JSON.stringify(sendData))
			$.ajax({
				type:"get",
				data:sendData,
				dataType:"text",
				url:"FindPass.do"
			}).done(function(data) {
				alert('성공');
				$('#result').html(data);
			}).fail(function(){
				alert('실패');
			});
		});
	})
</script>
    
</head> 
<body>
		<!-- 상위 고정 -->
        <jsp:include page="../inc/header.jsp"></jsp:include>
        <!-- 상위 고정 -->
    <section>
         <h1><a href="#"><img alt="" src="../images/LOGO.png"></a></h1>
            <div class="login_wrap">
            <div class="login_input">
                <div>
                    <label>아이디</label>
                    <input type="text" id="id">
                </div>
                <div>
                    <label>이메일</label>
                    <input type="text" id="email">
                </div>
 				<button id="btnGo" >확인</button>
            </div>
            </div>
   		
   		<aside id="result">
   			<h3>검색 결과</h3>
   		</aside>
    </section>
</body>
</html>