<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	 
      <h1>게시판 글 등록</h1>
      <form action="WriteFormPro.bo" method="post" name="boardForm">
         <table>
            <tr><td>이름 : <input type="text" name="name"></td></tr>
            <tr><td>제목 : <input type="text" name="subject"></td></tr>
            <tr><td>내용 : <textarea rows="40" cols="40" name="content"></textarea></td></tr> 
<!--             id햇을때는 한 파일 안에서만 효력이 있고 request.getparameter로 가져올려면 name으로 해야한다. -->
         </table>
         
            <input type="submit" value="등록">&nbsp;&nbsp;
            <input type="reset" value="다시쓰기">
            <input type="button" value="취소" onclick="history.back()">
            <input type="button" value="목록" onclick="location.href='CustomerCommentList.do'">
      </form>
  
</body>
</html>