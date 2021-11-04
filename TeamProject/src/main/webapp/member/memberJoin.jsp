<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%request.setCharacterEncoding("utf-8"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>join</title>
    <link rel="stylesheet" href="../css/join.css">
    <script src="../js/jquery-3.6.0.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script type="text/javascript">


        function checkForm() {
            if (document.getElementById("name").value == "") {
                alert('이름 입력 필수');
                document.getElementById("name").focus();
                return false;
            }
            if (document.getElementById("nickName").value == "") {
                alert('닉네임 입력 필수');
                document.getElementById("nickName").focus();
                return false;
            }
            if (document.getElementById("age").value == "") {
                alert('나이 입력 필수');
                document.getElementById("age").focus();
                return false;
            }
            if (document.getElementById("id").value == "") {
                alert('아이디 입력 필수');
                document.getElementById("id").focus();
                return false;
            }
            if (document.getElementById("pass1").value == "") {
                alert('패스워드 입력 필수');
                document.getElementById("pass1").focus();
                return false;
            }
            if (document.getElementById("pass2").value == "") {
                alert('패스워드확인 입력 필수');
                document.getElementById("pass2").focus();
                return false;
            }
            if (document.getElementById("email").value == "") {
                alert('이메일 입력 필수');
                document.getElementById("email").focus();
                return false;
            }
            if (document.getElementById("mobile").value == "") {
                alert('전화번호 입력 필수');
                document.getElementById("mobile").focus();
                return false;
            }
            if (document.getElementById("address1").value == "") {
                alert('주소 입력 필수');
                document.getElementById("address1").focus();
                return false;
            }
            if (document.getElementById("addressDetail").value == "") {
                alert('상세주소 입력 필수');
                document.getElementById("addressDetail").focus();
                return false;
            }
            if (!document.getElementById("male").checked && !document.getElementById("female").checked) {
                alert('성별 선택 필수');
                document.getElementById("male").focus();
                return false;
            }

            var checkNickNameResult = $('#checkNickNameResult').text();
            if (checkNickNameResult.indexOf("사용 가능한 닉네임 입니다.") >= 0) {
                var checkIdDuplicated = $('#checkIdDuplicated').text();
                if (checkIdDuplicated.indexOf("사용 가능한 아이디 입니다.") >= 0) {
                    var checkPassRegex = $('#checkPassRegex').text();
                    if (checkPassRegex.indexOf("안전도") >= 0) {
                        var isIdentical = $('#isIdentical').text();
                        if (isIdentical.indexOf("비밀번호 일치.") >= 0) {
                        } else {
                            alert('비밀번호 불일치');
                            document.getElementById("pass2").focus();
                            return false;
                        }
                    } else {
                        alert('비밀번호 패턴 확인');
                        document.getElementById("pass1").focus();
                        return false;
                    }
                } else {
                    alert('아이디 중복');
                    document.getElementById("id").focus();
                    return false;
                }
            } else {
                alert('아이디 중복');
                document.getElementById("id").focus();
                return false;
            }

        }


        //----------------------------ID 중복 확인 -----------------------------------------
        function checkNickName() {
//   			var name = $('#nickName').val();
            var sendNickName = $('#nickName').serialize();
            $.ajax({
                type: "GET",
                url: "./nick_name_result.jsp",
                data: sendNickName,
                dataType: 'text',
                success: function (msg) {
                    $('#checkNickNameResult').html(msg);
                }
            });
        }


        //--------------------------------패스워드 양식 확인 -----------------------------------------

        function checkRegex(password) {
            //8~16 영문자,숫자,!@#$% -> 전체 규칙과 함계 항목별 규칙을 별도로 체크, 복잡도 검사
            //전체규칙. 하나의 규칙 안에서 영문자 숫자 특문들을 조합하여 8~16자리가 맞는지 체크
            //			단, 전체의 체크이므로 한가지 요소만의 형식으로 됐는가는 판별 불가능
            //규칙1. 영문자 대문자 포함 여부 체크 [A-Z]
            //규칙2. 영문자 소문자 포함 여부 체크 [a-z]
            //규칙3/ 숫자 포함 여부 체크 [0-9!@#$%]
            //규칙5.특수문자 포함 여부 체크 [!@#$%]
            var lengthRegex = /^[A-Za-z0-9!@#$%]{8,16}$/;
            var engUpperCaseRegex = /[A-Z]/;
            var engLowerCaseRegex = /[a-z]/;
            var digitRegex = /[0-9]/;
            var specRegex = /[!@#$%]/;

            var count = 0;
            var element = document.getElementById('checkPassRegex');
            if (lengthRegex.exec(password)) {
                count++;
            }
            if (engUpperCaseRegex.exec(password)) {
                count++;
            }
            if (engLowerCaseRegex.exec(password)) {
                count++;
            }
            if (digitRegex.exec(password)) {
                count++;
            }
            if (specRegex.exec(password)) {
                count++;
            }
            switch (count) {
                case 5:
                    element.innerHTML = '안전도 : 우수';
                    element.style.color = 'green';
                    break;
                case 4:
                    element.innerHTML = '안전도 : 보통';
                    element.style.color = 'orange';
                    break;
                case 3:
                    element.innerHTML = '안전도 : 낮음';
                    element.style.color = '#c99b00';
                    break;
                default:
                    checkPassRegex.innerHTML = '사용할 수 없습니다.';
                    element.style.color = 'red';
                    break;
            }

        }

        //--------------------------------패스워드 일치 확인 -----------------------------------------
        function checkIdentical() {
            var sendPass = $('input[type=password]').serialize();

            $.ajax({
                type: "GET",
                url: "./check_password.jsp",
                data: sendPass,
                dataType: 'text',
                success: function (msg) {
                    $('#isIdentical').html(msg);
                }
            });
        }

        //------------------------------아이디 중복 확인---------------------------------------------

        function checkIdDup() {
            var sendId = $('#id').serialize();
            $.ajax({
                type: "GET",
                url: "./check_id.jsp",
                data: sendId,
                dataType: 'text',
                success: function (msg) {
                    $('#checkIdDuplicated').html(msg);
                }
            });
        }

        window.onload = function () {
            document.getElementById("address1").addEventListener("click", function () {
                new daum.Postcode({
                    oncomplete: function (data) {
                        document.getElementById("address1").value = data.address;
                        document.getElementById("addressDetail").focus();
                    }
                }).open();
            });
        }

        //----------------------------------생년월일 감지---------------------------------------
        function checkAge() {
            var age = $('#age').val();
            var ageRegex = /^[0-9]{6}$/;
            if (!ageRegex.exec(age)) {
                alert('올바르지 못한 입력입니다.(ex)yymmdd)');
                $('#age').select();
            }
        }


    </script>

</head>
<body>
<div class="join">
    <h1><a href="/TeamProject/"><img alt="" src="../images/LOGO.png"></a></h1>
    <div class="join_container">
        <form action="MemberJoinProAction.do" method="POST" onsubmit="return checkForm()">

<!-- 			<h1><a href="/TeamProject/"><img class ="logo"src="../images/LOGO.png" alt="logo"></a></h1> -->

            <ul class="ingo_top">
                <li>STEP1.약관동의</li>
                <li class="active">STEP2.정보입력</li>
                <li>STEP3.가입완료</li>
            </ul>
            <strong>맛집 회원이 되어보세요!</strong>
            <p>회원정보를 입력해주세요</p>
            <table>
                <tr>
                    <th>이름</th>
                    <td><input type="text" id="name" name="name"></td>
                </tr>
                <tr>
                    <th>닉네임</th>
                    <td><input type="text" name="nickName" id="nickName" onkeyup="checkNickName()"></td>

                    <td><span id="checkNickNameResult"></span></td>
                </tr>
                <tr>
                    <th>생년월일</th>
                    <td><input type="text" id="age" name="age" placeholder="ex)yymmdd" onchange="checkAge()"></td>
                </tr>
                <tr>
                    <th>아이디</th>
                    <td><input type="text" name="id" id="id" onkeyup="checkIdDup()"></td>
                    <td><span id="checkIdDuplicated"></span></td>
                </tr>
                <tr>
                    <th>비밀번호</th>
                    <td><input type="password" name="pass1" id="pass1" onkeyup="checkRegex(this.value)"></td>
                    <td><span id="checkPassRegex"></span></td>
                </tr>
                <tr>
                    <th>비밀번호확인</th>
                    <td><input type="password" id="pass2" name="pass2" onkeyup="checkIdentical()"></td>
                    <td><span id="isIdentical"></span></td> <!-- 경고메세지 -->
                </tr>
                <tr>
                    <th>이메일</th>
                    <td><input type="text" name="email" id="email"></td>
                </tr>
                <tr>
                    <th>전화번호</th>
                    <td><input type="text" name="mobile" id="mobile"></td> <!-- 임시구현 -->
                    <!--                         <td><span name="mobile">010-1234-****</span></td>  <!— 폰인증후 db로받을시 구현부분 —> -->
                    <td></td> <!-- 경고 메세지 -->
                </tr>
                <tr>
                    <th>주소</th>
                    <td><input type="text" readonly="readonly" id="address1" name="address1"> <input type="text" id="addressDetail" name="addressDetail"></td>
                    <td></td> <!-- 경고 메세지 -->
                </tr>
                <tr>
                    <th>성별</th>
                    <td>
                        <label>남자</label><input type="radio" value="male" name="gender" id="male">
                        <label>여자</label><input type="radio" value="female" name="gender" id="female">
                    </td>
                </tr>
            </table>
            <a class="submit"><input type="submit" value="회원가입"></a>
        </form>
    </div>
</div>
</body>
</html>