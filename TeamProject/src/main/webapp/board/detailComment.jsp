<%@page import="vo.ReplyComment"%>
<%@page import="vo.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
	// page, BoardBean 객체 파라미터 가져오기
	String nowPage = (String)request.getAttribute("page");
	BoardBean comment = (BoardBean)request.getAttribute("comment");
	
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/detailComment.css">
<script src="./js/jquery-3.6.0.js"></script>
<script type="text/javascript">
$(document).ready(function(){
// 	var id = session.getAttribute("sId");
		var id = $("#id").val();
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
function pleaseLogin(){
	alert("로그인이 필요합니다")
	location.href="MemberLoginFormAction.do"
}


</script>
</head>
<body>
<jsp:include page="/inc/header.jsp"></jsp:include>
<%-- <%String commentId = comment.getId(); %> --%>
<%-- <%String userId = session.getAttribute("sId").toString(); %> --%>

<input type="hidden" value="<%=request.getParameter("num") %>" name="num" />
		<section id="basicInfoArea">
			<table class="subjectTable">
			<tr><td colspan="6" class="subject">[제목] <%= comment.getSubject() %></td></tr>
			<tr>
				<td><%=comment.getId() %> | 
				조회 : <%=comment.getReadcount() %> |
				<%=comment.getDate() %>  </td>
			</tr>
			</table>
			<hr>
			
<!-- 				<th width = "70" colspan="3" >내용</th> -->
			<div class="content"><%=comment.getContent() %></div>
			
		</section>
		<%if(session.getAttribute("sId")!=null){ %> 
			<%if(comment.getId().equals(session.getAttribute("sId").toString()) || session.getAttribute("sId").toString().equals("admin")){ %>
			<input type="button" value="삭제" id="DeleteComment" class="button">
			<%} %>
		<%} %>
		<hr>
<!-- 		로그인 값과 글쓴이의 아이디 값이 같거나 아이디값이 admin일 경우 삭제 버튼이 나타난다 -->
		<div id= "listData"></div>
		
		

        	 <input type="hidden" value="<%= session.getAttribute("sId") %>" name="id" id="id">
	         
	         <table class="tablebottom">
<%-- 	            <tr><td id="id"><%=session.getAttribute("sId") %></td> --%>
<tr>
	            <td><textarea rows="5" id="replyContent" class="textArea"></textarea> 
	           
	        <%if(session.getAttribute("sId")!=null){ %> 
	            <input type="button" value="등록" id="ReplyButton">&nbsp;&nbsp;
	            <%}else{ %>
	            <input type="button" value="등록" onclick="pleaseLogin()">&nbsp;&nbsp;
	            <%} %>
<!-- 	            <input type="button" value="취소" onclick="history.back()"> -->
	            <input type="button" value="목록" onclick="location.href='CustomerCommentList.do'">
	           </td> </tr> 
	         </table>
</body>
</html>