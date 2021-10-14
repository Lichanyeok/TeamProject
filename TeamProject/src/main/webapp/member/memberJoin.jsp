<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>join</title>
    <link rel="stylesheet" href="./css/join.css">
</head>
<body>
    <div class = "join">
        <div class = "join_container">
            <form action="MemberJoinProAction.do" method="POST">
                <h1><a href="#"><img class ="logo"src="./images/logo.png" alt="logo"></a></h1>
                <ul class="ingo_top">
                    <li>STEP1.본인인증</li>
                    <li>STEP1.약관동의</li>
                    <li class ="active">STEP1.정보입력</li>
                    <li>STEP1.가입완료</li>
                </ul>   
                <strong>ㅁㅁㅁ님안녕하세요</strong>
                <p >회원정보를 입력해주세요</p>
                <table>
                    <tr>
                        <th>이름</th>
                        <td><input type="text" name="name"></td>
                    </tr>
                    <tr>
                        <th>닉네임</th>
                        <td><input type="text" name="nickName"></td>
                        <td><input class ="return_check"type="button" value ="중복확인"></td>
                    </tr>
                    <tr>
                        <th>생년월일</th>
                        <td><input type="text" name="age"></td>
                    </tr>
                    <tr>
                        <th>아이디</th>
                        <td><input type="text" name="id"></td>
                    </tr>
                    <tr>
                        <th>비밀번호</th>
                        <td><input type="password" name="pass"></td>
                    </tr>
                    <tr>
                        <th>비밀번호확인</th>
                        <td><input type="password"></td>
                        <td></td> <!-- 경고메세지 -->
                    </tr>
                    <tr>
                        <th>전화번호</th>
                        <td><input type="text" name="mobile"></td> <!-- 임시구현 -->
<!--                         <td><span name="mobile">010-1234-****</span></td>  <!— 폰인증후 db로받을시 구현부분 —> -->
                        <td></td> <!-- 경고 메세지 --> 
                    </tr>
                    <tr>
                    	<th>이메일</th>
                    	<td><input type="text" name="email"></td>
                    </tr>
                    <tr>
                        <th>성별</th>
                        <td>
                            <label>남자</label><input type="radio" value ="male" name="gender">
                            <label>여자</label><input type="radio" value="female" name="gender">
                        </td>
                    </tr>
                </table>
                <a class = "submit"><input type="submit" value="회원가입"></a>
        </form>
            </div>
        </div>
</body>
</html>