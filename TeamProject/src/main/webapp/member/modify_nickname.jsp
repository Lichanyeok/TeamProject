<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String nickName = session.getAttribute("sNn").toString();
	String id = session.getAttribute("sId").toString();
%>
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
        <form action="ModifyNickNamePro.do" method="post">
			 <input type="hidden" name = "id" value="<%=id%>">
            <br>
            <div class="login_wrap">
                <div class="login_input">
                    <div>
	                    <label>현재 닉네임</label>
	                    <input type="text" readonly="readonly" value="<%=nickName%>">
	                </div>
	                <div>
	                    <label>변경하실 닉네임</label>
	                    <input type="text" placeholder="변경하실 닉네임을 입력해주세요." name="nickname">
	                </div>
	            </div>
            </div>
		            <div class ="login_btn">
		 				<button type="submit" >변경하기</button>
		            </div>
		</form>
    </section>
</body>
</html>