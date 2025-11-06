<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
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

    /* 상단 메뉴 */
    .menu {
        text-align: center;
        margin-bottom: 20px;
    }

    .menu a {
        color: #03c75a;
        text-decoration: none;
        font-weight: 500;
        margin: 0 10px;
    }

    .menu a:hover {
        text-decoration: underline;
    }

    /* 메인 컨테이너 */
    .container {
        max-width: 900px;
        background: #fff;
        margin: 30px auto;
        padding: 30px 40px;
        border-radius: 16px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.08);
    }

    /* 상품 추가 버튼 */
    .btn-add {
        display: inline-block;
        background-color: #03c75a;
        color: white;
        font-weight: 600;
        text-decoration: none;
        padding: 10px 18px;
        border-radius: 25px;
        transition: all 0.3s ease;
        margin-bottom: 20px;
    }

    .btn-add:hover {
        background-color: #02b150;
        box-shadow: 0 4px 10px rgba(3, 199, 90, 0.3);
        transform: translateY(-2px);
    }

    /* 상품 목록 테이블 */
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
</div>

