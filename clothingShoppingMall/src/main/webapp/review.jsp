<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	section.reviewForm {padding:30px 0;}
	section.reviewForm div.input_area {margin:10px 0;}
	section.reviewForm textarea {font-size:16px; font-family:'맑은 고딕', verdana; padding:10px; width:500px;; height:150px;}
	section.reviewForm button {font-size:20px; padding:5px 10px; margin:10px 0; background:#fff; border:1px solid #ccc;}
	 
	section.reviewList {padding:30px 0;}
	section.reviewList ol { padding:0; margin:0;}
	section.reviewList ol li {padding:10px 0; border-bottom:2px solid #eee;}
	section.reviewList div.userInfo {}
	section.reviewList div.userInfo .userId {font-size:24px; font-weight:bold;}
	section.reviewList div.userInfo .date {color:#999; display:inline-block; margin-left:10px;}
	section.reviewList div.reviewContent {padding:10px; margin:20px 0;}
</style>
	<!-- 함수로 사용할 스크립트들은 특별한 이유가 있지 않은 한 헤드 내부에 위치시킨다 -->
	<script>
		// 구매 후기 불러오기
		function reviewList(){ // reviewList()라는 함수로 생성
			var product_idx = ${view.product_idx};
			$.getJSON("/view/reviewList" + "?n=" + product_idx, function(data){ // 비동기식으로 제이슨(Json) 데이터를 가져옴
				var str = "";
				$(data).each(function(){
					console.log(data); // 콘솔에서 data 확인
					
					str += "<li data-product_idx='" + this.product_idx + "'>"
						+ "<div class='userInfo'>"
						+ "<span class='userName'>" + this.user_name + "</span>"
						+ "</div>"
						+ "<div class='review_content'>" + this.review_content + "</div>"
						+ "</li>";
				});
				
				$("section.reviewList ol").html(str);
			});
		}
	</script>
</head>
<body>
	<div id="total">
		<div id="top">
			<jsp:include page="memberTop.jsp"></jsp:include>
		</div>
		<div id="center">
		<!-- 후기 시작 -->
			<div id = "review">
				<!-- 비회원의 경우 -->
				<% if(session.getAttribute("user_id") == null) { %>
					<p> 후기를 남기시려면 <a href="member.jsp">로그인</a>해주세요</p>
				<% }else{ %>
				
				<!-- 회원의 경우 -->
				<section class="reviewForm">
					<form role="form" method="post" autocomplete="off">
						<input type="hidden" name="product_idx" value="${view.product_idx}">
						
						<!-- 후기 내용 작성 -->
						<div class="input_area">
							<textarea name="review_Content" id="review_Content"></textarea>
						</div>
							
						<div class="input_area">
							<button type="button" id="review_btn">후기 등록</button>
							<script>
								$("#review_btn").click(function(){
									var formObj = $(".reviewForm form[role='form']");
									var product_idx = $("#product_idx").val(); // 상품 번호 변수 선언
									var review_content = $("#review_content").val(); // 후기 내용 변수 선언
									
									$.ajax({
										url : "/views/ReviewCreate", // 데이터가 전송될 주소
										type : "post", // 타입
										data : data, // 전송될 데이터
										success : function(){ // 데이터 전송이 성공되었을 경우 실행할 함수부
											reviewList();
										},
										error: function() {
											alert('실패')
										}
									});
								});
							</script>
						</div>
					</form>
				</section>
				<% } %>
				
				<!-- 작성한 후기 목록 보여주기 -->
				<section class="reviewList">
					<ol>
					<%--
					<c:forEach items="${review}" var="review">
						<li>
							<div class="userInfo">
							<span class="userId">${review.user_name}</span>
			       			<span class="date"><fmt:formatDate value="${review.review_rgstdate}" pattern="yyyy-MM-dd" /></span>
			      			</div>
			      			<div class="reviewContent">${review.review_content}</div>
						</li>
					</c:forEach>
					--%>
					</ol>
					<script>
						reviewList(); // 헤더 내부에 선언한 함수를 호출
					</script>
				</section>
			</div>
			<!-- 후기 끝 -->
		</div>
	</div>
</body>
</html>