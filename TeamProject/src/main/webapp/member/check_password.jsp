<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../js/jquery-3.6.0.js"></script>
<script type="text/javascript">


</script>
</head>
<body>

<c:choose>
	<c:when test="${param.pass1 eq param.pass2 }">
		<a style="color:green">비밀번호 일치.</a>
	</c:when>
	<c:otherwise>
		일치하지 않습니다.
	</c:otherwise>
</c:choose>

</body>
</html>