<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
   <link rel="stylesheet" href="../css/style.css">
   <link rel="stylesheet" href="../css/join_step2.css">
   <script  src="../js/jquery-3.6.0.js" ></script>
   <script type="text/javascript">
   		$(function(){
   			$('#agree1').on('change',function(){
//    				alert('gd');
				if($('#agree1').prop('checked')){
// 					alert('ㅎㅇ');
					$('#agree2').prop('checked',true);
					$('#agree3').prop('checked',true);
				}
				if(!$('#agree1').prop('checked')){
					$('#agree2').prop('checked',false);
					$('#agree3').prop('checked',false);
				}
   			});
   			
   			$('#btnGo').on('click',function(){
   				if($('#agree2').prop('checked')&&$('#agree3').prop('checked')){
   					location.href='./memberJoin.jsp';
   				}else{
   					alert('약관 동의 필수!');
   				}
   			});
   		});
   </script>
</head>
<body>

    <div class = "join_container">
            <h1><a href="../"><img alt="" src="../images/LOGO.png"></a></h1>
            <ul class="ingo_top">
                <li class ="active">STEP1.약관동의</li>
                <li>STEP2.정보입력</li>
                <li>STEP3.가입완료</li>
            </ul>   
        </div>
        <section class = "agree">
            <h1>약관동의 및 정보활용동의</h1>
            <p>회원정보를 입력해주세요</p>
            <div class = "agree_line">
            <input type="checkbox" id="agree1"><label class = "agree_font"for="agree1">필수항목 전체동의</label>
            </div>
            <ul class = "agree_box">
               <li>
                <input type="checkbox" id="agree2"><label for="agree2">개인정보 이용 약관 동의(필수)</label>
                <div class = "box1">
                    <p>제1조(목적) <br>
                    	① (주)맛집 (이하 ‘회사’라 한다)은 정보통신망 이용촉진 및 정보보호 등에 관한 법률, 개인정보보호법 등 관련 법령(이하 “관련 법령” 이라 함)에 따라 이용자의 개인정보를 보호하고, 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보처리방침을 수립합니다.

						개인정보처리방침은 이용자가 언제나 쉽게 열람할 수 있도록 서비스 초기화면을 통해 공개하고 있으며, 개인정보 관련법령, 지침, 고시 또는 회사 정책의 변경에 따라 변경될 수 있습니다.<br>
						<br>
                        ② 개인정보의 제3자 제공
						회사는 이용자의 개인정보를 개인정보 수집·이용 목적에서 명시한 범위 내에서 사용하며, 원칙적으로 이용자의 사전 동의 없이 개인정보 수집·이용 목적 범위를 초과하여 이용하거나 이용자의 개인정보를 제공하지 않습니다.<br>
							 
                    </p>
                </div>
               </li> 
               <li>
                <input type="checkbox" id="agree3"><label for="agree3">서비스 이용 약관 동의(필수)</label>
                <div class = "box1">
                    <p>제1조(목적) <br>
                        이 약관은 데이터 처리 기반 회사(전자상거래 사업자)가 운영하는 OO 사이버 몰(이하 “몰”이라 한다)에서 제공하는 인터넷 관련 서비스(이하 “서비스”라 한다)를 이용함에 있어 사이버 몰과 이용자의 권리?의무 및 책임사항을 규정함을 목적으로 합니다.<br>
                        
                        ※「PC통신, 무선 등을 이용하는 전자상거래에 대해서도 그 성질에 반하지 않는 한 이 약관을 준용합니다」<br>
                        
                        제2조(정의) <br>
                        ①“몰” 이란 OO 회사가 재화 또는 용역(이하 “재화등”이라 함)을 이용자에게 제공하기 위하여 컴퓨터등 정보통신설비를 이용하여 재화등을 거래할 수 있도록 설정한 가상의 영업장을 말하며, 아울러 사이버몰을 운영하는 사업자의 의미로도 사용합니다.
                        
                    </p>
                </div>
               </li> 
            </ul>
            
            <button id="btnGo">확인</button>

        </section>
        
    </body>
</html>