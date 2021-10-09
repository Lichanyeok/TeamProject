<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/style.css">

</head>
<body>
		<!-- 상위 고정 -->
        <jsp:include page="../inc/header.jsp"></jsp:include>
        <!-- 상위 고정 -->
    <main>
   
    </main>
    <section>
     <div id="login_form" style="position: relative;">
    	<form action="MemberJoinProAction.me">
    		이름 : <input type="text" id="name"><br>
    		주민번호 : <input type="text" id="jumin1">-<input type="text" id="jumin2"><br>
    		ID : <input type="text" id="id"><button>중복확인</button>v
    		비밀번호 : <input type="password" id="pass"><br>
    		비밀번호 확인 : <input type="password" id="pass"><br>
    		E-Mail : <input type="text" id="email"><br>
    		휴대폰 : <input type="text" id="mobile"><br>
    		성별 : 남<input type="radio" value="남" id="gender">여<input type="radio" value="여" id="gender"><br>
    	</form>
    </div>
    <div>
    	<a href="MemberJoinFormAction.me">회원이 아니세요 ? </a>
    </div>
    </section>
    <div class = "sec1"></div>
    <div class = "sec2"></div>
    <div class = "sec3"></div>
    
    <footer></footer>
    
</body>
</html>