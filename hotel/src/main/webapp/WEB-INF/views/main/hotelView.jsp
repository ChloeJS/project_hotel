<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
  <head>
    <meta charset="utf-8" />
    <title>Hotel Detail</title>
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1"
    />
	<link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css"
    />
    <link href="/hotel/css/hotelView.css" rel="stylesheet" type="text/css">

  </head>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

  <%@ include file="/WEB-INF/views/includes/G_header.jsp"  %>
  <body>

	<div class ="detail_full_screen">
		<div id="hotel_screen" style="vertical-align: middle;">
	  		<div class="hotelName">${hotel.hotel_name}</div>
		  	<div class="swiper mySwiper" id="Low" style="display: inline-block; height: 350px">
		  		<div class="swiper-wrapper" >
				  	<c:forEach var="hotelImage" items="${hotelImage}">
				  		<div class="swiper-slide" id="imgBox"><img alt="사진없음" src="/hotel/image/hotel/${hotelImage.filename_org}"></div>
				  	</c:forEach>
		  		</div>
		  		<div class="swiper-button-next"></div>
			    <div class="swiper-button-prev"></div>
			    <div class="swiper-pagination"></div>
	  		</div>
		</div>
	  	<div class="middleBox" style="width: 80%; text-align: center;">
	  		<span>객실 안내/예약</span>
	  	</div>
  	</div>
  		
  		<!-- 객실리스트 1번 room -->
  		<div class="room_Screen">
  			<c:forEach var="roomList" items="${room}">
  			<div class="lowDiv">
		  		<div class="swiper mySwiper" id="Low" style="display: inline-block;">
	      			<div class="swiper-wrapper" >
	      				<c:forEach var="roomImage" items="${roomList.imageList}">
	        			<div class="swiper-slide" id="imgBox"><img alt="객실이미지" src="/hotel/image/hotel/${roomImage.filename_org }"></div>
	        			</c:forEach>
	      			</div>
			      	<div class="swiper-button-next"></div>
			      	<div class="swiper-button-prev"></div>
			      	<div class="swiper-pagination"></div>
	    		</div> 
		    	<div id="infoBox" style="display: inline-block;">
		    		<div id="infoContent"><span>객실명: </span><span style="font-weight: bold;">${roomList.room_name}</span></div>
		    		<div id="infoContent"><span>객실비용: </span><span style="font-weight: bold;">${roomList.room_price}</span></div>
		    		<div id="infoContent"><span>객실설명: </span><span style="font-weight: bold;">${roomList.room_content}</span></div>
		    		<div id="reservBtn"><input type="button" onclick="location.href='/hotel/main/roomView.do?room_no=${roomList.room_no}'" value="객실정보 확인 및 예약" style="margin-left: 330px;"></div>
				</div>
			</div>		
			</c:forEach> 
		</div>
	</div>


    <!-- Swiper JS -->
    <script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>

    <!-- Initialize Swiper -->
    <script>
      var swiper = new Swiper(".mySwiper", {
        cssMode: true,
        navigation: {
          nextEl: ".swiper-button-next",
          prevEl: ".swiper-button-prev",
        },
        pagination: {
          loop: true,
          el: ".swiper-pagination",
        },
        mousewheel: true,
        keyboard: true,
      });
    </script>

  </body>