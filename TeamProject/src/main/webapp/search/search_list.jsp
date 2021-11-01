<%@page import="vo.PageInfo" %>
<%@page import="vo.SearchBean" %>
<%@page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%
    ArrayList<SearchBean> articleList = (ArrayList<SearchBean>) request.getAttribute("articleList");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <style type="text/css">
        .clear {
            clear: both;
        }

        #listForm {
            width: auto;
            height: 510px;
        }

        .category_list_info {
            border: 1px solid #FF8831;
            width: 538px;
            height: 100px;
            float: left;
            margin: 0 auto;
            color: black;
            font-size: 15px;


        }

        .category_list_logo {
            width: 100px;
            height: 100px;
            float: left;
            margin-right: 10px;

        }

        .category_list_ul {
            margin-top: 5px;
            width: 350px;
            height: 90px;
            float: left;
        }

        .category_list_ul li {
            line-height: 1.4;

        }

        .starImg {
            width: 12px;
            height: 12px;
        }

        .list_name {
            font-weight: bold;
            font-size: 18px;
            color: #3CB371;
        }

        .list_link {
            color: #3CB371;
        }

        .list_commend {
            margin: 5px 5px 0 5px;
            width: 60px;
            height: 90px;
            float: left;
        }

        .list_commend > img {
            width: 60px;
            height: 60px;
            float: left;
        }

        .list_commend > span {
            font-size: 12px;
            font-weight: bolder;
            width: 50px;
            height: 14px;
            margin-top: 8px;
            float: right;
            color: #FF5531;
        }
    </style>
</head>
<body>
<div id="listForm">
    <%
        if (articleList != null) {
            for (int i = 0; i < articleList.size(); i++) {%>
    <div class="category_list_info">
        <a href="./MatzipInfo.mz?road_address=<%=articleList.get(i).getRoad_address() %>
							&tell_number=<%=articleList.get(i).getTell_number()%>">
            <%if (articleList.get(i).getLogo_img() != null) { %>
            <img src="./search/img/<%=articleList.get(i).getLogo_img() %>" class="category_list_logo">
            <%} else {%>
            <img src="./search/img/no_img.jpg" class="category_list_logo">
            <%} %></a>
        <ul class="category_list_ul">
            <li class="list_name"><%=articleList.get(i).getPlace_name() %>
                <%
                    double star = Math.round(articleList.get(i).getStar_score() * 10) / 10.0;
                    int iStar = (int) star;
                    double fStar = Math.round((star - iStar) * 10) / 10.0;
                    for (int j = 0; j < iStar; j++) {%>
                <img src="./search/img/star.jpg" class="starImg">
                <%}%>(<%=star %>)
            </li>
            <li class="list_category">업종 : <%=articleList.get(i).getCategory() %>
            </li>
            <li class="list_address">주소 : <%=articleList.get(i).getRoad_address() %>
            </li>
            <li class="list_tell">전화번호 : <%=articleList.get(i).getTell_number() %>
            </li>
        </ul>
        <div class="list_commend">
            <img src="./search/img/no_img.jpg">
            <span>추천! (<%=articleList.get(i).getRecommend() %>)</span>
        </div>
    </div>
    <%
            }
        }
    %>
</div>
</body>
</html>