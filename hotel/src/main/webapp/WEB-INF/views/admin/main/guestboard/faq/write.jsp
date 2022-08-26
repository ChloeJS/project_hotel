<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/admin/include/headHtml.jsp" %>
<%@ include file="/WEB-INF/views/admin/include/top.jsp" %>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=yes">
    <meta name="format-detection" content="telephone=no, address=no, email=no">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <title>FAQ</title>
    
    <!-- 아래부분 공통이니까 include -->
    <link rel="stylesheet" href="/hotel/css/reset.css"/>
    <link rel="stylesheet" href="/hotel/css/contents.css"/>
    
    <script src="/hotel/smarteditor/js/HuskyEZCreator.js"></script><!-- 22.08.03 추가 -->
    <script src="/hotel/js/function.js"></script><!-- 22.08.03 추가 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script><!-- 22.08.03 추가 -->
    
    <style>
    .title{
    		width : 80%;
    }
    </style>
    
    
    <script>
   	function goSave(){
		editor.getById['gfaq_content'].exec('UPDATE_CONTENTS_FIELD',[]); // getById -> jindo라는 프레임워크에서 사용하는 것	
		frm.submit();
	}
	var editor; // 변수를 밖에 쓴 이유: 전역변수로 사용하기 위해서
	$(function(){
		editor = setEditor('gfaq_content'); // textarea id= content
	});
	
    	
     function goBack(){
    		history.back();
    	};
    	
    	
    </script>
    
</head>
<body>
    <div id="container">
			<div id="content">
				<div class="con_tit">
					<h2>게스트 관리 ▶ FAQ ▶ 등록</h2>
				</div>
			</div>
	</div>
        <div class="sub">
            <div class="size">
                <div class="bbs">
                <form method="post" name="frm" id="frm" action="write.do"  enctype="multipart/form-data" > 
                    <table class="board_write">
						<tbody>
							<tr>
								<th>분류</th>
								<td class="choose"> <span class="srchSelect"> 
									<select id="stype" name="gfaq_type" class="dSelect" title="검색분류 선택">
											<option name="gfaq_type" value="1">예약</option>
											<option name="gfaq_type" value="2">결제</option>
											<option name="gfaq_type" value="3">숙소</option>
											<option name="gfaq_type" value="4">포인트/쿠폰</option>
											<option name="gfaq_type" value="5">이용/기타</option>
									</select>
								</td>
							</tr>
							<tr>
							<tr>
								<th>제목</th>
								<td><input type="text" name="gfaq_title" id="title" value="" style="width: 90%"/>
								</td>
							</tr>
							<tr>
								<th>내용</th>
								<td><textarea name="gfaq_content" id="gfaq_content" style="width: 90%"></textarea></td>
							</tr>

						</tbody>
					</table>
                    <div class="btnSet"  >
                        <a class="btn" style="align:left; background-color:grey; border:2px solid grey " href="javascript:goBack();" >이전 </a>
                        <a class="btn" style="align:right;" href="javascript:goSave();">저장 </a>
                    </div>
                
                    
                    </form>
                </div>
            </div>
        </div>
        
</body>
</html>