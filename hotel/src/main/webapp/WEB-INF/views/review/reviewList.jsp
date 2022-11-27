<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/includes/G_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 리뷰 목록</title>
</head>
<link rel="stylesheet" href="/hotel/css/reset.css"/>
<link rel="stylesheet" href="/hotel/css/contents.css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<script type="text/javascript">
	
	function getReview(){
		$.ajax({
			type:"GET",
			url : "../review/list.do",
			async:false,
			data : {
				guest_no : ${loginInfo.guest_no}
			},
			success : function(res){
				$("#reviewArea").html(res);
			}
		});
	}
		
	$(function() {
		getReview();
		
		$(".btn-cancel").on("click",function(event){
			
			$(".outer-div-modi").hide();
			$(".outer-div").show();
			$("input[name=filename]").val("");
			
			$(".preview").attr("src","");
		})
		
			
		/* 별점 */
		$(".score img").hover(function(){
			var review_no = $(this).data('review_no');
			var target = "#outer-div-modi"+review_no+" .score img";
			var idx = $(this).index(target); //오버한 객체의 인덱스값
			console.log('idx:'+idx);
			for(var i=0; i<$(target).length;i++){
				if(i<=idx){
					$(target).eq(i).attr("src","/hotel/image/mypage/star_icon.png")			
				}else{
					$(target).eq(i).attr("src","/hotel/image/mypage/emptyStar_icon.png")
				}
			}
		},function(){
			var review_no = $(this).data('review_no');
			var target = "#outer-div-modi"+review_no+" .score img";
			
			for(var i=0; i<$(target).length;i++){
				if(i < $("#outer-div-modi"+review_no+" input[name=review_score]").val()){
					$(target).eq(i).attr("src","/hotel/image/mypage/star_icon.png")	
				}else{
					$(target).eq(i).attr("src","/hotel/image/mypage/emptyStar_icon.png")
				}
			}
		});
		$(".score img").click(function(){
			var review_no = $(this).data('review_no');
			var target = "#outer-div-modi"+review_no+" .score img";
			var idx = $(this).index(target);
			console.log(idx);
			$("#outer-div-modi"+review_no+' input[name=review_score]').val(idx+1);
			var r =$("#outer-div-modi"+review_no+' input[name=review_score]').val();
			console.log(r);
		});
		
	})//$(function(){})-end
	
	function del(review_no){
		
		if(confirm("정말 삭제하시겠습니까?")){
			
		
		$.ajax({
			type:"post",
			url:"../review/del.do",
			data:{review_no:review_no},
			error:function(er){
				alert("ERROR");
			},
			success:function(){
				alert(review_no+"가 삭제되었습니다");
				window.location.reload();
			}
		});
		}
	}
	
	function modi(review_no){
		
		var target = "#outer-div-modi"+review_no+" #"+review_no;
		var v = $(target).val();
		var target2 = "#outer-div-modi"+review_no+" .score img";
		
		for(var i=0; i<5;i++){
			if(i < v){
				$(target2).eq(i).attr("src","/hotel/image/mypage/star_icon.png")	
			}else{
				$(target2).eq(i).attr("src","/hotel/image/mypage/emptyStar_icon.png")
			}
		}
		
		$(".outer-div").show();
		$("#outer-div"+review_no).hide();
		$(".outer-div-modi").hide();
		$("#outer-div-modi"+review_no).show();
		
	}
	
	function cancel(){
		return;
	}
	
	function imgDel(image_no){
		console.log(image_no)
		$("#imgSpan"+image_no).hide();
		
		$.ajax({
			type: "GET",
			url: "../guest_review/delImg.do",
			data:{image_no:image_no},
			error:function(er){
				$("#imgSpan"+image_no).show();
			},
			success: function(res){
				alert("사진이 삭제되었습니다.")
				$("#imgSpan"+image_no+" img").attr("src", "");
				$(".img-fluid"+image_no).attr("src", "/hotel/image/mypage/noImage.png");
				
				$("#imgAtc"+image_no).show();
								
			}
		})//END_ajax
	}//END_imgDel
		
	function readURL(input, image_no) {
		  if (input.files && input.files[0]) {
		    var reader = new FileReader();
		    reader.onload = function(e) {
				
				document.getElementById('preview'+image_no).src = e.target.result;
				
		    };
		    reader.readAsDataURL(input.files[0]);
		  } else {
		    document.getElementById('preview'+image_no).src = "";
		  }
		}//END_readURL	
		
		
	

</script>
<body style="padding:50px;">
	<div class="container"style="text-align: center; padding:75px;">
		<h1>내가 쓴 리뷰s</h1>
	</div>	
		<div >
			<div id="reviewArea"></div>
		</div>

	
	

</body>
</html>