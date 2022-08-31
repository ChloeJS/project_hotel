<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/views/admin/include/headHtml.jsp" %>
<%@ include file="/WEB-INF/views/admin/include/top.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=yes">
<meta name="format-detection"
	content="telephone=no, address=no, email=no">
<meta name="keywords" content="">
<meta name="description" content="">
<title>NOTICE</title>
<link rel="stylesheet" href="/hotel/css/reset.css" />
<link rel="stylesheet" href="/hotel/css/contents.css" />


</head>
<script>

function goWrite(){
	<c:if test="${!empty loginInfo_admin}">
		location.href= "write.do";
	</c:if>
	<c:if test="${empty loginInfo_admin}">
		alert("관리자 로그인 바랍니다.");
	</c:if>
}
</script>

<body>
    <div id="container">
			<div id="content">
				<div class="con_tit">
					<h2>게스트 관리 ▶ NOTICE ▶ 목록조회</h2>
				</div>
			</div>
	</div>
	<div class="sub">
		<div class="size">
			<div class="bbs">
				<table class="list">
					<p>
						<span><strong>총 ${data.totalCount}개</strong> | ${guestNoticeVO.page}/${data.totalPage}페이지 </span>
					</p>
					
					<caption>게시판 목록</caption>
					<colgroup>
						<col width="80px" />
						<col width="*" />
						<col width="100px" />
						<col width="150px" />
						<col width="80px" />
					</colgroup>
					<thead style="text-align: center">
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>조회수</th>
						</tr>
					</thead>
					
					<tbody>
						<c:if test="${empty data}">
							<tr>
								<td class="first" colspan="8">등록된 글이 없습니다.</td>
							</tr>
						</c:if>

						<c:if test="${not empty data.list}">
							<c:forEach items="${data.list }" var="vo" varStatus="status">
									<c:if test="${vo.fix == 1}">
									<tr style="background-color: #F7C1C2" >
									</c:if>
									<c:if test="${vo.fix != 1}">
									<tr>
									</c:if>
										<td>${data.totalCount - status.index - ((guestNoticeVO.page - 1) * guestNoticeVO.pageRow)}<!-- 계산식 = "총개수 - 인덱스 - (현재 페이지 번호 - 1) * 페이지당 개수" --></td>
										<td class="txt_l" >
										<a	href="/hotel/admin/main/guestboard/notice/view.do?gnotice_no=${vo.gnotice_no}&stype=${param.stype}&sword=${param.sword}">
										<b> <c:if test="${vo.gnotice_type == 1 }">
											[안내] ${vo.gnotice_title}   
										</c:if> <c:if test="${vo.gnotice_type == 2 }">
											[공지] ${vo.gnotice_title} 
										</c:if> <c:if test="${vo.gnotice_type == 3 }">
											[이벤트] ${vo.gnotice_title} 
										</c:if> <c:if test="${vo.gnotice_type == 4 }">
											[발표] ${vo.gnotice_title} 
										</c:if>
											<c:if test="${vo.diff <= 3 }">
											<img src="/hotel/image/boardPic/new (1).png" width="30px">
										</c:if>
										</a></td>
									
										</td>
										<td class="writer">관리자</td>
										<td class="date"><fmt:formatDate
												value="${vo.gnotice_regdate}" pattern="yyyy-MM-dd" /></td>
										<td>${vo.gnotice_viewcount}</td>
									</tr>
								
							</c:forEach>
					</c:if>
					</tbody>
				</table>
				<div class="btnSet" style="text-align: right;">
				</div>
				
				<!-- 페이지처리 -->
				<div class="pagenate clear">
					<ul class='paging'>
						<!-- 이전페이지 -->
						<c:if test="${data.prev == true }">
							<li><a
								href="list.do?page=${data.startPage - 1 }&stype=${param.stype}&sword=${param.sword}"><</a></li>
						</c:if>
						<!-- 페이지별 -->
						<c:forEach var="p" begin="${data.startPage}"
							end="${data.endPage }">
							<li><a href='list.do?page=${p }&stype=${param.stype}&sword=${param.sword}'
								<c:if test="${guestBoardVO.page == p }"> class='current'</c:if>>${p }</a></li>
						</c:forEach>
						<!-- 다음페이지 -->
						<c:if test="${data.next == true }">
							<li><a
								href="list.do?page=${data.endPage + 1 }&stype=${param.stype}&sword=${param.sword}"></a></li>
						</c:if>
					</ul>
				</div>

				<div class="btnSet" style="text-align: right;">
						<a class="btn" href="javascript:goWrite();">등록 </a>
				</div>
				
				<!-- 검색처리 -->
				<div class="bbsSearch">
					<form method="get" name="searchForm" id="searchForm" action="">
						<span class="srchSelect"> <select id="stype" name="stype"
							class="dSelect" title="검색분류 선택">
								<option value="all">전체</option>
								<option value="gboard_title">제목</option>
								<option value="gboard_content">내용</option>
						</select>
						</span> <span class="searchWord"> <input type="text" id="sword"
							name="sword" value="${param.sword }" title="검색어 입력"> <input
							type="button" id="" value="검색" title="검색">
						</span>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>


