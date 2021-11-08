<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/reset.css">
<link rel="stylesheet" href="./css/header.css">
<link rel="stylesheet" href="./css/search_main.css">
<script src="./js/jquery-3.6.0.js"></script>
<script type="text/javascript">
   $(document).ready(function() {

      var category = "한식";

      $.ajax({
         type : "GET",
         url : "MatzipList.mz?category=한식",
         success : function(msg) {
            $("#category_list").html(msg);
         }
      });
      $("li[value='한식']").css('background', '#FF6631');

      $("#category_menu_ul>li").on("click", function() {

         $("li[value=" + category + "]").css("background", "#FF8831");
         category = $(this).text();
         $(this).css('background', '#FF6631');

         $.ajax({
            type : "GET",
            url : "MatzipList.mz?category=" + category,
            success : function(msg) {
               $("#category_list").html(msg);
            }
         }).fail(function() {
            alert('실패!');
         });
      });

   });
</script>
</head>
<body>
   <div id="wrap_search">
      <!-- 상위 고정 -->
      <jsp:include page="../inc/header.jsp"></jsp:include>
      <!-- 상위 고정 -->
      <hr>
      <!-- 리스트 확인용 -->
      <!--        <input type="text" value="" id="bbb"> -->
      <!--        <input type="button" value="aaa" id="aaa">        -->
      <div class="div_clear"></div>
      <jsp:include page="../inc/search.jsp" />
      <div class="div_clear"></div>
      <div id="category_wrap">
         <div id="category_title">MATZIP TOP 10</div>
         <div id="category_text">*이미지 클릭시 상세보기 페이지로 이동</div>
         <div class="div_clear"></div>
         <nav id="category_menu">
            <ul id="category_menu_ul">
               <li value="한식">한식</li>
               <li value="양식">양식</li>
               <li value="중식">중식</li>
               <li value="일식">일식</li>
               <li value="치킨">치킨</li>
               <li value="피자">피자</li>
               <li value="퓨전">퓨전</li>
               <li value="찜">찜</li>
               <li value="고깃집">고깃집</li>
               <li value="족발">족발</li>
               <li value="뷔페">뷔페</li>
               <li value="코스요리">코스요리</li>
            </ul>
         </nav>
         <div class="div_clear"></div>
         <div id="category_list"></div>
         <div class="div_clear"></div>
      </div>
      <br>

      <footer></footer>
   </div>
</body>
</html>
