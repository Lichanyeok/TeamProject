<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>

    <title>Welcome, is Matzip</title>
    <link rel="stylesheet" href="../css/management.css">
</head>
<body>
<!-- 상위 고정 -->
<jsp:include page="../inc/header.jsp"></jsp:include>
<!-- 상위 고정 -->

<section>
    <form action="MemberInfoDetail.do" method="post" name="managementForm">
        <div><a href="#"><img alt="" src="../images/LOGO.png"></a></div>
        <div class="management_wrap">
            <div class="management_input">
                <div>
                    <label>아이디</label>
                    <input type="text" name="id" value="<%=session.getAttribute("sId")%>" readonly="readonly" required="required">
                </div>
                <div>
                    <label>비밀번호</label>
                    <input type="password" placeholder="password" name="pass" required="required">
                </div>
            </div>
        </div>
            <div class="management_btn">
                <input type="submit" value="확인">
                <input type="button" value="취소" onclick="history.back()">
            </div>
    </form>
</section>
</body>

</html>