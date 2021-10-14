<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Welcome, This is MatZip</title>
    <link rel="stylesheet" href="../css/reset.css">
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
   
    <header>
        <div class="header_top">
          <ul class = "nav_top">
              <li><a href="#">고객센터</a></li>
              <li><a href="#">관심상품</a></li>
              <%
              String grade = (String)session.getAttribute("grade");
              if(grade!=null){
            	  if(grade.equals("5")){%>
            	<li><a href="Manager.do">관리자 페이지</a></li>
            	<%
            	}else{%>
            	<li><a href="#">마이페이지</a></li>
            	
            	<%} 
              } %>
            
              
              <%
              String nickName = (String)session.getAttribute("sId");
              if(nickName==null) {%>
              <li><a href="MemberLoginFormAction.do">마이페이지</a></li>
              <li><a href="MemberLoginFormAction.do">로그인</a></li>
              <%}else{ %>
              <li><a><%=nickName %>님</a>&nbsp;<a href="./member/logout.jsp">로그아웃</a></li>
              <%} %>
              
          </ul>
        </div>
        <div class = "border_bottom"></div>
        <div class="header_bottom clearfix">
            <div class="logo"><a href="/TeamProject/"><img src="../inc/LOGO.png"></a></div>   
            <ul class="nav_bottom">
                <li><a href="Reserve.do">예약관리</a></li>
                <li><a href="Review.do">리뷰</a></li>
                <li><a href="Notice.do">공지사항</a></li>
                <li><a href="CustomerCenter.do">고객문의</a></li>   
            </ul>       

        </div>
    </header>

    <!-- 헤더영역 -->
    

    
<!--     <main> -->
        
<!--     </main> -->
<!--     <section></section> -->
<!--     <div class = "sec1"></div> -->
<!--     <div class = "sec2"></div> -->
<!--     <div class = "sec3"></div> -->
    
<!--     <footer></footer> -->
    
     
</body>
</html>