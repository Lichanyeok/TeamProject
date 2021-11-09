<%@page import="java.util.ArrayList"%>
<%@page import="vo.ReserveBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/reset.css">
<link rel="stylesheet" href="../css/header.css">
<link rel="stylesheet" href="../css/reservation_list2.css">
<script src="./js/jquery-3.6.0.js"></script>
<%
ArrayList<ReserveBean> article = (ArrayList<ReserveBean>) request.getAttribute("article");
if (article != null) {
	pageContext.setAttribute("article", article);

}
%>
</head>
<body>
	<jsp:include page="../inc/header.jsp"></jsp:include>
	<hr>
	<div id="wrap">
		<p id="reservation_header">예약 리스트</p>
		<div class="clear"></div>
		<div id="reservation_list">
			<c:choose>
				<c:when test="${article != null }">
					<c:forEach items="article" var="article">
						<div class="list">
							<ul class="list_ul">
								<li><p>예약자</p>
									<p>{article.getReserve_user() }</p></li>
								<li><p>예약날자</p>
									<p>${article.getReserve_date()  }</p></li>
								<li><p>예약시간</p>
									<p>${article.getReserve_time()  }</p></li>
								<li><p>인원수</p>
									<p>${article.getPeople() }</p></li>
								<li><p>메뉴</p>
									<p>${article.getTotal_order_menu()  }</p></li>
								<li><p>요청사항</p>
									<p>${article.getCustomerNeeds() }</p></li>
								<li><p>결제방법</p>
									<p>${article.getReserve_type() }</p></li>
							</ul>
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<p class="fail">예약 없음</p>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</body>
</html>