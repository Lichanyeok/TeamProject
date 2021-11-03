<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String rev_name = "admin";
int rev_num = Integer.parseInt(request.getParameter("rev_num"));

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰삭제</title>
<style>
	#passForm {
		width: 300px;
		margin: auto;
		border: 1px solid orange;
		text-align: center;
	}
	
	h2 {
		text-align: center;
	}
	
	table {
		width: 300px;
		margin: auto;
		text-align: center;
	}
	
</style>
</head>
<body>
	<!-- 게시판 글 삭제 -->
	<h2>리뷰 삭제</h2>
	<section id="passForm">
		<form action="./ReviewDeletePro.re?rev_name=<%=rev_name %>&rev_num=<%=rev_num %>" name="deleteForm" method="post">
<%-- 			<input type="hidden" name="page" value="<%=nowPage %>" /> --%>
			<table>
				<tr>
					<td><label>글 비밀번호 : </label></td>
					<td><input type="password" name="rev_pass" required="required"></td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="삭제">&nbsp;&nbsp;
						<input type="button" value="돌아가기" onclick="javascript:history.back()">
					</td>
				</tr>
			</table>
		</form>
	</section>
</body>
</html>





