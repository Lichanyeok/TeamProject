<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="./js/jquery-3.6.0.js"></script>
<script type="text/javascript">	
	$(document).ready(function() {
		$("#chk").on("click", function(){
// 			alert($("#chk").prop("checked"));
			$("#ischk").val($("#chk").prop("checked"))  // 체크 값 저장 (true, false)
		});
		
	})
</script>

<body>
	 
      <h1>게시판 글 등록</h1>
      <form action="WriteFormPro.do" method="post" name="boardForm">
      <input type="hidden" id="ischk" name="ischk" value="" >
         <input type="hidden" value="<%=session.getAttribute("sId") %>" name="id">
         <table>
            <tr><td>아이디 :<%=session.getAttribute("sId") %></td></tr>
            <tr><td>제목 : <input type="text" name="subject"></td></tr>
            <tr><td>내용 : <textarea rows="40" cols="40" name="content"></textarea></td></tr> 
         </table>
         	비밀글
         	<input type="checkbox" id="chk">
            <input type="submit" value="등록">&nbsp;&nbsp;
            <input type="reset" value="다시쓰기">
            <input type="button" value="취소" onclick="history.back()">
            <input type="button" value="목록" onclick="location.href='CustomerCommentList.do'">
      </form>
</body>
</html>