<%@ page import="vo.MemberBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%
    MemberBean article = (MemberBean) request.getAttribute("article");
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Management</title>
    <link rel="stylesheet" href="./css/member_management.css">
</head>
<body>
<!-- 상위 고정 -->
<jsp:include page="../inc/header.jsp"></jsp:include>
<!-- 상위 고정 -->
<section>
    <form action="MemberManagementProAction.do" method="post" name="managementForm">
        <div><a href="#"><img alt="" src="../images/LOGO.png"></a></div>
        <div class="management_wrap">
            <div class="management_input">
                <div>
                    <label>이름</label>
                    <input type="text" name="name" required="required" size="20" value="<%=article.getName()%>">
                </div>
                <div>
                    <label>아이디</label>
                    <input type="text" name="id" required="required" size="20"
                           value="<%=article.getId()%>" readonly="readonly">
                </div>
                <div>
                    <label>닉네임</label>
                    <input type="text" name="nickName" required="required" size="20"
                           value="<%=article.getNickName()%>">
                </div>
                <div>
                    <label>패스워드</label>
                    <input type="password" name="pass" required="required" size="20">
                </div>
                <div>
                    <label>나이</label>
                    <input type="text" name="age" required="required" size="10" value="<%=article.getAge()%>">
                </div>
                <div>
                    <label>전화번호</label>
                    <input type="text" name="mobile" required="required" size="10" value="<%=article.getMobile()%>">
                </div>
                <div>
                    <label>E-Mail</label>
                    <input type="text" name="email" required="required" size="20" value="<%=article.getEmail()%>">
                </div>
            </div>
        </div>
        <div class="management_btn">
            <button type="submit">정보수정</button>
            <button type="button" onclick="history.back()">취소</button>
        </div>
    </form>
</section>
</body>
</html>