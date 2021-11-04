<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="./css/login.css">
    <script src="./js/jquery-3.6.0.js"></script>
    <script type="text/javascript">
    	$(function(){
    		var userInputId = getCookie("userInputId");
    		$('#input[name="id"]').val(userInputId);
    		
    		if($('input[name="id"]').val() !=""){
    			$('#idSaveCheck').attr("checked",true);
    		}
    		
    		$('#idSaveCheck').change(function(){
    			if($('#idSaveCheck').is(':checked')){
    				var userInputId = $('input[name="id"]').val();
    				setCookie("userInputId",userInputId,7);
    			}else{
    				deleteCookid("userInputId");
    			}
    		});
    		
    		$('input[name="id"]').keyup(function(){
    			if($('#idSaveCheck').is(':checked')){
    				var userInputId = $('input[name="id"]').val();
    				setCookie("userInputId",userInputId,7);
    			}
    		});
    	});
    	
    	function setCookie(cookieName, value, exdays){
    		var exdate = new Date();
    		exdate.setDate(exdate.getDate() + exdays);
    		var cookieValue = escape(value) +((exdays==null)) ? "" : "; expires=" + exdate.toGMTString();
    		document.cookie = cookieName + "=" cookieValue;
    	}
    	
    	function deleteCookie() {
			var expireDate = new Date();
			expireDate.setDate(expireDate.getDate() -1);
			document.cookie = cookieName + "= " + "; expires" + expireDate.toGMTString();
		}
    	
    	function getCookie(cookieName){
    		cookieName = cookieName + '=';
    		var cookieData = document.cookie;
    		var start = cookieData.indexOf(cookieName);
    		var cookieValue ='';
    		if(start != -1){
    			start += cookieName.length;
    			var end = cookieData.indexOf(';',start);
    			if(end==-1)end = cookieData.length;
    			cookieValue = cookieData.substring(start, end);
    		}
    		return unescape(cookieValue);
    	}
    </script>
</head>
<body>
	<!-- 상위 고정 -->
     <jsp:include page="../inc/header.jsp"></jsp:include>
    <!-- 상위 고정 -->

    <section>
        <form action="MemberLoginProAction.do" method="post">
            <div><a href="#"><img alt="" src="../images/LOGO.png"></a></div>
            <div class="login_wrap">
                <div class="login_input">
                    <div>
	                    <label>아이디</label>
	                    <input type="text" placeholder="id" name="id">
	                </div>
	                <div>
	                    <label>비밀번호</label>
	                    <input type="password" placeholder="password" name="pass">
	                </div>
	            </div>
            </div>
		            <div class ="login_btn">
		 				<button type="submit" >로그인</button>
		            </div>
		</form>
        <div class ="checkbox">
            <div class="id_checkbox">
                <input type="checkbox" id="idSaveCheck">
                <label for="id">아이디 저장</label>
            </div>

            <div class="password_checkbox">
                <input type="checkbox" id="pass">
                <label for="pass">보안인증</label>
            </div>
        </div>
        <ul class="find">
            <li><a href = "./member/find_id2.jsp">아이디찾기</a></li>
            <li><a href = "./member/find_pass2.jsp">비밀번호찾기</a></li>
            <li><a href = "MemberJoinFormAction.do">회원가입</a></li>
        </ul>


        <!-- 아이디,비번찾기 -->
    </section>
</body>
</html>