<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// session 객체에 저장된 id 값("sId" 속성) 가져오기
String sId = (String)session.getAttribute("sId"); // Object -> String 다운캐스팅

%>
	<%if(sId == null) { %>
		<!-- 세션 아이디가 존재하지 않을 경우 -->
		<!-- 하이퍼링크 로그인(member/loginForm.jsp), 회원가입(member/joinForm.jsp) -->
		<!-- 상대경로를 활용하여 현재 위치(jsp6)의 하위폴더인 member 폴더에 접근 필요 -->	
		<a href="./member/loginForm.jsp">로그인</a> | <a href="./member/joinForm.jsp">회원가입</a>
		<%} else { %>
			<!-- 세션아이디가 존재할 경우 -->
			<%=sId %> 님 | <a href="./member/logout.jsp">로그아웃</a>
		<%} %>