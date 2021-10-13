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
    	<form action="MemberJoinProAction.do">
    		이름 : <input type="text" name="name"><br>
    		닉네임 : <input type="text" name="nickName"><br>
    		나이 : <input type="number" name="age" value="24"><br>
    		ID : <input type="text" name="id"><button>중복확인</button>v
    		비밀번호 : <input type="password" name="pass"><br>
    		비밀번호 확인 : <input type="password" name="pass"><br>
    		E-Mail : <input type="text" name="email"><br>
    		휴대폰 : <input type="text" name="mobile"><br>
    		성별 : 남<input type="radio" value="남" name="gender">여<input type="radio" value="여" name="gender"><br>
    	<input type="submit" value="회원가입">
    	</form>
    </div>
    <div>
  
    </div>
    </section>
    <div class = "sec1"></div>
    <div class = "sec2"></div>
    <div class = "sec3"></div>
    
    <footer></footer>
    
</body>
</html>