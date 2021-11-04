<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/style.css">
<style type="text/css">k,
</style>
<script src="./js/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(function() {
		
		
		
		$('#sendCouponBtn').on('click',function(){
// 			var coupon_name = $('#coupon_name option:selected').text();
// 			var coupon_value = $('#coupon_value option:selected').text();
// 			var coupon_price = $('#coupon_price option:selected').text();
// 			var coupon_target = $('#coupon_target option:selected').text();
// 			alert(coupon_name);
			
// 			var sendSelectedData = "";//파라미터로 보낼 데이터 저장 변수
			var pa = 0; // 셀렉트박스 인덱스 0번이 아님을 판별하는 변수
			
			$('select').each(function(i,item) {
				if(0!=$(item).val()){
					pa++;
				}
			});
			
			if(pa==4){
				var sendFormData = $('form').serialize();

				$.ajax({
					type: "GET",
					data: sendFormData,
					dataType: "text",
					url:"PublishCoupon.do"
				}).done(function(data) {
					alert('발송 성공!')
					$('#resultArea').html(data);
				}).fail(function() {
					alert('쿠폰 발송에 실패했습니다.');
				});
			}else{
				alert('선택 내용을 확인해주세요.');
			}
			
		});
	});
</script>
</head>
<body>
		<!-- 상위 고정 -->
        <jsp:include page="/inc/header.jsp"></jsp:include>
        <!-- 상위 고정 -->
        <div id="coupon_form_wrap">
        <form>
        	<select id="coupon_name" name="coupon_name">
        		<option disabled="disabled">쿠폰명을 선택해주세요!</option>
        		<option value="2">우수고객 정기 할인쿠폰</option>
        		<option value="3">단골고객 정기 할인쿠폰</option>
        		<option value="4">더우수고객 정기 할인쿠폰</option>
        	</select>
        	<select id="coupon_value" name="coupon_value">
        		<option disabled="disabled">쿠폰내용을 선택해주세요!</option>
        		<option value="2">1000원 할인</option>
        		<option value="3">2000원 할인</option>
        		<option value="4">3000원 할인</option>
        	</select>
        	<select id="coupon_price" name="coupon_price">
        		<option disabled="disabled">할인금액을 선택해주세요!</option>
        		<option value="2">1000</option>
        		<option value="3">2000</option>
        		<option value="4">3000</option>
        	</select>
        	<select id="coupon_target" name="coupon_target">
        		<option disabled="disabled">지급 대상을 선택하세요!</option>
        		<option value="1">전체 회원</option>
        		<option value="2">일반 회원</option>
        		<option value="3">우수 회원</option>
        		<option value="4">더우수 회원</option>
        	</select>
        	<button id="sendCouponBtn">발송</button>
        </form>
        </div>
		<div id="resultArea">
		-
		</div>
</body>
</html>