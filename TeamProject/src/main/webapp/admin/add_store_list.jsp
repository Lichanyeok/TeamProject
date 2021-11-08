<%@page import="vo.SearchBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	ArrayList<SearchBean> storeList = (ArrayList<SearchBean>)request.getAttribute("storeList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/reset.css">
<link rel="stylesheet" href="./css/style.css">
<link rel="stylesheet" href="./css/add_store_list.css">
<script src="./js/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(function(){
		$('#goUpdateBtn').on('click',function(){
			var str = "";
			//String 배열 생성후 선택된 라이센스 묶어서 ajax로 처리
			$('.checkList').each(function(index){  //index는 순서
			    if($(this).is(":checked")){
			    	str+= ($(this).val() + ',');
			    }  //true일 경우 문자열 결합
			});
			var sendData = {"businessLisence":str};
			$.ajax({
				type: "post",
				data:sendData,
				url:"AddStoreAction.do"
			}).done(function(data) {
				alert('등록 완료!');
				location.reload();
			}).fail(function() {
				alert('등록실패');
			});
			
		});
	});
</script>
</head>
<body>
        <!-- 상위 고정 -->
        <jsp:include page="../inc/header.jsp"></jsp:include>
        <!-- 상위 고정 -->
        

<div class="join">
    <div class="join_container">
            <strong>추가 요청 들어온 가게 목록입니다.</strong>
            <p>선택 후 등록 버튼을 눌러주세요.</p>
            <table>
                <tr>
                    <th>No</th>
                    <td>아이디</td><td>업체명</td><td>도로명주소</td><td>지번주소</td>
                </tr>
                <c:choose>
                <c:when test="${!empty storeList }">
                <c:forEach items="${storeList }" var="storeList" varStatus="i">
                <tr>
                    <th><input type="checkbox" class="checkList" value="${storeList.getBusiness_lisence()}"></th>
                    <td>${storeList.getId()}</td><td>${storeList.getPlace_name()}</td><td>${storeList.getRoad_address()}</td><td>${storeList.getJibun_address()}</td>
                	
                </tr>
                </c:forEach>
                </c:when>
                <c:otherwise>
                <tr>
                    <th>1</th>
                    <td colspan="4"><label>신청내역이 없습니다.</label></td>
                </tr>
                </c:otherwise>
                </c:choose>
            </table>
            <button id="goUpdateBtn">등록</button>
    </div>
</div>


</body>
</html>