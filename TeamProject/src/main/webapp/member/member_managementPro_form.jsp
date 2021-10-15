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
    <title>Insert title here</title>
    <style type="text/css">
        body {
            width: 600px;
            margin: auto;
        }

        h1 {
            width: 400px;
            text-align: center;
        }
    </style>
</head>
<body>
<h1>정보수정</h1>
<form action="MemberManagementProAction.do" method="post" name="managementForm">
    <table border="1">
        <tr>
            <td>이름</td>
            <td><input type="text" name="name" required="required" size="20" value="<%=article.getName()%>"></td>
        </tr>
        <tr>
            <td>아이디</td>
            <td>
                <input type="text" name="id" required="required" size="20"
                       value="<%=article.getId()%>" readonly="readonly">
            </td>
        </tr>
        <tr>
            <td>닉네임</td>
            <td>
                <input type="text" name="nickName" required="required" size="20"
                       value="<%=article.getNickName()%>">
            </td>
        </tr>
        <tr>
            <td>패스워드</td>
            <td>
                <input type="password" name="pass" required="required" size="20">
            </td>
        </tr>
        <tr>
            <td>성별</td>
            <td>
                <%
                    if (article.getGender().equals("male")) {
                %>
                <input type="radio" name="gender" value="male" checked="checked">남&nbsp;&nbsp;
                <input type="radio" name="gender" value="female">여
                <%
                } else { %>
                <input type="radio" name="gender" value="male">남&nbsp;&nbsp;
                <input type="radio" name="gender" value="female" checked="checked">여
                <%
                    }
                %>

            </td>
        </tr>
        <tr>
            <td>나이</td>
            <td><input type="text" name="age" required="required" size="10" value="<%=article.getAge()%>"></td>
        </tr>
        <tr>
            <td>전화번호</td>
            <td><input type="text" name="mobile" required="required" size="10" value="<%=article.getMobile()%>"></td>
        </tr>
        <tr>
            <td>E-Mail</td>
            <td>
                <input type="text" name="email" required="required" size="20" value="<%=article.getEmail()%>">
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <input type="submit" value="정보수정">
                <input type="button" value="취소" onclick="history.back()">
            </td>
        </tr>
    </table>
</form>
</body>
</html>