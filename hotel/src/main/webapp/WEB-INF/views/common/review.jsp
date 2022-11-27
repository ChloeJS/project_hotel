<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Reviews</title>
    <link rel="stylesheet" href="/css/reset.css"/>
    <link rel="stylesheet" href="/css/contents.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    
    

<style type="text/css">
	.score{
		position: absolute;
		right: 20px;
		top: 10px;
		font-size: 20px;
	}
	#score{
		position: absolute;
		right: 20px;
		top: 10px;
		font-size: 20px;
	}
	.outer-div{
		display: flex;
		justify-content: center;
		margin: 30px 0 30px 0;
	}
	.outer-div-modi{
		display: flex;
		justify-content: center;
		margin: 30px 0 30px 0;
	
	}
	body form{
		display: flex;
		justify-content: center;
	}
	#card-content{
		font-size: 15px;
		margin-top: 5%;
	
	}
	.content-box{
		border: 1px solid gray; 
		width: 100%; 
		height: 80px; 
		margin-top: 5px;
	}
	.card{
		position: relative;
	}
	.btn-box{
		position: absolute;
		right: 20px;
		bottom: 20px;
	}
	.outer-div-modi{
		display: flex;
		justify-content: center;
		display: none;
		
	}
	.outer-div-modi .card{
		border: 5px solid black; 
	}
	
	textarea{
		width: 100%;
	    height: 6.25em;
	    border: 1px solid black;
	    resize: none;
	}
	
</style>
</head>

<body>
<c:if test="${empty rv.list }">등록된 후기가 존재하지 않습니다.</c:if>

<c:forEach var="rv" items="${rv.list }" varStatus="idx">
	
	
	<div class="outer-div" id="outer-div${rv.review_no }">
	
		<div class="card mb-3" style="width: 700px; height: 210px; ">
				<div class="row g-0">
					<div class="col-md-4">
					<c:if test="${!empty rv.img.filename_real }">
						<img src="/hotel/upload/${rv.img.filename_real }" class="img-fluid${rv.img.image_no } rounded-start" alt="..." width="200px">
					</c:if>
					<c:if test="${empty rv.img.filename_real }">
						<img src="/hotel/image/mypage/noImage.png" class="img-fluid rounded-start" alt="..." width="200px">
					</c:if>
					
					</div>
				
					<div class="col-md-8">
						<div class="card-body">
							<h5 class="card-title" onclick="location.href='/hotel/main/roomView.do?hotel_no=${rv.hotel_no}&room_no=${rv.room_no }'" > 
								${rv.review_title }
							</h5>
							
							<div id="score">
								<img alt="평점 :" src="/hotel/image/mypage/star.png" width="30px"> ${rv.review_score }점
							</div>
							<div onclick="location.href='/hotel/main/hotelView.do?hotel_no=${rv.hotel_no}'">
								호텔  ${rv.hotel_name }
							</div>
							
							<div class="content-box" >
								<p class="card-text" >
									<div id="card-content">
										<pre>${rv.review_content }</pre>
									</div>
								</p>
							</div>
							
							<p class="card-text">
								<small class="text-muted">
									작성일 &nbsp;<fmt:formatDate value="${rv.review_regdate }" pattern="yyyy-MM-dd"/>
								</small>
							</p>
							
						</div>
					</div>
				</div>
							<div class="btn-box">
								<button class="btn" onclick="modi(${rv.review_no })" >수정</button>
								<button class="btn" onclick="del(${rv.review_no })">삭제</button>
							</div>
			</div>
		</div>
		
		
		
		
		
		<!-- 수정 BOX!! -->
		<form method="post" id="form${rv.review_no }" action="../review/update.do" enctype="multipart/form-data" >
		
			<div class="outer-div-modi" id="outer-div-modi${rv.review_no }">
				<input type="hidden" name="review_score" id="${rv.review_no }" value="${rv.review_score }">
				<input type="hidden" name="review_no" value="${rv.review_no }">
				<input type="hidden" name="hotel_no" value="${rv.hotel_no }">
				<input type="hidden" name="room_no" value="${rv.room_no }">
			
			<div class="card mb-3" style="width: 700px; height: 210px; ">
					<div class="row g-0">
						<div class="col-md-4">
						
						<!-- 이미지가 존재하는 경우 -->
						<c:if test="${!empty rv.img.filename_real }">
							<span id="imgSpan${rv.img.image_no}" style="position: relative;">
								<input onchange="imgDel(${rv.img.image_no})" type="checkbox" name="delImg" value="${rv.img.image_no}" style="position: absolute; right: 10px; top: 5px;" >
								<img src="/hotel/upload/${rv.img.filename_real }" class="img-fluid rounded-start" width="200px">
							</span>	
							<div id="imgAtc${rv.img.image_no}" style="display: none; position: relative;">
								<input id="file${rv.img.image_no}" type="file" name="filename" onchange="readURL(this, ${rv.img.image_no});"  hidden="true" > 
								<div>
									<img id="preview${rv.img.image_no}" class="preview" style="position: absolute; right: 0" width="200px"/>
								</div>
							
								<label for="file${rv.img.image_no}">
									<img src="/hotel/image/mypage/imgPlus.png" class="img-fluid rounded-start"  width="40px" style="margin: 150px 0 5px 5px; ">
								</label>
							
							</div>
						</c:if>
						
						<!-- 이미지가 존재하지 않는 경우 -->
						<c:if test="${empty rv.img.filename_real }">
						
							<div id="imgAtc${rv.review_no}" style=" position: relative;">
								<input id="file${rv.review_no}" type="file" name="filename" onchange="readURL(this, ${rv.review_no});" hidden="true" > 
								<div>
									<img id="preview${rv.review_no}" class="preview" style="position: absolute; right: 0" width="200px"/>
								</div>
							</div>
							
							<label for="file${rv.review_no}">
								<img src="/hotel/image/mypage/imgPlus.png" class="img-fluid rounded-start"  width="40px" style="margin: 135px 0 5px 5px; ">
							</label>
						</c:if>
						
						</div>
					
						<div class="col-md-8" >
							<div class="card-body">
								제목: <input class="card-title" name="review_title" value="${rv.review_title }">
								
								<div class="score">
									<img src="/hotel/image/mypage/emptyStar_icon.png" data-review_no="${rv.review_no }" width="25px">
									<img src="/hotel/image/mypage/emptyStar_icon.png" data-review_no="${rv.review_no }" width="25px">
									<img src="/hotel/image/mypage/emptyStar_icon.png" data-review_no="${rv.review_no }" width="25px">
									<img src="/hotel/image/mypage/emptyStar_icon.png" data-review_no="${rv.review_no }" width="25px">
									<img src="/hotel/image/mypage/emptyStar_icon.png" data-review_no="${rv.review_no }" width="25px">
								</div>
								
								<div>
									호텔:  ${rv.hotel_name }
								</div>
											
									<textarea name="review_content">${rv.review_content }</textarea>
											
								
								<p class="card-text">
									<small class="text-muted">
										작성일 &nbsp;<fmt:formatDate value="${rv.review_regdate }" pattern="yyyy-MM-dd"/>
									</small>
								</p>
					<div class="btn-box">
						<button class="btn" type="submit" >수정하기</button>
						<button type="button" class="btn btn-cancel"  >취소</button>
					</div>
								
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>
		<!-- End-수정!! -->

	</c:forEach>

</body>
</html>