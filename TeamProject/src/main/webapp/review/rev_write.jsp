<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 작성</title>
<script src="../js/jquery-3.6.0.js"></script>
<script type="text/javascript">	
	$(document).ready(function() {

		//호버이벤트
		$('#aa').on('click', function() {
			alert('asdasd');
		});
		
		// 별점에 따라서 이미지 변경
		$('#div1 > input[name=rating]').click(function() {
			if($(this).val() > 0) {
				$('img').css({visibility: "visible"});
			}
			$('#div1 img').attr({src:"./review/rev_im/" + $(this).val() + ".png"});
			$('#starScore').val($(this).val());
		});
		  
	});
		
</script>
<%
// session 객체에 저장된 nickName 값("nickName" 속성) 가져오기
String nickName = (String)session.getAttribute("sNn"); // Object -> String 다운캐스팅

%>
<style type="text/css">
   #registForm {
      width: 500px;
      height: 610px;
      border: 1p solid red;
      margin: auto;
   }
   
   h1, h2 {
      text-align: center;
   }
   
   #writeTable {
      margin: auto;
      width: 450px;
   }
   
   .td_left {
      width: 150px;
      background: orange;
   }
   
   .td_right {
      width: 300px;
      background: skyblue;
   }
   
   #commandCell {
      text-align: center;
   }
   
/*    
	starting 
	출처 : https://melthleeth.tistory.com/entry/HTML-CSS%EB%A1%9C-%EB%B3%84%EC%B0%8D%EA%B8%B0-Star-Rating
*/
.star-rating {
  display: flex;
  flex-direction: row-reverse;
  font-size: 2.25rem;
  line-height: 2.5rem;
  justify-content: space-around;
  padding: 0 0.2em;
  text-align: center;
  width: 5em;
  margin: auto;
}
 
.star-rating input {
  display: none;
}
 
.star-rating label {
  -webkit-text-fill-color: transparent; /* Will override color (regardless of order) */
  -webkit-text-stroke-width: 2.3px;
  -webkit-text-stroke-color: #2b2a29;
  cursor: pointer;
}
 
.star-rating :checked ~ label {
  -webkit-text-fill-color: gold;
}
 
.star-rating label:hover,
.star-rating label:hover ~ label {
  -webkit-text-fill-color: #fff58c;
}

.star-rating space-x-4 mx-auto {
text-align: center;

}


#div1 > img {
	visibility: hidden;
}
</style>
</head>
<body>
	<!-- 상위 고정 -->
   	<jsp:include page="../inc/header.jsp"></jsp:include>
   	<!-- 상위 고정 -->
   <!-- 게시판 등록 -->
   <section id="writeForm" >
   
		<h1 id="aa"><%=request.getParameter("rev_store") %> </h1>
		
	<form action="ReviewWritePro.re" method="post" enctype="multipart/form-data" name="boardForm">
	<!-- 예약번호 값 넘기기 --> <input type="hidden" name="ran_num" value="<%=request.getParameter("ran_num") %>" />
	<!-- 리뷰 작성자 값 넘기기 --> <input type="hidden" value="<%=nickName %>" name="rev_name"/>
	<!-- 리뷰 매장명 값 넘기기 --> <input type="hidden" value="<%=request.getParameter("rev_store") %>" name="rev_store"/>
	<!-- 리뷰 주문메뉴 값 넘기기 --> <input type="hidden" value="<%=request.getParameter("rev_menu") %>" name="rev_menu"/>
     	
		<div class="star-rating space-x-4 mx-auto" id="div1">
		
			<!-- 별점마다 이모티콘 변경 -->
			<img src=" " width="45" height="45" >
			<input type="hidden" id="starScore" value="" />
						
			<input type="radio" id="5-stars" name="rating" value="5" v-model="ratings"/>
			<label for="5-stars" class="star" >★</label> <!-- class="star  pr-4" -->
			<input type="radio" id="4-stars" name="rating" value="4" v-model="ratings"/>
			<label for="4-stars" class="star">★</label>
			<input type="radio" id="3-stars" name="rating" value="3" v-model="ratings"/>
			<label for="3-stars" class="star">★</label>
			<input type="radio" id="2-stars" name="rating" value="2" v-model="ratings"/>
			<label for="2-stars" class="star">★</label>
			<input type="radio" id="1-stars" name="rating" value="1" v-model="ratings" />
			<label for="1-stars" class="star">★</label>
		</div><br>
      
         <table id="writeTable">
            <tr>
               <td class="td_left"><label for="board_content">내용</label></td>
               <td class="td_right">
                  <textarea id="board_content" name="rev_content" cols="40" rows="15" 
                  required="required" placeholder="예약에 대한 솔찍한 리뷰를 남겨주세요."></textarea>
               </td>
            </tr>
            <tr>
            	<td class="td_left"><label for="board_file">주문 메뉴</label></td>
            	<td class="td_right"><%=request.getParameter("rev_menu") %></td> <!-- db에서 가져오기 -->
            </tr>
            <tr>
               <td class="td_left"><label for="board_file">사진 첨부</label></td>
               <td class="td_right">
<!--                <input type="file" accept="image/jpeg, image/png, image/gif" name="rev_pic"  /><br> -->
<!--                <input type="file" accept="image/jpeg, image/png, image/gif" name="rev_pic"  /><br> -->
               <input type="file" accept="image/jpeg, image/png, image/gif" name="rev_pic"  />
               </td>
               
            </tr>
         </table>
         <section id="commandCell">
            <input type="submit" value="등록">
         </section>
      </form>
   </section>
   
</body>
</html>