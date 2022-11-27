<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>

alert('${msg}');

<c:if test="${!empty url}">
	location.href='${url}';
</c:if>

<c:if test="${empty url}">
	history.back();
</c:if>


</script>