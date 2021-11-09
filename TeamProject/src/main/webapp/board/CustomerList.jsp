<%@page import="vo.MemberBean"%>
<%@page import="vo.PageInfo"%>
<%@page import="vo.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <% 
     ArrayList<BoardBean> articleList = (ArrayList<BoardBean>)request.getAttribute("articleList");
 	PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
 	int nowPage = pageInfo.getPage();
 	int maxPage = pageInfo.getMaxPage();
 	int startPage = pageInfo.getStartPage();
 	int endPage = pageInfo.getEndPage();
 	int listCount = pageInfo.getListCount();
 	
 	int a = nowPage*10;
 	if(a > articleList.size()){
 		a = articleList.size();
 	}
 	
 %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CustomerCommentList</title>
<style type="text/css">
 table{ 
 border: 1px solid; 
 } 
</style>
<script src="./js/jquery-3.6.0.js"></script>
<script type="text/javascript">
function twosend(num, id, ck) {
	if(ck==true){
		if(id=="<%=session.getAttribute("sId")%>" || '<%=session.getAttribute("sId")%>'=="admin"){
			alert("돼!");
	//     // 동적 form - post 처리
	     var form = document.createElement("form");
	      form.setAttribute("charset", "UTF-8"); // post 한글처리
	      form.setAttribute("method", "post");  // post 방식
	      form.setAttribute("action", "DetailList.do"); // 요청 보낼 주소
	
	      
	      // 예약번호
	      var doPost = document.createElement("input");
	      doPost.setAttribute("type", "hidden");
	      doPost.setAttribute("name", "num"); //이 값이 계속 1만 전달한다 1값을 왜 전달하는 걸까?
	      doPost.setAttribute("value", num);
	      form.appendChild(doPost);
	
	      document.body.appendChild(form);
	      form.submit();
		}else if(id!='<%=session.getAttribute("sId")%>'){
			alert("접근할 수 없습니다");
		}
	}else if(ck==null){
		var form = document.createElement("form");
	      form.setAttribute("charset", "UTF-8"); // post 한글처리
	      form.setAttribute("method", "post");  // post 방식
	      form.setAttribute("action", "DetailList.do"); // 요청 보낼 주소
	
	      
	      // 예약번호
	      var doPost = document.createElement("input");
	      doPost.setAttribute("type", "hidden");
	      doPost.setAttribute("name", "num"); //이 값이 계속 1만 전달한다 1값을 왜 전달하는 걸까?
	      doPost.setAttribute("value", num);
	      form.appendChild(doPost);
	
	      document.body.appendChild(form);
	      form.submit();
	}
 }


</script>


</head>
<body>
		
			<%String ischk = request.getParameter("ischk");%>
<!-- 			MemberLoginProAction.java -->
<%-- 			<%=session.getAttribute("sId") %> --%>
	<!-- 상위 고정 -->
    <jsp:include page="/inc/header.jsp"></jsp:include>
    <!-- 상위 고정 -->

	<h1>CustomerCommentlist</h1>
	
	<form name="send" action="#">
	<table>
	<%if(articleList != null && listCount > 0) {%>
		<tr id="tr_top">
			<td>번호</td>
			<td>제목</td>
			<td width="150px">아이디</td>
			<td width="150px">날짜</td>
			<td width="100px">조회수</td>
		</tr>
		
		<%for(int i = (nowPage*10)-10; i < a; i++) {%>
		<tr id="twosend" onclick="twosend(<%=articleList.get(i).getNum()%>, '<%=articleList.get(i).getId()%>', <%=articleList.get(i).getSecretCheck()%>)">
			<td class="getNum"><%=articleList.get(i).getNum()%></td>
			<td id="subject">
			<%if(articleList.get(i).getSecretCheck().equals("true")) {%>
				 	🔒비밀글입니다.		
			<%} else {%>
			<%=articleList.get(i).getSubject() %>
			<%} %>
			</td>
			<td><%=articleList.get(i).getId() %></td>
			<td><%=articleList.get(i).getDate()%></td>
			<td><%=articleList.get(i).getReadcount() %></td>
		</tr>
		<%} %>
	</table>
	</form>
	<%if(nowPage <= 1) {%>
			<input type="button" value="이전">&nbsp;
	<%} else {%>
			<input type="button" value="이전" onclick="location.href='BoardList.do?page=<%=nowPage - 1 %>'">&nbsp;
	<%} %>
	
	<%for(int i = startPage; i <= endPage; i++) { 
			if(i == nowPage) { %>
				[<%=i %>]
		<%} else { %>
				<a href="BoardList.do?page=<%=i %>">[<%=i %>]</a>&nbsp;
		<%} %>
	<%} %>
	
	<%if(nowPage >= maxPage) { %>
			<input type="button" value="다음">
	<%} else { %>
			<input type="button" value="다음" onclick="location.href='BoardList.do?page=<%=nowPage + 1 %>'">
	<%} %>
	<%} else{%>
	<section id="emptyArea">등록된 글이 없습니다</section>
	<%}%>
	<%if(session.getAttribute("sId")!=null){ //로그인이 안되어 있다면%> 
	<input type="button" value="글쓰기" onclick="location.href='WriteForm.do'">
	<%}else{ %>
	<input type="button" value="글쓰기" onclick="location.href='MemberLoginFormAction.do'">
	<%} %>
</body>
</html>