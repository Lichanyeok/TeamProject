<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="./css/login.css">
    <link rel="stylesheet" href="./css/header.css">
	<link rel="stylesheet" href="./css/reset.css">
</head>
<body>
	<!-- 상위 고정 -->
     <jsp:include page="../inc/header.jsp"></jsp:include>
    <!-- 상위 고정 -->

    <section>
        <form action="FindPass.do" method="post">
            <br>
            <div class="login_wrap">
                <div class="login_input">
                    <div>
	                    <label>아이디</label>
	                    <input type="text" placeholder="id" name="id">
	                </div>
	                <div>
	                    <label>이메일</label>
	                    <input type="text" placeholder="email" name="email">
	                </div>
	            </div>
            </div>
		            <div class ="login_btn">
		 				<button type="submit" >찾기</button>
		            </div>
		</form>
    </section>
</body>
</html>