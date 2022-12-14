<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalabel=yes">
    <meta name="format-detection" content="telephone=no, address=no, email=no">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <title>게시판 등록</title>
    <link rel="stylesheet" href="/hotel/css/reset.css"/>
    <link rel="stylesheet" href="/hotel/css/contents.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    
    <script type="text/javascript">
    function del(room_no){
    	if(confirm('삭제하시겠습니까?')){
    		location.href='delete.do?room_no='+room_no
    	}
    }
  
    </script>

	<style type="text/css">
	

	</style>
</head>
<body>
    
        <div class="sub">
            <div class="size">
            
            	
                <h3 class="sub_title"> 객실 정보 </h3>
    
                <div class="bbs">
                	<form method="post" name="frm" id="frm" action="insert.do" enctype="multipart/form-data" > <!-- enctype="multipart/form-data" -->
	                   <input type="hidden" name = "room_no" value="${data.room_no }"/>
	                    <table class="board_write">
	                        <tbody>
	                        <tr>
	                            <th>객실명</th>
	                            <td>
	                               ${data.room_name}
	                            </td>
	                        </tr>
	                        <tr>
	                            <th>객실 번호</th>
	                            <td>
	                                 ${data.number}
	                            </td>
	                        </tr>
	                        <tr>
	                            <th>객실 가격</th>
	                            <td>
	                                 ${data.room_price}
	                            </td>
	                        </tr>
	                        <tr>
	                            <th>수용인원(demo)</th>
	                            <td>
	                                 2 명
								</td>
	                        </tr>
	                        <tr>
	                            <th>편의시설 & 서비스(demo)</th>
	                            <td>
		                             <input type="checkbox" name="comfors" id="comfors1" value="gym" > <label for="comfors1">GYM</label> |&nbsp; 
		                             <label><input type="checkbox" name="comfors" value="parking" > 주차장 |&nbsp; </label>
		                             <label><input type="checkbox" name="comfors" value="cvs" > 편의점 |&nbsp;  </label>
		                             <label><input type="checkbox" name="comfors" value="wifi" > WIFI |&nbsp; </label>
		                             <label><input type="checkbox" name="comfors" value="roomservice" > 룸서비스&nbsp; </label>          
	                            </td>
	                        </tr>
	                        <tr>
	                            <th>객실 상세</th>
	                            <td>
	                                 ${data.room_content}
	                            </td>
	                        </tr>
	                        <tr>
	                        	<th> 객실 사진</th>
	                        	<td>
	                        		<c:forEach items="${imgList }" var="img" varStatus="loop">
	                        			
	                        			<img src="/hotel/upload/${img.filename_real }" style="width:100px; height:100px; padding: 5px 5px 5px 5px; boarder='1';">
	                        			
	                        		</c:forEach>
	                        	
	                        	</td>
			                     
	                        </tr>
	                        </tbody>
	                    </table>
	                    
	                    <div class="btnSet"  style="text-align:right;">
                       		<a href="index.do" class="btn">목록으로</a>
                      		<a href="edit.do?room_no=${data.room_no }" class="btn">수정</a>
                         	<a class="btn" onclick="del(${data.room_no})" >삭제</a>
	                    </div>
                    </form>
                </div>
            </div>
        </div>
        
</body>
</html>