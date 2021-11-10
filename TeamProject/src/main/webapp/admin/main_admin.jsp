<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./css/admin.css">
    <link rel="stylesheet" href="./css/reset.css">
	<link rel="stylesheet" href="./css/style.css">
    <title>Document</title>
</head>
<body>
		<!-- 상위 고정 -->
        <jsp:include page="../inc/header.jsp"></jsp:include>
        <!-- 상위 고정 -->
    <div class = "admin">
        <h2>쿠폰지급</h2>
        <div class = "select_item">
            <select name="coupon_" id="" placeholder="asaasd">
                <option value=""  disabled selected >쿠폰명을 선택해주세요</option>
                <option value="">우수고객 정기할인쿠폰</option>
                <option value="">더우수고객 정기할인쿠폰</option>
                <option value="">3000원 할인</option>
            </select>
            <select name="coupon" id="">
                <option value="">쿠폰내용을 선택해주세요</option>
                <option value="">1000원 할인</option>
                <option value="">2000원 할인</option>
                <option value="">3000원 할인</option>
            </select>
            <select name="coupon" id="">
                <option value="">할인금액을 선택해주세요</option>
                <option value="">1000</option>
                <option value="">2000</option>
                <option value="">3000</option>
            </select>
            <select name="coupon" id="">
                <option value="">전체회원</option>
                <option value="">일반회원</option>
                <option value="">우수회원</option>
                <option value="">더우수회원</option>
            </select>
            <button id="publishBtn"></button>
        </div>
        <div class = "member_list">
            <h2>회원관리</h2>
            <table>
                <colgroup>
                    <col style= "width:200px">
                    <col style= "width:200px">
                    <col style= "width:200px">
                    <col style= "width:200px">
                    <col style= "width:200px">
                </colgroup>
                <thead>
                    <tr>
                        <th>이름</th>
                        <th>아이디</th>
                        <th>닉네임</th>
                        <th>등급</th>
                        <th>가입날짜</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>111</td>
                        <td>2</td>
                        <td>3</td>
                        <td>4</td>
                        <td>5</td>
                    </tr>
                </tbody>
            </table>
        </div>

    </div>
</body>
</html>