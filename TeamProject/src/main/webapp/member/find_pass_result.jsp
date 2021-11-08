<%@page import="dao.MemberDAO"%>
<%@page import="vo.MemberBean"%>
<%@page import="db.jdbcUtil"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getAttribute("id").toString();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <link rel="stylesheet" href="./css/login.css">
    <link rel="stylesheet" href="./css/header.css">
	<link rel="stylesheet" href="./css/reset.css">
<script src="../js/jquery-3.6.0.js"></script>
<script type="text/javascript">
function checkRegex(password) {
		//8~16 영문자,숫자,!@#$% -> 전체 규칙과 함계 항목별 규칙을 별도로 체크, 복잡도 검사
		//전체규칙. 하나의 규칙 안에서 영문자 숫자 특문들을 조합하여 8~16자리가 맞는지 체크
		//			단, 전체의 체크이므로 한가지 요소만의 형식으로 됐는가는 판별 불가능
		//규칙1. 영문자 대문자 포함 여부 체크 [A-Z]
		//규칙2. 영문자 소문자 포함 여부 체크 [a-z]
		//규칙3/ 숫자 포함 여부 체크 [0-9!@#$%]
		//규칙5.특수문자 포함 여부 체크 [!@#$%]
		var lengthRegex =/^[A-Za-z0-9!@#$%]{8,16}$/;
		var engUpperCaseRegex = /[A-Z]/;
		var engLowerCaseRegex = /[a-z]/;
		var digitRegex = /[0-9]/;
		var specRegex = /[!@#$%]/;
		
		var count = 0;
		var element = document.getElementById('checkPassRegex');
		if(lengthRegex.exec(password)){
			count++;
		}
		if(engUpperCaseRegex.exec(password)){
			count++;
		}
		if(engLowerCaseRegex.exec(password)){
			count++;
		}
		if(digitRegex.exec(password)){
			count++;
		}
		if(specRegex.exec(password)){
			count++;
		}
		switch (count) {
		case 5: element.innerHTML='안전도 : 우수';		
				element.style.color='green';
			break;
		case 4: element.innerHTML='안전도 : 보통';	
				element.style.color='orange';
		break;
		case 3: element.innerHTML='안전도 : 낮음';	
				element.style.color='#c99b00';
		break;
		default: checkPassRegex.innerHTML='사용할 수 없습니다.';
				element.style.color='red';
			break;
		}
		
	}
	
//--------------------------------패스워드 일치 확인 -----------------------------------------
	function checkIdentical() {
	var sendPass = $('input[type=password]').serialize();
	
	$.ajax({
		type:"GET",
		url: "./check_password.jsp",
		data: sendPass,
		dataType: 'text',
		success: function(msg) {
			$('#isIdentical').html(msg);
		}
	});
}
</script>
</head>
<body>
	<!-- 상위 고정 -->
     <jsp:include page="../inc/header.jsp"></jsp:include>
    <!-- 상위 고정 -->

    <section>
        <form action="UpdatePass.do" method="post">
        <input type="hidden" name="id" value="<%=id%>">
            <div><a>변경하실 비밀번호를 입력해주세요</a></div>
            <br>
            <div class="login_wrap">
                <div class="login_input">
                    <div>
	                    <label>비밀번호</label>
	                    <input type="password" placeholder="password" name="pass1" onkeyup="checkRegex(this.value)" >
	               		<span id="checkPassRegex"></span>
	                </div>
	                <div>
	                    <label>비밀번호확인</label>
	                    <input type="password" placeholder="password" name="pass2" onkeyup="checkIdentical()">
	                	<span id="isIdentical"></span>
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