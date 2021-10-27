<%@page import="vo.ReviewBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	// 전달받은 request 객체로부터 데이터 가져오기
	// "pageInfo" 객체와 "articleList" 객체를 request 객체로부터 꺼내서 저장
	// "pageInfo" 객체로부터 페이지 관련 값들을 꺼내서 변수에 저장
	ArrayList<ReviewBean> articleList = (ArrayList<ReviewBean>)request.getAttribute("articleList");
	ReviewBean reviewData = (ReviewBean)request.getAttribute("reviewData");
	// 	out.println("rev_list.jsp - articleList : " + articleList);
	// 	out.println("rev_list.jsp - reviewCount : " + reviewCount);
	double totalScore = reviewData.getTotalScore() / reviewData.getListCount(); // 가져온 리뷰 점수 평균 작업
	%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Review_Test</title>
<script src="./js/jquery-3.6.0.js"></script>
<script type="text/javascript">	
	$(document).ready(function() {
		$('input[name=isRev_pic]').on('click', function() {
			if($(this).is(':checked', true)) {
// 				alert('체크 됨');
// 				.hide(); 사진 없는 리뷰 숨기기
				alert($("#rev_contents").val());
			} else {
// 				alert('체크 해제');
// 				.show(); 사진 없는 리뷰 보이기
			}
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
		
		// 스토어 별점 버튼 기능 없애기 (눌렀을때 변경 못하게 설정)
		$('input[name=rating]').click(false);
	});
</script>
<style type="text/css">
/* ---------- 별 모양 css -------------------- */

.star-rating {
  display: flex;
  flex-direction: row-reverse;
  font-size: 1.25rem;
  line-height: 1.5rem;
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
 
.star-rating space-x-4 mx-auto {
text-align: center;

}

#rev_store {
	text-align: center;
	font-size: 3em;
	padding: 0.5em;
}

#rev_score {
	text-align: center;
	font-size: 3em;
}

#rev_contents {
	float: right;
	width: 1000px;
}

/* -------- 리뷰 목록 css -------- */
#rev_name, #rev_subject, #rev_date {
	width: 200px;
	display: inline-block;
	margin: 20px;
	border: 1px solid;
}

#rev_content {
	width: 680px;
	height: 400px;
	margin: 20px;
	border: 1px solid;
}

#rev_menu {
	width: 238px;
	margin: 20px;
	display: inline-block;
	border: 1px solid;
}

#rev_menu_btn {
	width: 238px;
	margin: 20px;
/* 	float: right; */
	display: inline-block;
	border: 1px solid;
}
</style>
</head>
<body>
	<div id="wrap">
		<!----------------------- 헤더(hearder) 포함 --------------------->
		<jsp:include page="./Top.jsp"/>
		<!-- 본문 메인 이미지  -->
		<div id="sub_img_center"></div>
		<!-- 본문 좌측 메뉴 -->
		<input type="hidden" value="<%=Math.round(totalScore) %>" name="rev_score"/>
		
		<nav id="sub_menu">
			<table>
				<tr>
					<th id="rev_store" colspan="2">&nbsp;000 음식점</th>
				</tr>
				<tr>
					<td rowspan="2" id="rev_score" ><%=Math.round(totalScore*10)/10.0 %></td>
					<td>
						<div class="star-rating space-x-4 mx-auto" id="div1">					
							<input type="radio" id="5-stars" name="rating" value="5" v-model="ratings" />
							<label for="5-stars" class="star" >★</label> <!-- class="star  pr-4" -->
							<input type="radio" id="4-stars" name="rating" value="4" v-model="ratings" />
							<label for="4-stars" class="star">★</label>
							<input type="radio" id="3-stars" name="rating" value="3" v-model="ratings" />
							<label for="3-stars" class="star">★</label>
							<input type="radio" id="2-stars" name="rating" value="2" v-model="ratings" />
							<label for="2-stars" class="star">★</label>
							<input type="radio" id="1-stars" name="rating" value="1" v-model="ratings" />
							<label for="1-stars" class="star">★</label>
						</div>
					</td>
				</tr>
				<tr>
					<td><h3>리뷰 <%=reviewData.getListCount() %>개</h3></td>
				</tr>
				<tr>
					<td>
						<input type="checkbox" name="isRev_pic" /> 포토리뷰
					</td>
				</tr>
				<tr>
					<td>
						<select>
							<option disabled="disabled">리뷰 정렬</option>
							<option>최신순</option>
							<option>리뷰 도움순</option>
							<option>별점 높은 순</option>
							<option>별점 낮은 순</option>
						</select>
					</td>
				</tr>
			</table>
		</nav>
		
		<!-- 리뷰 게시물 목록 표시 -->
		<%
			for(int i = 0; i < articleList.size(); i++) {
				String str = articleList.get(i).getRev_pic_origin();
		%>
		<div id="rev_contents" value="<%=str %>">
		
				<div id="rev_name">아이디 : <%=articleList.get(i).getRev_name() %></div><div id="rev_subject">제목 : <%=articleList.get(i).getRev_subject() %></div><div id="rev_date"><%=articleList.get(i).getRev_date() %></div>
				<div id="rev_content"><%if(articleList.get(i).getRev_pic_origin() != null) { %><img src="./upload/<%=str %>" width="300" height="300" /><br><%} %><%=articleList.get(i).getRev_content() %></div>
				<div id="rev_menu">주문메뉴 : <%=articleList.get(i).getRev_menu() %></div>
				<div id="rev_menu_btn">
					<input type="button" name="rev_modify" value="수정" onclick="location.href='./ReviewModify.re?rev_num=<%=articleList.get(i).getRev_num() %>'"/>&nbsp;
					<input type="button" name="rev_delete" value="삭제" onclick="location.href='./ReviewDelete.re?rev_num=<%=articleList.get(i).getRev_num() %>'"/>
				</div><br>
			<%}%>
		</div>
		<div class="clear"></div>
		<!----------------------- 푸터(Footer) 들어가는 곳 ---------------------->
		
		<!----------------------- 푸터(Footer) 들어가는 곳 ---------------------->
	</div>
</body>
</html>