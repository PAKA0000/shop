<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 리스트</title>
<style>
body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f8f9fa;
    margin: 0;
    padding: 20px;
    color: #333;
}

h1 {
    text-align: center;
    color: #03c75a;
    margin-bottom: 20px;
}

/* 메뉴 버튼 */
div.menu-buttons > a {
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

div.menu-buttons > a:hover {
    background-color: #03c75a;
    color: white;
    box-shadow: 0 4px 10px rgba(3,199,90,0.2);
}

/* 테이블 */
table {
    width: 90%;
    max-width: 1000px;
    margin: 30px auto;
    border-collapse: collapse;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 6px 15px rgba(0,0,0,0.05);
    background-color: white;
}

th, td {
    padding: 14px 12px;
    font-size: 15px;
    color: #333;
    text-align: center;
}

th {
    background-color: #03c75a;
    color: white;
    font-weight: 600;
}

td {
    border-bottom: 1px solid #eee;
}

/* 링크 스타일 */
td a {
    color: #03c75a;
    text-decoration: none;
    transition: all 0.3s ease;
}

td a:hover {
    text-decoration: underline;
    color: #02b150;
}

/* 삭제/수정 버튼 */
.btn-delete, .btn-edit {
    padding: 4px 8px;
    font-size: 13px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background 0.2s ease;
    margin: 0 2px;
}

.btn-delete {
    background: #f44336;
    color: #fff;
}

.btn-delete:hover {
    background: #d32f2f;
}

.btn-edit {
    background: #03c75a;
    color: #fff;
}

.btn-edit:hover {
    background: #02b150;
}

/* 페이징 */
.paging {
    text-align: center;
    margin-top: 25px;
}

.paging a, .paging span {
    display: inline-block;
    margin: 0 4px;
    padding: 6px 12px;
    font-size: 14px;
    border-radius: 12px;
    transition: all 0.3s ease;
    text-decoration: none;
    color: #03c75a;
    border: 1px solid #03c75a;
}

.paging a:hover {
    background-color: #03c75a;
    color: white;
}

.paging span.current {
    font-weight: 700;
    background-color: #02b150;
    color: white;
    border-color: #02b150;
}
</style>

<script>
function confirmDelete(noticeCode) {
    if(confirm("정말 이 공지를 삭제하시겠습니까?")) {
        window.location.href = "${pageContext.request.contextPath}/emp/removeNotice?noticeCode=" + noticeCode;
    }
}
</script>

</head>
<body>

<h1>공지사항 리스트</h1>

<!-- emp menu include -->
<c:import url="/WEB-INF/view/inc/empMenu.jsp"></c:import>
<hr>

<div class="menu-buttons">
    <a href="${pageContext.request.contextPath}/emp/addNotice">공지 추가</a>
</div>

<table>
    <thead>
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>등록일</th>
            <th>관리</th>
        </tr>
    </thead>
    <tbody>
    <c:forEach var="n" items="${list}">
        <tr>
            <td>${n.noticeCode}</td>
            <td><a href="${pageContext.request.contextPath}/emp/noticeDetail?noticeCode=${n.noticeCode}">${n.noticeTitle}</a></td>
            <td>${n.createdate}</td>
            <td>
                <a class="btn-edit" href="${pageContext.request.contextPath}/emp/modifyNotice?noticeCode=${n.noticeCode}">수정</a>
                <button class="btn-delete" onclick="confirmDelete(${n.noticeCode})">삭제</button>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<!-- 페이징 -->
<div class="paging">
    <a href="${pageContext.request.contextPath}/emp/noticeList?currentPage=1">처음</a>
    <c:if test="${startPage > 1}">
        <a href="${pageContext.request.contextPath}/emp/noticeList?currentPage=${startPage-10}">이전</a>
    </c:if>
    <c:forEach var="i" begin="${startPage}" end="${endPage}">
        <c:choose>
            <c:when test="${currentPage == i}">
                <span class="current">${i}</span>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/emp/noticeList?currentPage=${i}">${i}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    <c:if test="${lastPage != endPage}">
        <a href="${pageContext.request.contextPath}/emp/noticeList?currentPage=${startPage+10}">다음</a>
    </c:if>
    <a href="${pageContext.request.contextPath}/emp/noticeList?currentPage=${lastPage}">끝</a>
</div>

</body>
</html>
