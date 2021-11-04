<%@page import="vo.PageInfo"%>
<%@page import="vo.MemberBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
ArrayList<MemberBean> list = (ArrayList<MemberBean>)request.getAttribute("list");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
String alignType = (String)request.getAttribute("alignType");
int nowPage = pageInfo.getPage();
int maxPage = pageInfo.getMaxPage();
int startPage = pageInfo.getStartPage();
int endPage = pageInfo.getEndPage();
int listCount = pageInfo.getListCount();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="./js/jquery-3.6.0.js"></script>
<script type="text/javascript">
	
	function gradeBtn() {
		var sendGradeValue = $('form').serialize();
		
		var idArr = new Array(); //id를 담을 배열 생성
		$(':checkbox').each(function(i,item){
			//체크가 하나 이상일때 체크된 값을 가져옴
			if(i>0){
				if($(item).prop('checked')){
					//id 외의 문자열 자름
					var memberSplite = $('tr').eq(i).html().split('<td>')[3];
					var checkedId = memberSplite.split('</td>')[0];
					
					//배열에 저장
					idArr.push(checkedId);
				
				}
			}
		});
		
		var stringIdArr = ""; //파라미터로 넘길 문자열 선언
		
		for (var stringId of idArr) {
			stringIdArr += stringId;
			stringIdArr += ','; //추후 작업을 위해 ,로 구분
		}
		
		if(stringIdArr != ""){ //""이 아닐 때 ajax로 요청
			$.ajax({
				type:"get",
				data:sendGradeValue,
				dataType:"text",
				url:"ModifyMemberGrade.do?member="+stringIdArr
		}).done(function(data) {
			alert("변경되었습니다.");
		}).fail(function() {
			alert("변경 실패.");
		});
	}else{
		alert("항목을 선택해주세요");
	}
		
	}
	
	function memberDelete() {
		var idArr = new Array(); //id를 담을 배열 생성
		$(':checkbox').each(function(i,item){
			//체크가 하나 이상일때 체크된 값을 가져옴
			if(i>0){
				if($(item).prop('checked')){
					//id 외의 문자열 자름
					var memberSplite = $('tr').eq(i).html().split('<td>')[3];
					var checkedId = memberSplite.split('</td>')[0];
					
					//배열에 저장
					idArr.push(checkedId);
				
				}
			}
		});
		
		var stringIdArr = ""; //파라미터로 넘길 문자열 선언
		for (var stringId of idArr) {
			stringIdArr += stringId;
			stringIdArr += ','; //추후 작업을 위해 ,로 구분
		}
		
		if(stringIdArr != ""){ //""이 아닐 때 ajax로 요청
		$.ajax({
			type: "get",
			data: stringIdArr,
			url:"MemberDeleteAction.do?member="+stringIdArr
		}).done(function(data) {
			alert("삭제가 완료되었습니다.");
			location.reload();
		}).fail(function() {
			alert("삭제 실패.");
		});
	}else{
		alert("항목을 선택해주세요");
	}
	}
	
	$(function() {//전체선택 기능

		
		$('#checkAll').on('change',function(){
			if($('#checkAll').is(':checked')){
				$(':checkbox').each(function(i, item) {
					//인덱스가 0번인 요소를 제외한 모두를 선택
					if(i>0){
						$(item).prop('checked',true);
					}
				});
			}else{
				$(':checkbox').each(function(i, item) {
					//인덱스가 0번인 요소를 제외한 모두를 선택
					if(i>0){
						$(item).prop('checked',false);
					}
				});
			}
			
		});

	});
</script>
</head>
<body>
		<div id="list_wrap">
		<form>
		<input type ="button" value="회원삭제" onclick="memberDelete()">		
			<select id="gradeList" name="gradeList">
				<option value="1">일반회원</option>
						
				<option value="2">우수회원</option>
						
				<option value="3">단골회원</option>
						
				<option value="4">아주우수회원</option>
							
				<option value="5">관리자</option>
			</select>
			<input type ="button" value="등급조정" onclick="gradeBtn()">
		</form>
		<table>
        	<tr>
        		<th>
        			<input type="checkbox" id="checkAll">
        		</th>
        		<th>이름</th><th>아이디</th><th>닉네임</th><th>등급</th><th>가입날짜</th>
        	</tr>
        	
			<%for(int i=0;i<list.size();i++){%>
        	<tr>
        		<td><input type="checkbox" value="memberCheck" class="memberCheck" ></td>
        		<td ><%=list.get(i).getName() %></td>
        		<td ><%=list.get(i).getId() %></td>
        		<td ><%=list.get(i).getNickName() %></td>
        		<td><%=list.get(i).getGrade() %></td>
        		<td><%=list.get(i).getDate() %></td>
        		</tr>
			<%} %>	
		</table>
		</div>
		<div id="resultArea2"></div>

</body>
</html>