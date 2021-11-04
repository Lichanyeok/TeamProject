<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Welcome, is Matzip</title>
</head>
<body>
	<h1>확인</h1>
	<form action="MemberManagementAction.do" method="post" name="managementForm">
		<table border="1">
			<tr>
				<td>아이디</td>
				<td><input type="text" name="id" value="<%=session.getAttribute("sId")%>" readonly="readonly" required="required" size="20"></td>
			</tr>
			<tr>
				<td>패스워드</td>
				<td>
					<input type="password" name="pass" required="required" size="20">
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="확인">
					<input type="button" value="취소" onclick="history.back()">
				</td>
			</tr>
		</table>
	</form>
</body>

</html>