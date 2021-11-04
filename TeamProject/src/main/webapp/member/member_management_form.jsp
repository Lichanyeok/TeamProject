<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Welcome, is Matzip</title>
    <link rel="stylesheet" href="./css/login.css">
</head>
<body>
	<!-- 상위 고정 -->
     <jsp:include page="../inc/header.jsp"></jsp:include>
    <!-- 상위 고정 -->

    <section>
<!--       <div><a>고객님의 상세페이지를 원하시나요?</a></div> -->
        <form action="MemberInfoDetail.do" method="post">
            <div class="login_wrap">
                <div class="login_input">
                    <div>
	                    <label>아이디</label>
	                    <input type="text" name="id" value="<%=session.getAttribute("sId")%>" readonly="readonly" required="required" >
	                </div>
	                <div>
	                    <label>비밀번호</label>
	                    <input type="password" name="pass" required="required" size="20">
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