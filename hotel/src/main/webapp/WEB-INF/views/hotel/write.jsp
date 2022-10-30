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
    
    <script type="text/javascript">
    function goSave(){
    	
    	if($("#hotel_name").val().trim()==''){
    		alert('호텔이름을 입력해주세요');
    		$("#hotel_name").focus();
    		return;
    	}
    	if($("#tel").val().trim()==''){
    		alert("전화번호를 입력해주세요");
    		$("#tel").focus();
    		return;
    	}
    	if($("#addr1").val().trim()==''){
    		alert("우편번호, 주소를 입력해주세요");
    		$("#addr1").focus();
    		return;
    	}
    	if($("#selectbox_state").val().trim()=='1'){
    		alert("지역코드('시/도')를 입력해주세요");
    		$("#selectbox_state").focus();
    		return;
    	}
    	if($("#selectbox_district").val().trim()=='2'){
    		alert("지역코드('시/군/구')를 입력해주세요");
    		$("#selectbox_district").focus();
    		return;
    	}
    	frm.submit();
    }

  
    </script>
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
								str += "<option value = "+ result[i].district_code + " label="+result[i].district_name+"></option>"
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
		
		<script >
		$(function(){
			var placeholder = 	 "EX) \n "
								+"*공지사항 \n "
								+"1. 폭우로 인한 침수로 지하주차장 운영을 중단합니다.\n"
								+"2. 호텔 내에서는 마스크를 자율 착용입니다."
			$('#hotel_content').attr('placeholder', placeholder);
			
		})
		</script>
		
		
		
		
		
	<style type="text/css">
	

	</style>
</head>
<body>
    
        <div class="sub">
            <div class="size">
                <h3 class="sub_title">호텔 등록 신청</h3>
    			
    			<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*는 필수입력사항 입니다.</p>
    			
                <div class="bbs">
                	<form method="post" name="frm" id="frm" action="insert.do" enctype="multipart/form-data" > <!-- enctype="multipart/form-data" -->
	                   <%--  <input type="hidden" name = "memberno" value="${loginInfo.no }"/> --%>
	                    <table class="board_write">
	                        <tbody>
	                        <tr>
	                            <th>*호텔명</th>
	                            <td>
	                                <input type="text" name="hotel_name" id="hotel_name" class="wid100" value="" />
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
	                                <input type="number" name="tel" id="tel" class="wid100" value=""/>
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
		                            	<input type="text" name="addr" id="addr1" style="width:80%" readonly>
		                            </td>
	                            </tr>
	                            
	                        </tr>
	                        <tr>
	                            <th>*지역코드 입력</th>
	                            <td>
	                            	<select name='state_code' id="selectbox_state" onchange="optionChange()">
										<option value='1' label='시 / 도' selected></option>
										<option value='11' label='서울특별시'></option>
										<option value='21' label='부산광역시'></option>
										<option value='22' label='대구광역시'></option>
										<option value='23' label='인천광역시'></option>
										<option value='24' label='광주광역시'></option>
										<option value='25' label='대전광역시'></option>
										<option value='26' label='울산광역시'></option>
										<option value='29' label='세종특별자치시'></option>
										<option value='31' label='경기도'></option>
										<option value='32' label='강원도'></option>
										<option value='33' label='충청북도'></option>
										<option value='34' label='충청남도'></option>
										<option value='35' label='전라북도'></option>
										<option value='36' label='전라남도'></option>
										<option value='37' label='경상북도'></option>
										<option value='38' label='경상남도'></option>
										<option value='39' label='제주특별자치도'></option>
									</select>
									
									<select name='district_code' id="selectbox_district">
										<option value='2' label='시/군/구' selected></option>
									</select>
		                                  
	                            </td>
	                        </tr>
	                        <tr>
	                            <th>호텔 공지 사항</th>
	                            <td>
	                                <textarea name="hotel_content" id="hotel_content" placeholder=""></textarea>
	                            </td>
	                        </tr>
	                        <tr>
	                        	<th>호텔 사진</th>
	                        	<td>
	                        		<input type="file" name="filename2" multiple>
	                        	</td>
	                        </tr>
	                        </tbody>
	                    </table>
	                    
	                    <div class="btnSet"  style="text-align:right;">
	                        <a class="btn" href="javascript:goSave();">저장 </a>
	                    </div>
                    </form>
                </div>
            </div>
        </div>
        
</body>
</html>