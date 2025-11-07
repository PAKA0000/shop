<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
/* 테이블 스타일 */
table {
    width: 90%;
    max-width: 1000px;
    margin: 30px auto;
    border-collapse: collapse;
    background: white;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 4px 15px rgba(0,0,0,0.08);
}

th, td {
    padding: 14px 12px;
    text-align: left;
    font-size: 15px;
    color: #333;
}

th {
    background-color: #03c75a;
    color: white;
    font-weight: 600;
    text-align: center;
}

td {
    border-bottom: 1px solid #eee;
}

td a {
    color: #03c75a;
    text-decoration: none;
    transition: all 0.3s ease;
}

td a:hover {
    text-decoration: underline;
    color: #02b150;
}

/* 상단 메뉴 버튼 */
div > a {
    display: inline-block;
    margin: 5px 8px;
    padding: 8px 15px;
    background-color: #e6f9f0;
    color: #03c75a;
    border-radius: 20px;
    font-weight: 500;
    text-decoration: none;
    transition: all 0.3s ease;
}

div > a:hover {
    background-color: #03c75a;
    color: white;
    box-shadow: 0 4px 10px rgba(3,199,90,0.2);
}

/* 페이징 스타일 */
span, .paging a {
    margin: 0 4px;
    font-size: 14px;
}

.paging a {
    text-decoration: none;
    color: #03c75a;
    padding: 5px 10px;
    border-radius: 12px;
    transition: all 0.3s ease;
}

.paging a:hover {
    background-color: #03c75a;
    color: white;
}

span.current {
    font-weight: 700;
    color: #02b150;
    padding: 5px 10px;
}
</style>

</head>

<body>
	<h1>noticeList</h1>
	<!-- emp meun include -->
	<c:import url="/WEB-INF/view/inc/empMenu.jsp"></c:import>
	<hr>
	
	<div>
		<a href="${pageContext.request.contextPath}/emp/addNotice">[공지추가]</a>
		<a href="${pageContext.request.contextPath}/emp/deleteNotice">[공지삭제]</a>
		<a href="${pageContext.request.contextPath}/emp/modifyNotice">[공지변경]</a>
	</div>
	
	<table border="1">
		<tr>
			<th>noticeCode</th>
			<th>noticeTitle</th>
			<th>createdate</th>
		</tr>
		<c:forEach var="n" items="${list}">
			<tr>
				<td>${n.noticeCode}</td>
				<td><a href="">${n.noticeTitle}</a></td>
				<td>${n.createdate}</td>
			</tr>
		</c:forEach>
	</table>
	
	<!-- [처음으로][이전] 1 2 3 4 5 6 7 8 9 10 [다음][끝으로]-->
	<a href="${pageContext.request.contextPath}/emp/noticeList?currentPage=1">[처음으로]</a>
	<c:if test="${startPage > 1}">
		<a href="${pageContext.request.contextPath}/emp/noticeList?currentPage=${startPage-10}">[이전]</a>
	</c:if>
	<span>
		<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
			<c:if test="${currentPage == i}">
				[${i}]
			</c:if>
			<c:if test="${currentPage != i}">
				<a href="${pageContext.request.contextPath}/emp/noticeList?currentPage=${i}">[${i}]</a>
			</c:if>
		</c:forEach>
	</span>
	
	<c:if test="${lastPage != endPage}">
		<a href="${pageContext.request.contextPath}/emp/noticeList?currentPage=${startPage+10}">[다음]</a>
	</c:if>
	<a href="${pageContext.request.contextPath}/emp/noticeList?currentPage=${lastPage}">[끝으로]</a>
</body>
</html>