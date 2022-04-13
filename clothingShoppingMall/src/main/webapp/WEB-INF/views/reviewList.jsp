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
	section.reviewList div.reviewFooter button { font-size:14px; border: 1px solid #999; background:none; margin-right:10px;}
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
					
					// 날짜 표현 방식 변경
					Timestamp review_rgstdate = new Timestamp(System.currentTimeMills());
					SimpleDateFormat format = nwe SimpleDateFormat("yyyy-MM-dd");
					
					// HTML 코드 조립
					str += "<li data-review_idx='" + this.review_idx + "'>"
						+ "<div class='userInfo'>"
						+ "<span class='userName'>" + this.user_name + "</span>"
						+ "<span class='date'>" + review_rgstdate + "</span>"
						+ "</div>"
						+ "<div class='review_content'>" + this.review_content + "</div>"
						+ "<c:if test='${userId != null}'>"
						+ "<div class='reviewFooter'>"
						+ "<button type='button' class='modify' data-review_idx='" + this.review_idx + "'>수정</button>"
						+ "<button type='button' class='delete' data-review_idx='" + this.review_idx + "'>삭제</button>"
						+ "</c:if>"
						+ "</li>";
				});
				
				$("section.reviewList ol").html(str);
			});
		}
	</script>
</head>
<body>
	<div id="center">
	<!-- 후기 시작 -->
		<div id = "review">
			<!-- 비회원의 경우 -->
			<% if(session.getAttribute("UserId") == null) { %>
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
									url : "/reviewList/reviewCreate", // 데이터가 전송될 주소
									type : "post", // 타입
									data : data, // 전송될 데이터
									success : function(){ // 데이터 전송이 성공되었을 경우 실행할 함수부
										reviewList();
										${"#review_content"}.val("");
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
				<!-- 수정 버튼 스크립트 -->
				<script>
					$(document).on("click", ".modify", function(){
						$(".reviewModal").fadeIn(200);
						
						var review_idx = $(this).attr("data-review_idx"); // 변수 review_idx에 버튼에 부여된 review_idx 저장
						var review_content = $(this).parent().parent().children(".review_content").text(); // 변수 review_content에 버튼의 부모의 부모에서 자식 클래스가 review_content인 요소 값 저장
						
						$(".modal_review_content").val(review_content);
						$(".modal_modify_btn").attr("data-review_idx", review_idx);
					});
				</script>
				<script>
					$(document).on("click", ".delete", function(){ // .on() 메서드 : 클릭 메서드
						/*
							confirm 메서드
							내부의 텍스트를 사용자에게 보여주며 확인 버튼과 취소 버튼을 같이 보여준다
							확인 버튼을 클릭하면 참을 반환하고 취소 버튼을 클릭하면 거짓을 반환한다.
						*/
						var deleteConfirm = confirm("정말로 삭제하시겠습니까? 삭제 후 복구가 불가능합니다.");
						if(deleteConfirm){
							var data = {review_idx : $(this).attr("data-review_idx")}; // ajax를 통해 data-review_idx 값을 전달
							
							$.ajax({ // 후기 삭제 관련 ajax
								url : "/reviewList/reviewDelete",
								type : "post",
								data : data,
								success : function(result){
									if(result == 1) {
										reviewList();
									} else {
										alert("작성자 본인만 후기 삭제가 가능합니다")
									}
								},
								error: function(){ // 로그인하지 않은 상태에서 버튼을 눌렀을 경우
									alert("로그인해주세요.")
								}
							});
						}	
					});
				</script>
			</section>
		</div>
	</div>
	<div class="reviewModal">
		<div class="modalContent">
			<div>
				<textarea class="modal_review_Content" name="modal_review_Content"></textarea>
			</div>
			
			<div>
				<button type="button" class="madal_modify_btn">후기 수정</button>
				<button type="button" class="madal_cancel">수정 취소</button>
			</div>
		</div>
		<div class="modalBackground"></div>
	</div>
	<!-- 수정 취소 버튼 스크립트 -->
	<script>
	$(".modal_cancel").click(function(){
		$(".replyModal").fadeOut(200);
	});
	</script>
	<script>
	$(".modal_modify_btn").click(function(){
		var modifyConfirm = confirm("정말로 수정하시겠습니까? 삭제 후 복구가 불가능합니다.");
		
		if(modifyConfirm){
			var data = {
						review_idx : $(this).attr("data-review_idx"),
						review_Content: $('.modal_review_content').val()
					}; //reviewVO 형태로 데이터 생성
			
			$.ajax({ // 후기 수정 관련 ajax
				url : "/reviewList/reviewUpdate",
				type : "post",
				data : data,
				success : function(result){
					
					// result 값에 따라 동작
					if(result == 1) {
						reviewList();
					} else {
						alert("작성자 본인만 후기 수정이 가능합니다")
					}
				},
				error: function(){ // 로그인하지 않은 상태에서 버튼을 눌렀을 경우
					alert("로그인해주세요.")
				}
			});
		}	
	});
</script>
</body>
</html>