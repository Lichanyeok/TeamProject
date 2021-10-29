<%@page import="java.awt.dnd.DropTargetAdapter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	h1 {
	text-align: center;
	}
	h2 {
	text-align: center;
	}
	#header {
	text-align: right;
	}
</style>

</head>
<body>
	<section id="header">
		<!-- inc 폴더 내의 top.jsp 페이지를 현재 위치에 포함시키기 -->
		<jsp:include page="./Top.jsp"></jsp:include>
	</section>
	<h1>메인페이지</h1>
	<h2><a href="../ReviewWrite.re">리뷰 쓰기 테스트</a></h2>
	<h2><a href="../ReviewStore.re">00국밥집 리뷰 테스트</a></h2>
	<h2><a href="../ReviewByStores.re">매장 별 리뷰 테스트</a></h2>
	
	
</body>
</html>