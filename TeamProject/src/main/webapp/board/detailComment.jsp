<%@page import="vo.ReplyComment"%>
<%@page import="vo.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
	// page, BoardBean 객체 파라미터 가져오기
	String nowPage = (String)request.getAttribute("page");
	BoardBean comment = (BoardBean)request.getAttribute("comment");
// 	ReplyComment Reply = (ReplyComment)request.getAttribute("reply");
// 	boolean isReplySuccess = (boolean)request.getAttribute("isReplySuccess");
	
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="./js/jquery-3.6.0.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
		var id = $("#id").text();
		var replyContent = $("#replyContent").val();
		var num = $('input[name=num]').val();
	
		//SelectReply
		$.ajax({
			type:"GET", 
// 			url:"SelectReply.do", 
			url:"WriteReply.do", 
		
			data:{
				"id":id, 
				"replyContent":replyContent,
				"num" : num
			},
			success:function(data){
				$("#listData").html(data);

			},
			error:function(e) {
				alert("불러오지 못해요!");
			}
		});
	
	//WriteReplyAction
	$("#ReplyButton").on("click",function(){
		var replyContent = $("#replyContent").val();
		$.ajax({
			type:"GET", 
			url:"WriteReply.do", 
			data:{
				"id":id, 
				"replyContent":replyContent,
				"num" : num
			},
			success:function(data){
				$("#listData").html(data);
				$("#id").val("");
				$("#replyContent").val("");
				$("#id").focus; // 다 지우고 name에다가 커서 갖다놓기
			},
			error:function(e) {
				alert("적질 못해요!"); 
			}
		});
	});
	
	//deleteComment
	$("#DeleteComment").on("click",function(){
		location.href="DeleteComment.do?num="+num;
	});
})



</script>
</head>
<body>

<input type="hidden" value="<%=request.getParameter("num") %>" name="num" />
		<h2>글 상세내용 보기</h2>
		<section id="basicInfoArea">
			<table border="1">
			<tr><th width="70">제 목</th><td colspan="3" ><%= comment.getSubject() %></td></tr>
			<tr>
				<th width="70">작성자</th><td><%=comment.getId() %></td>
				<th width="70">작성일</th><td><%=comment.getDate() %></td>
			</tr>
			<tr>
				<th width = "70">내용</th>
				<td><%=comment.getContent() %></td>
			</tr>
			<tr>
			<th  width="70">조회수</th><td><%=comment.getReadcount() %></td>
			</tr>
			</table>
		</section>
		<%if(session.getAttribute("sId")!=null){ //로그인이 안되어 있다면%> 
			<input type="button" value="삭제" id="DeleteComment">
		<%} %>
		<hr>

		<div id= "listData"></div>
		
		

        	 <input type="hidden" value="<%= session.getAttribute("sId") %>" name="id">
	         <table>
	            <tr><td id="id"><%=session.getAttribute("sId") %></td></tr>
	            <tr><td>내용 : <input type="text" id="replyContent"></td></tr> 
	         </table>
	            <input type="button" value="등록" id="ReplyButton">&nbsp;&nbsp;
	            <input type="button" value="취소" onclick="history.back()">
	            <input type="button" value="목록" onclick="location.href='CustomerCommentList.do'">
</body>
</html>