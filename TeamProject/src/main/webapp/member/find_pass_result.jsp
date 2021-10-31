<%@page import="dao.MemberDAO"%>
<%@page import="vo.MemberBean"%>
<%@page import="db.jdbcUtil"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	String email = request.getParameter("email");
	
	boolean isRightInfo = false;
	MemberBean bean = new MemberBean();
	Connection con = jdbcUtil.getConnection();
	MemberDAO dao = MemberDAO.getInstance();
	dao.setConnection(con);
	bean.setId(id);
	bean.setEmail(email);
	
	isRightInfo = dao.getPass(bean); 
	String pass = "정보가 일치하지 않거나 없는 계정입니다.";
	if(isRightInfo){
		pass = bean.getPass();
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	<%if(isRightInfo){ %>
	<div id="join_container">
	<table>
	<tr>
       <th>비밀번호</th>
       <td><input type="password" name="pass1" id="pass1" onkeyup="checkRegex(this.value)" ></td>
       <td><span id="checkPassRegex"></span></td>
       </tr>
       <tr>
       <th>비밀번호확인</th>
       <td><input type="password" id="pass2" name="pass2" onkeyup="checkIdentical()"></td>
       <td><span id="isIdentical"></span></td> <!-- 경고메세지 -->
       </tr>
       <tr>
       	<td colspan="2"><button id="btnGo" onclick="updatePass()">확인</button> </td>
       </tr>
       </table>
     </div>
	<% }else{%>
	<h3><%=pass %></h3>
	<%} %>
	
</body>
</html>