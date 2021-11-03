<%@page import="dao.ReserveDAO"%>
<%@page import="db.jdbcUtil"%>
<%@page import="java.sql.Connection"%>
<%@page import="dao.MemberDAO"%>
<%@page import="vo.MemberBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	ArrayList<MemberBean> list = (ArrayList<MemberBean>)request.getAttribute("list");
	String name = list.get(0).getName();
	String nickname = list.get(0).getNickName();
	String email = list.get(0).getEmail();
	String id = session.getAttribute("sId").toString();
	String pass = list.get(0).getPass();
	
	MemberDAO dao = MemberDAO.getInstance();
	
	Connection con = jdbcUtil.getConnection();
	dao.setConnection(con);
	int couponCount = dao.couponCount(id);
	jdbcUtil.close(con);
	
	ReserveDAO rdao = ReserveDAO.getInstance();
	Connection con2 = jdbcUtil.getConnection();
	rdao.setConnection(con2);
	int reserveList = rdao.selectListCount(id);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세 페이지</title>
<link rel="stylesheet" href="../css/member_info.css">
<link rel="stylesheet" href="../css/info.css">
<link rel="stylesheet" href="../css/reset.css">
<link rel="stylesheet" href="../css/header.css">
</head>
<body>
		<!-- 상위 고정 -->
        <jsp:include page="../inc/header.jsp"></jsp:include>
        <!-- 상위 고정 -->
	<div id="member_wrap">
	<h3><%=id %> 님 정보 입니다.</h3>
		<form action="MemberManagementAction.do">
		<input type="hidden" value="<%=pass %>" name="pass" id="pass">
		<table>
			<tr>
				<th>이름</th><td> <%=name %> </td>
				<th>닉네임</th><td><%=nickname %></td>
			</tr>
			<tr>
				<th>이메일</th><td colspan="3"><%=email %></td>
			</tr>
			<tr>
				<th>보유쿠폰</th><td><a href="GetCouponList.do"><%=couponCount %></a></td>
				<th><a href="ReserveList.do">예약내역</a></th><td><a href="ReserveList.do"><%=reserveList %></a></td>
			</tr>
			<tr>
				<th colspan="4"><input type="submit" value="정보 변경하러 가기"></th>
			</tr>
		</table>
	</form>
	</div>
</body>
</html>