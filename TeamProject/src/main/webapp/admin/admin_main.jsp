<%@page import="vo.PageInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="./js/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(function() {
		$('#alignBtn').on('click',function(){
			if($('input[type=radio]').eq(0).prop('checked')){
// 				alert('이름순');
				var radioData = $('input[type=radio]').eq(0).serialize();
				$.ajax({
					type: "GET",
					data:radioData,
					url:"MemberAlign.do",
				}).done(function(data) {
					$('#resultArea').html(data);
				}).fail(function() {
					alert('불러올 수 없습니다!');
				});
			}else if($('input[type=radio]').eq(1).prop('checked')){
// 				alert('가입순');
				var radioData = $('input[type=radio]').eq(1).serialize();
				$.ajax({
					type: "GET",
					data:radioData,
					url:"MemberAlign.do",
					dataType:"text"
				}).done(function(data) {
					$('#resultArea').html(data);
				}).fail(function() {
					alert('불러올 수 없습니다!');
				});
			}else if($('input[type=radio]').eq(2).prop('checked')){
// 				alert('등급순');
				var radioData = $('input[type=radio]').eq(2).serialize();
				$.ajax({
					type: "GET",
					data:radioData,
					url:"MemberAlign.do",
					dataType:"text"
				}).done(function(data) {
					$('#resultArea').html(data);
				}).fail(function() {
					alert('불러올 수 없습니다!');
				});
			}
		
		});
	});

</script>
</head>
<link rel="stylesheet" href="./css/reset.css">
<link rel="stylesheet" href="./css/style.css">

<body>
		<!-- 상위 고정 -->
        <jsp:include page="../inc/header.jsp"></jsp:include>
        <!-- 상위 고정 -->

        <nav id="sub_menu">
            <ul>
                <li><a>관리자메뉴</a></li>
                <li><a href="AdminManagementFormAction.do">회원관리</a></li>
                <li><a href="MemberGift.do">쿠폰지급</a></li>
                <li><a href="RequestAddStore.do">등록신청관리</a></li>
            </ul>
   		</nav>
        <div>
        	<input type="radio" value="name" name="align" checked="checked">이름순
        	<input type="radio" value="date" name="align">가입순
        	<input type="radio" value="grade" name="align">등급순
        	<button id="alignBtn" onclick="alignBtn()">정렬</button>
        	
        </div>
        <div id="resultArea" style="width: 6000px; height: 400px; overflow: auto;"></div>
        <div id="resultArea2" style="width: 6000px; height: 400px; overflow: auto;"></div>

</body>
</html>