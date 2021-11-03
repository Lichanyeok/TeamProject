<%@page import="vo.ReviewBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int rev_num = Integer.parseInt(request.getParameter("rev_num"));
	ReviewBean article = (ReviewBean)request.getAttribute("article");
	int rev_score = (int)article.getRev_score();
%>    
<!DOCTYPE html>
<html>
<head>
<title>리뷰 작성</title>
<script src="./js/jquery-3.6.0.js"></script>
<script type="text/javascript">	
	$(document).ready(function() {
		
		// 별점에 따라서 이미지 변경
		$('#div1 > input[name=rating]').click(function() {
		
			if($(this).val() > 0) {
				$('#img_score').css({visibility: "visible"});
			}
			$('#div1 img').attr({src:"./review/rev_im/" + $(this).val() + ".png"});
			$('#starScore').val($(this).val());
		});
		
		// 이전 리뷰 작성 시 체크했던 별점 불러오기.
		$('input[name=rev_score]').each(function() {
			if($(this).val() != 0) {
				$('#' + $(this).val() + '-stars').attr('checked', true);
				$('#img_score').css({visibility: "visible"});
				$('#div1 img').attr({src:"./review/rev_im/" + $(this).val() + ".png"});
				$('#starScore').val($(this).val());
			}
		});
		
		// 사진 삭제 버튼 정의
		$('input[value=삭제]').on('click', function() {
			if (confirm("정말 삭제하시겠습니까??") == true){    //확인
			    $('img[name=prev_pic]').remove();
			    $('input[value=삭제]').remove();
			    $('input[name=prev_pic]').remove();
			    $('input[name=prev_pic_origin]').remove();
			}else{   //취소
			    return;
			}
		});
		
	}); // Jquery 마지막
		
</script>
<%
// session 객체에 저장된 id 값("sId" 속성) 가져오기
String sId = (String)session.getAttribute("sId"); // Object -> String 다운캐스팅

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
   
   table {
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


#img_score {
	visibility: hidden;
}
</style>
</head>
<body>
   
   <!-- 게시판 등록 -->
   <section id="writeForm" >
   
		<h1>000 국밥 00지점</h1>
		
	<form action="ReviewModifyPro.re" method="post" enctype="multipart/form-data" name="boardForm">
      <!-- 파일 업로드 기능을 사용하려면 cos.jar 라이브러리 등록 필수 -->
      	<input type="hidden" value="admin" name="rev_name"/>
      	<input type="hidden" value="<%=rev_num %>" name="rev_num"/>
      	<input type="hidden" value="<%=rev_score %>" name="rev_score"/>
     	
		<div class="star-rating space-x-4 mx-auto" id="div1">
		
			<!-- 별점마다 이모티콘 변경 -->
			<img id="img_score" src=" " width="45" height="45" >
			<input type="hidden" id="starScore" value="" />
			
			<input type="radio" id="5-stars" name="rating" value="5" v-model="ratings"/>
			<label for="5-stars" class="star" >★</label> <!-- class="star  pr-4" -->
			<input type="radio" id="4-stars" name="rating" value="4" v-model="ratings"/>
			<label for="4-stars" class="star">★</label>
			<input type="radio" id="3-stars" name="rating" value="3" v-model="ratings"/>
			<label for="3-stars" class="star">★</label>
			<input type="radio" id="2-stars" name="rating" value="2" v-model="ratings" />
			<label for="2-stars" class="star">★</label>
			<input type="radio" id="1-stars" name="rating" value="1" v-model="ratings" />
			<label for="1-stars" class="star">★</label>
			
		</div><br>
      
         <table>
            <tr>
               <td class="td_left"><label for="board_subject">제목</label></td>
               <td class="td_right"><input type="text" name="rev_subject" required="required" value="<%=article.getRev_subject() %>" /></td>
            </tr>
            <tr>
				<td class="td_left"><label for="board_pass">비밀번호</label></td>
				<td class="td_right">
					<input type="password" name="rev_pass" required="required" />
				</td>
			</tr>
            <tr>
               <td class="td_left"><label for="board_content">내용</label></td>
               <td class="td_right">
                  <textarea id="board_content" name="rev_content" cols="40" rows="15" 
                  required="required" placeholder="예약에 대한 솔찍한 리뷰를 남겨주세요."><%=article.getRev_content() %></textarea>
               </td>
            </tr>
            <tr>
            	<td class="td_left"><label for="board_file">주문 메뉴</label></td>
            	<td class="td_right"> 00 외 2종</td> <!-- db에서 가져오기 -->
            </tr>
            <tr>
            	<%
            		String pic = article.getRev_pic(); 
            		String pic_origin = article.getRev_pic_origin(); 
            	%>
               <td class="td_left"><label for="board_file">사진 첨부</label></td>
               <td class="td_right"><%if(pic != null) {%><img src="./upload/<%=pic_origin %>" width="300" height="300" name="prev_pic"/><br>
					<input type="button" value="삭제"/>
					<input type="hidden" name="prev_pic" value="<%=pic %>" />
					<input type="hidden" name="prev_pic_origin" value="<%=pic_origin %>" />
					<%} %><br><input type="file" accept="image/jpeg, image/png, image/gif" name="rev_pic"  />
               </td>
            </tr>
         </table>
         <section id="commandCell">
            <input type="submit" value="수정">
            <input type="button" value="취소" onclick="history.back()">
         </section>
      </form>
   </section>
   
</body>
</html>