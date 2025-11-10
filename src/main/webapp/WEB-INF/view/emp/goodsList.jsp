<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>상품 목록 | 관리자 페이지</title>

<style>
body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f8f9fa;
    margin: 0;
    padding: 0;
}

h1 {
    color: #03c75a;
    text-align: center;
    margin-top: 40px;
    font-weight: 700;
}

hr {
    border: none;
    border-top: 2px solid #03c75a;
    width: 80%;
    margin: 20px auto;
}

.container {
    max-width: 900px;
    background: #fff;
    margin: 30px auto;
    padding: 30px 40px;
    border-radius: 16px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.08);
}

.menu {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

.menu a.btn-add {
    background-color: #03c75a;
    color: white;
    font-weight: 600;
    text-decoration: none;
    padding: 10px 18px;
    border-radius: 25px;
    transition: all 0.3s ease;
}

.menu a.btn-add:hover {
    background-color: #02b150;
    box-shadow: 0 4px 10px rgba(3, 199, 90, 0.3);
    transform: translateY(-2px);
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 10px;
}

th, td {
    padding: 12px 10px;
    border-bottom: 1px solid #e0e0e0;
    text-align: center;
    font-size: 15px;
    color: #333;
}

th {
    background-color: #f0f0f0;
    font-weight: 600;
}

tr:hover {
    background-color: #f9f9f9;
}

.no-data {
    text-align: center;
    color: #777;
    padding: 20px;
}

/* 페이징 */
.pagination {
    display: flex;
    justify-content: center;
    gap: 5px;
    margin-top: 25px;
}

.page-btn {
    padding: 6px 12px;
    border: 1px solid #03c75a;
    border-radius: 5px;
    background: white;
    color: #03c75a;
    text-decoration: none;
    font-size: 13px;
    transition: all 0.2s;
}

.page-btn.active {
    background-color: #03c75a;
    color: white;
}

.page-btn:hover {
    background-color: #02b150;
    color: white;
}
</style>
</head>

<body>
<h1>상품 목록</h1>
<c:import url="/WEB-INF/view/inc/empMenu.jsp"></c:import>
<hr>

<div class="container">
    <div class="menu">
        <a href="${pageContext.request.contextPath}/emp/empIndex">홈</a>
        <a href="${pageContext.request.contextPath}/emp/addGoods" class="btn-add">＋ 상품 추가</a>
    </div>

    <table>
        <thead>
            <tr>
                <th>상품코드</th>
                <th>상품명</th>
                <th>가격</th>
                <th>포인트율</th>
                <th>등록일</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty list}">
                    <tr><td colspan="5" class="no-data">등록된 상품이 없습니다.</td></tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="g" items="${list}">
                        <tr>
                            <td>${g.goodsCode}</td>
                            <td>${g.goodsName}</td>
                            <td><fmt:formatNumber value="${g.goodsPrice}" type="number"/> 원</td>
                            <td>${g.pointRate * 100}%</td>
                            <td>${g.createdate}</td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

    <!-- 페이징 -->
    <div class="pagination">
        <a class="page-btn" href="?currentPage=1">처음</a>
        <c:if test="${startPage > 1}">
            <a class="page-btn" href="?currentPage=${startPage-10}">이전</a>
        </c:if>

        <c:forEach var="i" begin="${startPage}" end="${endPage}">
            <c:choose>
                <c:when test="${currentPage == i}">
                    <span class="page-btn active">${i}</span>
                </c:when>
                <c:otherwise>
                    <a class="page-btn" href="?currentPage=${i}">${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:if test="${lastPage != endPage}">
            <a class="page-btn" href="?currentPage=${startPage+10}">다음</a>
        </c:if>
        <a class="page-btn" href="?currentPage=${lastPage}">끝</a>
    </div>
</div>

</body>
</html>
