<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<style>
 .product_left{
 float:left;  max-width:50%; max-height: auto;display: block;
}
.product_right{
 float:right; max-width: 50%; display: block;
} */
/* .main_product_img{
  max-width:500px;
} */


</style>
<meta charset="UTF-8">
<title>상품 상세 페이지</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<link rel = "stylesheet" type = "text/css" href = "resources/css/project.css">


<script type="text/javascript">
$(function () {
	$('#add').click(function(){
	
	$.ajax({
		url: 'productAdd',
		data : {
			//ISDN, 이름, 가격, 
			product_idx: '${one.product_idx}', //string 
			product_title:'${one.product_title}', //string
			product_price: ${one.product_price} //int
		},
		success: function(result){
			alert(result)
			if(confirm("장바구니를 확인하시겠습니까?")){
				location.href ="basket.jsp"
			}
		},
		error: function(){
			alert("ajax 에러 발생.")
			}//error
		});//ajax
	});//click


$('#deleteBtn').click(function() {
	if(confirm("정말로 삭제하시겠습니까?")){
		$.ajax({
			url: "productDel",
			data: {
				product_idx: ${one.product_idx}	
			},
			success : function(result) {
				if(result == '1'){
					location.href = "productList.jsp"
					}
				},
			error:function(){
				alert('삭제 실패')
				}
			});
		}
	});
	
		/* $('#love').click(function() {
		$.ajax({
			url:"createMemberLike",
			data:{
				user_id: ${user_id}
				product_idx : ${product_idx}
			},
			success: 

			 }
		   }
		
		})
	})
		
		$.ajax({
			url:"selectMemberLikeOne",
			data:{
				user_id: ${user_id}
				product_idx : ${product_idx}
			},
			success: function(data) { 
				if(data == 1) {

				} else {

			 }
		   }
			
		})//ajax  */
		
		//에러를 찾기 위함. 
		 error: (error) => {
             console.log(JSON.stringify(error));
		}
		 
		 
		$.ajax({
			url:'getProductIdxByLike',
			type:'get',
			success:function(jsonData){
				
				
				product_idx = []; 
				likecheck = []; 
				
				$(jsonData).each(function(index,item){
					product_idx.push(item.product_idx); 
					likecheck.push(item.likecheck); 
				});
				
				console.log('product_idx'+product_idx)
				console.log('likecheck'+likecheck)
				
				
				
				
				
				
				let data = {
						
						labels : product_idx,
						datasets : [{
							
							label : 'ProductIdx by Like number',
							data: likecheck,
							backgroundColor : [
								
								  'rgba(255, 99, 132, 0.2)',
							      'rgba(255, 159, 64, 0.2)',
							      'rgba(255, 205, 86, 0.2)',
							      'rgba(75, 192, 192, 0.2)',
							      'rgba(54, 162, 235, 0.2)',
							      'rgba(153, 102, 255, 0.2)',
							      'rgba(201, 203, 207, 0.2)'
								
							],
							borderColor: [
								
								 'rgb(255, 99, 132)',
							      'rgb(255, 159, 64)',
							      'rgb(255, 205, 86)',
							      'rgb(75, 192, 192)',
							      'rgb(54, 162, 235)',
							      'rgb(153, 102, 255)',
							      'rgb(201, 203, 207)'
							
							],
							
							borderWidth: 1
							
							}]	
						
					}; //let data
					
					let config = {
										type: 'bar', 
										data : data, 
										options : {
											scales:{
												y:{
													beginAtZero:true
												}
											}
										},
								};
					
							var myChart = new Chart(document.getElementById('myChart'), config); 
				
						}
			
			
				});
		

	
	
	

}); 


</script>
</head>
<body>

<%-- <span style="color: blue; float: right;">${userId}님 로그인되었습니다. 좋은 하루 되세요.</span><br> --%>
	<div id = "top">
		<jsp:include page="../../top.jsp"></jsp:include>
	   <a href="productList.jsp">리스트 목록으로 </a>
	</div> 
	
	
	<!-- 상품 정보 -->
    <div class="product_left"> 
   	   <img src="resources/img/${one.product_img}" style = width:50%; >
     	 <div class="product_right"> 
		     <div style="display: none;">${one.product_idx}</div> <!-- one.getId() -->
		     <div>이름:${one.product_title}</div> 
		     <div>가격:${one.product_price}</div>
		     <div>카테고리:${one.product_category}</div>
		    <%--  <div>좋아요 수:${one.product_like}</div>  --%>
		     <div>상세 설명:${one.product_description}</div>
	      	 <div>등록일:${one.product_rgstdate.substring(0,10)}</div> 
	      	 <div>수정일:${one.product_mdfydate} </div>
		      	 
		      	 <button>바로구매</button> 

		      	 
		      	 
		      	 
		      	 
		      	 
		      	 
		      	 
		      	 
		      	 <button id = "love">♡
		      	 		<c:choose>
							<c:when test = "${likecheck}==null">
								♡
							
							</c:when>
							
							<c:when test="${likecheck}==1">
								❤
							</c:when>	      	 		
		      	 		</c:choose>
		      	 </button> 
		      	 
		      	 
		      	 
		      	 
		      	 
		      	 
		      	 

		      	 <button id = "add">장바구니</button> 
		      	 <button><a href="reviewList.jsp?product_idx=${one.product_idx}">리뷰 보기</a></button>
		     <!-- 카테고리, 좋아요, 작업 이후에  구현되도록 수정할 것. -->
		    </div>
     	 <div>
	      	 <a href="productInsert"><button>상품 생성</button></a>

			 <a href="productUp?product_idx=${one.product_idx}"><button>상품 내용 수정</button></a>

			 <button id="deleteBtn">상품 삭제</button>
      	 </div>
      	 
      	 <!-- 차트를 생성하려면 Chart 클래스를 인스턴스화 차트를 그리고 싶은 캔버스의 노드, jQuery 인스턴스 또는 2D 컨텍스트를 전달 -->
      	 <canvas id="myChart" width = "400" height = "400"></canvas>
      	 
      	 
      	 	<!-- -------------------------------------------- -->
	 	<!-- <img src="resources/img/buy.PNG" style = width:30%;> 
		 <img src="resources/img/love2.PNG" style = width:30%;> 
		 <img id = "add" src="resources/img/basketimg.PNG" style = width:30%;>
		 -->	
  </div>	 
	  
	      <!-- </div> -->
   <!--  </div> -->
   	
<div id = "total">
<!-- 유저아이디가 admin 관리자인경우 S버튼 활성화 -->
	<!-- <%--  <% if (session.getAttribute("user_id").equals("admin")) {    %> --%>-->
	<!--	<a href="productInsert"><button>생성</button></a>-->
	<!--	<a href="productUp?p_idx=${one.product_idx}"><button id="updateBtn" style="width: 50px;">수정</button></a>-->
	<!--	<button id="deleteBtn" style="width: 50px;">삭제</button>-->
	<!--<%-- -<%}else { %> --%>-->
		<%-- <a href="productInsert"><button style="display:none;">생성</button></a>
		<a href="productUp?p_idx=${one.product_idx}"><button style="display:none;">수정</button></a>
		<button id="deleteBtn" style="display:none;">삭제</button> --%>
	<!-- ========================================================================= -->
	
		
		<a href="productInsert"><button style="display:none;">생성</button></a>
		<a href="productUp?p_idx=${one.product_idx}"><button style="display:none;">수정</button></a>
		<button id="deleteBtn" style="display:none;">삭제</button>
	

	
	<!-- ========================================================================= -->
	
	
	
	
	
	<!--<%-- <%}%> --%>-->
</div>
</body>
</html>