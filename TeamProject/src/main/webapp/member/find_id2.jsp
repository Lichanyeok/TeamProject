<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="/TeamProject/css/login.css">
    <link rel="stylesheet" href="/TeamProject/css/header.css">
	<link rel="stylesheet" href="/TeamProject/css/reset.css">
</head>
<body>
	<!-- 상위 고정 -->
     <jsp:include page="../inc/header.jsp"></jsp:include>
    <!-- 상위 고정 -->

    <section>
        <form action="FindId.do" method="post">

            <br>
            <div class="login_wrap">
                <div class="login_input">
                    <div>
	                    <label>이름</label>
	                    <input type="text" placeholder="name" name="name">
	                </div>
	                <div>
	                    <label>이메일</label>
	                    <input type="text" placeholder="email" name="email">
	                </div>
	            </div>
            </div>
		            <div class ="login_btn">
		 				<button type="submit" >로그인</button>
		            </div>
		</form>
    </section>
</body>
</html>