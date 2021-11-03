<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="vo.PageInfo"%>
<%@page import="vo.ReserveBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	String sId = session.getAttribute("sId").toString();
	ArrayList<ReserveBean> reserveList = (ArrayList<ReserveBean>)request.getAttribute("reserveList"); 
	request.setCharacterEncoding("utf-8");
	PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
	int nowPage = pageInfo.getPage();
	int maxPage = pageInfo.getMaxPage();
	int startPage = pageInfo.getStartPage();
	int endPage = pageInfo.getEndPage();
	int listCount = pageInfo.getListCount();
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	Calendar c1 = Calendar.getInstance();
	String today = sdf.format(c1.getTime());
	
	
	
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/reserve_list.css">
    <title>reserve_list</title>
<script src="./js/jquery-3.6.0.js"></script>
<script type="text/javascript">
	function copy_code(num){
		var reserve_code = document.getElementById('reserve_code'+num).innerHTML;
// 		alert(reserve_code);
		var code = reserve_code.split('<b')[0];
// 		alert(code);
		$('#clip_target').val(code);
		$('#clip_target').select(); // Use try & catch for unsupported browser 
		try { // The important part (copy selected text) 
		var successful = document.execCommand('copy'); 
		if(successful){
			alert('복사되었습니다.')
		}else{
			alert('복사실패.')
		}
		} catch (err) { alert('이 브라우저는 지원하지 않습니다.') }

	}
	
	function doPost(reserveNum) {
		
		// 동적 form - post 처리
	    var form = document.createElement("form");
        form.setAttribute("charset", "UTF-8"); // post 한글처리
        form.setAttribute("method", "post");  // post 방식
        form.setAttribute("action", "ReviewWrite.re"); // 요청 보낼 주소

     	// 예약번호
        var doPost = document.createElement("input");
        doPost.setAttribute("type", "hidden");
        doPost.setAttribute("name", "ran_num");
        doPost.setAttribute("value", $('.ran_num' + reserveNum).val());
        form.appendChild(doPost);
		// 예약 매장명
        doPost = document.createElement("input");
        doPost.setAttribute("type", "hidden");
        doPost.setAttribute("name", "rev_store");
        doPost.setAttribute("value", $('.rev_store' + reserveNum).val());
        form.appendChild(doPost);
   		// 예약 메뉴
        doPost = document.createElement("input");
        doPost.setAttribute("type", "hidden");
        doPost.setAttribute("name", "rev_menu");
        doPost.setAttribute("value", $('.rev_menu' + reserveNum).val());
        form.appendChild(doPost);

        document.body.appendChild(form);
        form.submit();
	}
</script>
</head>
<body>
		<!-- 상위 고정 -->
        <jsp:include page="../inc/header.jsp"></jsp:include>
        <!-- 상위 고정 -->
    <div class = "reserve_list_wrap">
        <h1><%=sId%>님의 예약리스트</h1>
        <table>
            <colgroup>
                <col width="142px">
                <col width="142px">
                <col width="142px">
                <col width="142px">
                <col width="247px">
                <col width="142px">
                <col width="142px">
            </colgroup>
            <thead>
            <%
			if(reserveList != null && listCount > 0) {
			%>
                <tr>
                    <th scope="col">예약코드</th>
                    <th scope="col">예약자명</th>
                    <th scope="col">예약날짜</th>
                    <th scope="col">예약시간</th>
                    <th scope="col">예약정보</th>
                    <th scope="col">음식점정보</th>
                    <th scope="col">결제금액</th>
                    <th scope="col">리뷰작성</th>
                </tr>
            </thead>
            <tbody class ="info">
                <table>
                    <colgroup>
                        <col width="142px">
                        <col width="142px">
                        <col width="142px">
                        <col width="142px">
                        <col width="247px">
                        <col width="142px">
                        <col width="112px">
                        <col width="172px">
                    </colgroup>
                    <tbody>

                    <%for(int i=0;i<reserveList.size();i++){%>
                      
                    <!-------------------- 리뷰 작성에 사용할 값을 저장하는 hidden 태그 작성 -------------------->
	                    <input type="hidden" class="ran_num<%=i %>" value="<%=reserveList.get(i).getRan_num()%>" />
	                    <input type="hidden" class="rev_store<%=i %>" value="<%=reserveList.get(i).getStoreName()%>" />
	                    <input type="hidden" class="rev_menu<%=i %>" value="<%=reserveList.get(i).getTotal_order_menu()%>" />
                    <!-- ---------------------------------------------------------------------------------------------------- -->
                    <%boolean isGone = reserveList.get(i).getReserve_date().compareTo(today) > 0; %>
                        <td id="reserve_code<%=i%>"><%=reserveList.get(i).getRan_num()%><button onclick="copy_code(<%=i%>)">복사</button> </td>
                        <td><%=reserveList.get(i).getId()%></td>
					 <%if(isGone){%>
                        <td><%=reserveList.get(i).getReserve_date()%></td>
                     <%}else{ %>
                     	<td>기간이 지난 목록입니다</td>
                     <%} %>
                        <td><%=reserveList.get(i).getReserve_time()%></td>
                        <td>
                        <%=reserveList.get(i).getTotal_order_menu()%><br>
                        <%=reserveList.get(i).getPeople() %>명
                        </td>
                        <td>
                        <%=reserveList.get(i).getStoreName()%><br>
                        <%=reserveList.get(i).getLoadAddress()%><br>
                        <%=reserveList.get(i).getAddress()%><br>
                        <%=reserveList.get(i).getStoreNumber()%><br>
                        </td>
                        <%if(reserveList.get(i).getReserve_type()>0){ %>
	                        <td><%=reserveList.get(i).getPayment_price() %>원</td>
	                        <%}else{ %>
	                        <td>현장결제입니다.</td>
                        <%} %>
                        <%if(!isGone){ %>
 						<td><button disabled="disabled">기간만료</button></td>	
                        <%}else if(reserveList.get(i).getCheck_review()<1){%>
                        <td id="rev_btn"><a><button onclick="doPost(<%=i %>)">리뷰쓰기</button></a></td>
                        <%}else{ %>
                        <td><a href="Review.re?nickName=<%=session.getAttribute("sNn") %>"><button>작성한 리뷰 보러가기</button></a></td>
                        <%} %>
                    </tbody>
                    <%} %>
                </table>
            </tbody>
        </table>
        <input id="clip_target" type="text" value="" style="position:absolute;top:-9999em;"/>
        <section id="pageList">
	<%if(nowPage <= 1) {%>
			<input type="button" value="이전">&nbsp;
	<%} else {%>
			<input type="button" value="이전" onclick="location.href='ReserveList.do?page=<%=nowPage - 1 %>'">&nbsp;
	<%} %>
	
	<%for(int i = startPage; i <= endPage; i++) { 
			if(i == nowPage) { %>
				[<%=i %>]
		<%} else { %>
				<a href="ReserveList.do?page=<%=i %>">[<%=i %>]</a>&nbsp;
		<%} %>
	<%} %>
	
	<%if(nowPage >= maxPage) { %>
			<input type="button" value="다음">
	<%} else { %>
			<input type="button" value="다음" onclick="location.href='ReserveList.do?page=<%=nowPage + 1 %>'">
	<%} %>
	<button id="ecBtn" onclick="location.href='EACForm.do'">예약 변경/취소</button>
	</section>
	<%
	}else {
%>
	<h1>예약 내역이 없습니다.</h1>
<% 
 	}
%> 
	
    </div>
</body>
</html>