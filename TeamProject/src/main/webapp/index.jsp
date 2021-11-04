<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String sId = (String)session.getAttribute("sId");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">

<title>Welcome, is Matzip</title>
<link rel="stylesheet" href="../css/reset.css">
<link rel="stylesheet" href="../css/style.css">

<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="./css/main.css">
<link rel="stylesheet" href="./css/reset.css">
<link rel="stylesheet" href="./css/style.css">
</head>
	<body>
		<!-- 상위 고정 -->
        <jsp:include page="/inc/header.jsp"></jsp:include>
        <!-- 상위 고정 -->
		<div class = "main_banner">
        <img src="./images/main_banner.png" >
        <div class = "banner_info">
            <h1>언제 어디서나<br>예약은 <span>맛집예약</span></h1>
            <p>맛집 예약이 연동된곳 어디서나 예약하고,<br>내 예약에서 모두 관리할수 있습니다.</p>
            <c:choose>
            	<c:when test="${empty sId }">
           			<button onclick="location.href='MemberLoginFormAction.do'">맛집 회원이신가요?</button>
            	</c:when>
            	<c:otherwise>
           			<button onclick="location.href='MatzipSearch.mz'">맛집 찾으러 가기!</button>
           		</c:otherwise>
            </c:choose>
        </div>
        <c:choose>
	        <c:when test="${empty sId }">
	            <div class = "social">
	   					<!-- 네이버 아이디로 로그인하는 경로-->
	                    <div class = "naver_login">
	                        <img class = "naver"src="./images/naver.png">
	                        <span>네이버 아이디로 시작</span>
	     
	                    </div>
	              		 <!-- 카카오 아이디로 로그인하는 경로-->
	                	<div  class = "kakao_login">
	                        <img class = "kakao"src="./images/kakao.png" >
	                        <span>카카오 아이디로 시작</span>
	                    </div> 
	            </div>
	         </c:when>
        </c:choose>
        </div>
        

</body>
</html>