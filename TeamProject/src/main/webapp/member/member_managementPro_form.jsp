<%@ page import="vo.MemberBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%
    MemberBean article = (MemberBean) request.getAttribute("article");
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Management</title>
    <link rel="stylesheet" href="./css/member_management.css">
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script type="text/javascript">

        function checkForm() {
            var text = document.getElementById("checkPassRegex").innerText;

            if (text.includes('안전도')) {
                return true;
            } else {
                alert('비밀번호 패턴 확인');
                document.getElementById("pass").focus();
                return false;
            }
        }

        window.onload = function () {
            document.getElementById("address1").addEventListener("focus", function () {
                new daum.Postcode({
                    oncomplete: function (data) {
                        document.getElementById("address1").value = data.address;
                        document.getElementById("addressDetail").focus();
                    }
                }).open();
            });
        }

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
                    element.innerHTML = '사용할 수 없습니다.';
                    element.style.color = 'red';
                    break;
            }

        }
    </script>
</head>
<body>
<!-- 상위 고정 -->
<jsp:include page="../inc/header.jsp"></jsp:include>
<!-- 상위 고정 -->
<section>
    <form action="MemberManagementProAction.do" method="post" name="managementForm" onsubmit="return checkForm()">
        <div><a href="#"><img alt="" src="../images/LOGO.png"></a></div>
        <div class="management_wrap">
            <div class="management_input">
                <div>
                    <label>이름</label>
                    <input type="text" id="name" name="name" required="required" size="20" value="<%=article.getName()%>" readonly="readonly">
                </div>
                <div>
                    <label>아이디</label>
                    <input type="text" id="id" name="id" required="required" size="20"
                           value="<%=article.getId()%>" readonly="readonly">
                </div>
                <div>
                    <label>닉네임</label>
                    <input type="text" id="nickName" name="nickName" required="required" size="20"
                           value="<%=article.getNickName()%>">
                </div>
                <div>
                    <label>패스워드</label>
                    <input type="password" id="pass" name="pass" required="required" size="20" onkeyup="checkRegex(this.value)">
                </div>
                <div>
                    <span id="checkPassRegex"></span>
                </div>
                <div>
                    <label>나이</label>
                    <input type="text" id="age" name="age" required="required" size="10" value="<%=article.getAge()%>">
                </div>
                <div>
                    <label>전화번호</label>
                    <input type="text" id="mobile" name="mobile" required="required" size="10" value="<%=article.getMobile()%>">
                </div>
                <div>
                    <label>E-Mail</label>
                    <input type="text" id="email" name="email" required="required" size="20" value="<%=article.getEmail()%>" readonly="readonly">
                </div>
                <div>
                    <label>주소</label>
                    <input type="text" id="address1" name="address1" required="required" size="20" value="<%=article.getAddress()%>">
                </div>
                <div>
                    <label>상세주소</label>
                    <input type="text" id="addressDetail" name="addressDetail" required="required" size="20" value="<%=article.getAddressDetail()%>">
                </div>
            </div>
        </div>
        <div class="management_btn">
            <button type="submit">정보수정</button>
            <button type="button" onclick="history.back()">취소</button>
        </div>
    </form>
</section>
</body>
</html>