<%@page import="vo.CouponBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
	request.setCharacterEncoding("utf-8");
	ArrayList<CouponBean> list = (ArrayList<CouponBean>)request.getAttribute("list");
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/reserve_list.css">
</head>
<body>
		<!-- 상위 고정 -->
        <jsp:include page="../inc/header.jsp"></jsp:include>
        <!-- 상위 고정 -->
    <div class = "reserve_list_wrap">
        <table>
            <colgroup>
                <col width="142px">
                <col width="142px">
                <col width="142px">
                <col width="142px">
                <col width="247px">
                <col width="142px">
                <col width="142px">
            </colgroup>
            <thead>
                <tr>
                    <th scope="col">쿠폰번호</th>
                    <th scope="col">쿠폰명</th>
                    <th scope="col">쿠폰내용</th>
                    <th scope="col">할인가격</th>
                    <th scope="col">사용자명</th>
                    <th scope="col">발급일</th>
                </tr>
            </thead>
            <tbody class ="info">
                    <colgroup>
                        <col width="142px">
                        <col width="142px">
                        <col width="142px">
                        <col width="142px">
                        <col width="247px">
                        <col width="142px">
                    </colgroup>
                    <%if(list.size()>0){ 
                    	for(int i=0;i < list.size();i++){%>
                    <tbody> 
                        <td><%=list.get(i).getCoupon_code() %></td>
                        <td><%=list.get(i).getCoupon_name() %></td>
                        <td><%=list.get(i).getCoupon_value() %></td>
                        <td><%=list.get(i).getCoupon_price() %>원</td>
                        <td><%=list.get(i).getUser_id() %></td>
                        <td><%=list.get(i).getMade_date() %></td>                
                    </tbody>
                    	<%}
                    }else{%>
                   		<h2>발급된 쿠폰이 없습니다.</h2>
                    <%} %>
            </tbody>
        </table>
        <button onclick="history.back()">돌아가기</button>
    </div>
</body>
</html>