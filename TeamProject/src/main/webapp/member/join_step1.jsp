<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/join_step1.css">
</head>
<body>

    <div class = "join_container">
            <h1><a href="#"><img alt="" src="../images/LOGO.png"></a></h1>
            <ul class="ingo_top">
                <li class ="active">STEP0.선택해주세요</li>
                <li>STEP1.약관동의</li>
                <li>STEP2.정보입력</li>
                <li>STEP3.가입완료</li>
            </ul>   
        </div>
            
        <section class = "Certified">
            <h1>어서오세요, 맛집입니다.</h1>
            <p>원하시는 가입유형을 선택해주세요</p>
            <div class = "Certified_box">
                <button onclick="location.href='./join_step2.jsp?case=business'"><img src="../images/phone.png" alt="" ><div>사업자전용</div></button>
                <button onclick="location.href='./join_step2.jsp?case=customer'"><img src="../images/email.png" alt=""><div>회원전용</div></button>
            </div>
            <p>14세 미만 어린이는 보호자 인증을 추가로 완료한 후 가입이 가능합니다.<br>본인인증시 제공되는 정보는 해당 인증기관에서 직접 수집하며, 인증 이외의 용도로 이용 또는 저장되지 않습니다.</p>
        </section>    
</body>
</html>