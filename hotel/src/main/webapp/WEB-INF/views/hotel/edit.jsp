<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=yes">
    <meta name="format-detection" content="telephone=no, address=no, email=no">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <title>호텔 등록 신청</title>
    <link rel="stylesheet" href="/hotel/css/reset.css"/>
    <link rel="stylesheet" href="/hotel/css/contents.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="/hotel/js/hostHotelEdit.js"></script>
   
    <!-- 우편번호 API -->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	    function zipcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수
	
	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }
	
	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    //document.getElementById("sample6_extraAddress").value = extraAddr;
	                	addr += extraAddr;
	                } 
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('zipcode').value = data.zonecode;
	                document.getElementById("addr1").value = addr;
	                
	            }
	        }).open();
	    }
	</script>

	<script>
	
		$(function(){
			optionChange();
		})
		
			function optionChange() {
				$.ajax({
					url : "district.do",
					type : "POST",
					data : {
							state_code : $("#selectbox_state").val()
						},
					success : function(result) {
						var str = "<option value =2 selected>시/군/구</option>";
						
						if($("#selectbox_state").val() != "1"){
							$.each(result, function(i){
								str += "<option value = '"+ result[i].district_code+"' ";
								if (result[i].district_code == ${data.district_code}) {
									str += " selected ";
								}
								str += ">"+result[i].district_name+"</option>"
			                });
						} else {
								str = "<option value =2 selected>시/군/구</option>";
							}
							$("#selectbox_district").empty($("#selectbox_district").val());
		                    $("#selectbox_district").append(str);
						}
				})
			}
		
	</script>
	
	
</head>
<body>
    
        <div class="sub">
            <div class="size">
                <h3 class="sub_title">호텔 등록 신청</h3>
    			
    			<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*는 필수입력사항 입니다.</p>
    			
                <div class="bbs">
                	<form method="post" name="frm" id="frm" action="../myhotel/update.do" enctype="multipart/form-data" > <!-- enctype="multipart/form-data" -->
	                   <%--  <input type="hidden" name = "memberno" value="${loginInfo.no }"/> --%>
	                   <input type="hidden" name = "hotel_no" value="${data.hotel_no }"/>
	                    <table class="board_write">
	                        <tbody>
	                        <tr>
	                            <th>*호텔명</th>
	                            <td>
	                                <input type="text" name="hotel_name" id="hotel_name" class="wid100" value="${data.hotel_name }" />
	                            </td>
	                        </tr>
	                        <tr>
	                            <th></th>
	                            <td>
	                                
	                            </td>
	                        </tr>
	                        <tr>
	                            <th>*호텔 전화번호</th>
	                            <td>
	                                <input type="number" name="tel" id="tel" class="wid100" value="${data.tel }"/>
	                            </td>
	                        </tr>
		                        <tr>
		                           <tr>
		                            <th rowspan="2">*주소</th>
		                            <td>
		                                <input type="text" name="zipcode" id="zipcode" class="inNextBtn" style="float:left;" readonly>
		                                <span class="email_check"><a href="javascript:zipcode();"  class="btn bgGray" style="float:left; width:auto; clear:none;">우편번호</a></span>
		                            </td>
		                        </tr>
	                            <tr>
		                            <td>
		                            	<input type="text" name="addr" id="addr1" value="${data.addr }" style="width:80%" readonly>
		                            </td>
	                            </tr>
	                            
	                        </tr>
	                        <tr>
	                            <th>*지역코드 입력</th>
	                            <td> <c:if test="">selected</c:if>
	                            	<select name='state_code' id="selectbox_state" onchange="optionChange()">
										<option value='1'  label='시 / 도' selected></option>
										<option value='11' <c:if test="${data.state_code ==11 }">selected</c:if> label='서울특별시'></option>
										<option value='12' <c:if test="${data.state_code ==21 }">selected</c:if> label='부산광역시'></option>
										<option value='13' <c:if test="${data.state_code ==22 }">selected</c:if> label='대구광역시'></option>
										<option value='14' <c:if test="${data.state_code ==23 }">selected</c:if> label='인천광역시'></option>
										<option value='15' <c:if test="${data.state_code ==24 }">selected</c:if> label='광주광역시'></option>
										<option value='16' <c:if test="${data.state_code ==25 }">selected</c:if> label='대전광역시'></option>
										<option value='17' <c:if test="${data.state_code ==26 }">selected</c:if> label='울산광역시'></option>
										<option value='18' <c:if test="${data.state_code ==29 }">selected</c:if> label='세종특별자치시'></option>
										<option value='19' <c:if test="${data.state_code ==31 }">selected</c:if> label='경기도'></option>
										<option value='20' <c:if test="${data.state_code ==32 }">selected</c:if> label='강원도'></option>
										<option value='21' <c:if test="${data.state_code ==33 }">selected</c:if> label='충청북도'></option>
										<option value='22' <c:if test="${data.state_code ==34 }">selected</c:if> label='충청남도'></option>
										<option value='23' <c:if test="${data.state_code ==35 }">selected</c:if> label='전라북도'></option>
										<option value='24' <c:if test="${data.state_code ==36 }">selected</c:if> label='전라남도'></option>
										<option value='25' <c:if test="${data.state_code ==37 }">selected</c:if>  label='경상북도'></option>
										<option value='26' <c:if test="${data.state_code ==38 }">selected</c:if> label='경상남도'></option>
										<option value='27' <c:if test="${data.state_code ==39 }">selected</c:if> label='제주특별자치도'></option>
									</select>
									
									<select name='district_code' id="selectbox_district">
										<option value='2' label='시/군/구' selected></option>
									</select>
		                                  
	                            </td>
	                        </tr>
	                        <tr>
	                            <th>호텔 공지 사항</th>
	                            <td>
	                                <textarea name="hotel_content" id="hotel_content" >${data.hotel_content }</textarea>
	                            </td>
	                        </tr>
	                        <tr>
	                        	<th>호텔 사진</th>
	                        	<td>
	                        		<c:forEach items="${imgList }" var="img" varStatus="idx">
	                        				<span id="imgSpan${img.image_no}" style="position: relative;">
		                        				<input onchange="imgDel(${img.image_no})" type="checkbox" name="delImg" value="${img.image_no}" style="position: absolute; right: 10px; top: 5px;" > 
			                        			<img src="/hotel/upload/${img.filename_real }" data-no="${img.no }" id="drag'${idx.count }"  width="128" height="128">
		                        			</span>
	                        		</c:forEach>
	                        	</td>
	                        </tr>
	                         <tr id="imgFrame">
	                        	<th> 첨부 파일<button id="addImg" type="button">&nbsp;&nbsp;&nbsp; <img src="/hotel/image/mypage/imgPlus.png" width="30px"> </button>  </th>
	                        	<td>
	                        		<input type="file" name="filename2" onchange="readURL(this);"  > 
									<img id="preview"/>
	                        	</td>
	                        </tr>
	                        </tbody>
	                    </table>
	                    
	                    <div class="btnSet"  style="text-align:right;">
	                        <input type="submit" class="btn" value="수정하기">
	                    </div>
                    </form>
                </div>
            </div>
        </div>
        
</body>
</html>