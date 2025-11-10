<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>고객 목록</title>
<style>
/* 기본 폰트와 배경 */
body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f5f6f7;
    margin: 0;
    padding: 0;
}

/* 컨테이너 */
.container {
    width: 90%;
    max-width: 1000px;
    margin: 50px auto;
    background-color: #fff;
    padding: 30px;
    border-radius: 12px;
    box-shadow: 0 3px 10px rgba(0,0,0,0.1);
}

/* 제목 */
h2 {
    color: #03c75a; /* 네이버 녹색 */
    font-weight: 700;
    text-align: center;
    margin-bottom: 30px;
}

/* 테이블 스타일 */
.table {
    width: 100%;
    border-collapse: collapse;
    border-radius: 10px;
    overflow: hidden;
    text-align: center;
}

.table th, .table td {
    padding: 12px 15px;
    border-bottom: 1px solid #e1e4e8;
    font-size: 14px;
    color: #333;
}

.table th {
    background-color: #f0f2f5;
    font-weight: 600;
    color: #555;
}

.table tr:hover {
    background-color: #f9fef9;
    transition: background 0.2s ease-in-out;
}

/* 등록된 고객이 없을 때 */
.table td[colspan] {
    color: #888;
    font-style: italic;
    padding: 20px 0;
}

/* 페이지네이션 */
.pagination {
    display: flex;
    justify-content: center;
    gap: 6px;
    margin-top: 25px;
    flex-wrap: wrap;
}

.page-btn {
    display: inline-block;
    padding: 6px 14px;
    font-size: 14px;
    color: #555;
    text-decoration: none;
    border: 1px solid #cdd0d4;
    border-radius: 5px;
    transition: all 0.2s;
    background-color: #fff;
}

.page-btn:hover {
    background-color: #e8f5e9;
    color: #03c75a;
    border-color: #03c75a;
}

.page-btn.active {
    background-color: #03c75a;
    color: #fff;
    border-color: #03c75a;
    font-weight: 600;
}
</style>
</head>
<body>
<div class="container">
    <h2>고객 목록</h2>
    <table class="table">
        <thead>
            <tr>
                <th>고객코드</th>
                <th>아이디</th>
                <th>이름</th>
                <th>전화번호</th>
                <th>포인트</th>
                <th>등록일</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="c" items="${customerList}">
                <tr>
                    <td>${c.customerCode}</td>
                    <td>${c.customerId}</td>
                    <td>${c.customerName}</td>
                    <td>${c.customerPhone}</td>
                    <td>${c.point}</td>
                    <td>${c.createdate}</td>
                </tr>
            </c:forEach>
            <c:if test="${empty customerList}">
                <tr><td colspan="6">등록된 고객이 없습니다.</td></tr>
            </c:if>
        </tbody>
    </table>

    <div class="pagination">
        <c:if test="${currentPage > 1}">
            <a class="page-btn" href="?currentPage=${currentPage-1}">&laquo;</a>
        </c:if>
        <c:forEach var="i" begin="${startPage}" end="${endPage}">
            <a class="page-btn ${i==currentPage?'active':''}" href="?currentPage=${i}">${i}</a>
        </c:forEach>
        <c:if test="${currentPage < lastPage}">
            <a class="page-btn" href="?currentPage=${currentPage+1}">&raquo;</a>
        </c:if>
    </div>
</div>
</body>
</html>
