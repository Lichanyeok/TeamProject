<%@page import="dao.ReserveDAO" %>
<%@page import="db.jdbcUtil" %>
<%@page import="java.sql.Connection" %>
<%@page import="dao.MemberDAO" %>
<%@page import="vo.MemberBean" %>
<%@page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%
    request.setCharacterEncoding("utf-8");
    ArrayList<MemberBean> list = (ArrayList<MemberBean>) request.getAttribute("list");
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
<html lang="en">
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상세 페이지</title>
    <link rel="stylesheet" href="./css/member_info.css">
</head>
<body>
<!-- 상위 고정 -->
<jsp:include page="../inc/header.jsp"></jsp:include>
<!-- 상위 고정 -->
<section>
    <form action="MemberManagementAction.do" method="post">
        <div><a href="#"><img alt="" src="../images/LOGO.png"></a></div>
        <input type="hidden" value="<%=pass %>" name="pass" id="pass">
        <div class="member_wrap">
            <div class="member_input">
                <div>
                    <label>이름</label>
                    <input type="text" value="<%=name %>" name="name">
                </div>
                <div>
                    <label>닉네임</label>
                    <a href="ModifyNickName.do"><input type="text" value="<%=nickname %>" name="nickname"></a>
                </div>
                <div>
                    <label>이메일</label>
                    <input type="text" value="<%=email %>" name="email">
                </div>
                <div>
                    <label>보유쿠폰</label>
                    <a href="GetCouponList.do"><input type="text" value="<%=couponCount %>" name="coupon"></a>
                </div>
                <div>
                    <label>예약내역</label>
                    <a href="ReserveList.do"><input type="text" value="<%=reserveList %>" name="reserve"></a>
                </div>
            </div>
        </div>
        <div class="member_btn">
            <button type="submit">정보 변경하러 가기</button>
        </div>
    </form>
    <%--    <table>--%>
    <%--        <tr>--%>
    <%--            <th>이름</th>--%>
    <%--            <td><%=name %>--%>
    <%--            </td>--%>
    <%--            <th>닉네임</th>--%>
    <%--            <td><a href="ModifyNickName.do"><%=nickname %>--%>
    <%--            </a></td>--%>
    <%--        </tr>--%>
    <%--        <tr>--%>
    <%--            <th>이메일</th>--%>
    <%--            <td colspan="3"><%=email %>--%>
    <%--            </td>--%>
    <%--        </tr>--%>
    <%--        <tr>--%>
    <%--            <th>보유쿠폰</th>--%>
    <%--            <td><a href="GetCouponList.do"><%=couponCount %>--%>
    <%--            </a></td>--%>
    <%--            <th><a href="ReserveList.do">예약내역</a></th>--%>
    <%--            <td><a href="ReserveList.do"><%=reserveList %>--%>
    <%--            </a></td>--%>
    <%--        </tr>--%>
    <%--        <tr>--%>
    <%--            <th colspan="4"><input type="submit" value="정보 변경하러 가기"></th>--%>
    <%--        </tr>--%>
    <%--    </table>--%>
</section>
</body>
</html>