<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="reset.css">
    <link rel="stylesheet" href="css/login.css">
</head>
<body>
    <section>
        <form action="MemberLoginProAction.do" method="post">
        <h1>LOGIN</h1>
            <div class="login_wrap">
            <div class="login_input">
                <div>
                    <label>아이디</label>
                    <input type="text" placeholder="id" name="id">
                </div>
                <div>
                    <label>비밀번호</label>
                    <input type="password" placeholder="password" name="pass">
                </div>
               
            <div class ="login_btn">
 				<button type="submit" >로그인</button>
            </div>
            </div>
            </div>
		</form>
        <div class ="checkbox">
            <div class="id_checkbox">
                <input type="checkbox" id="id">
                <label for="id">아이디 저장</label>
            </div>

            <div class="password_checkbox">
                <input type="checkbox" id="pass">
                <label for="pass">보안인증</label>
            </div>
        </div>
        <ul class="find">
            <li><a href = "#">아이디찾기</a></li>
            <li><a href = "#">비밀번호찾기</a></li>
            <li><a href = "MemberJoinFormAction.do">회원가입</a></li>
        </ul>


        <!-- 아이디,비번찾기 -->
    </section>
</body>
</html>