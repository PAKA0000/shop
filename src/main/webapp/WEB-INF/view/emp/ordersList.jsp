<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <!-- ✅ 추가 -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 목록 | 관리자 페이지</title>

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

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
        max-width: 1100px;
        background: #fff;
        margin: 30px auto;
        padding: 30px 40px;
        border-radius: 16px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.08);
    }

    .menu {
        text-align: right;
        margin-bottom: 20px;
    }

    .btn-add {
        background-color: #03c75a;
        color: white;
        font-weight: 600;
        text-decoration: none;
        padding: 10px 18px;
        border-radius: 25px;
        transition: all 0.3s ease;
    }

    .btn-add:hover {
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
        font-size: 14.5px;
        color: #333;
    }

    th {
        background-color: #f0f0f0;
        font-weight: 600;
    }

    tr:hover {
        background-color: #f9f9f9;
    }

    .state-btn {
        background-color: #03c75a;
        color: white;
        padding: 6px 12px;
        border-radius: 18px;
        text-decoration: none;
        font-size: 13px;
        font-weight: 500;
        transition: all 0.2s ease;
    }

    .state-btn:hover {
        background-color: #02b150;
    }

    .no-data {
        text-align: center;
        color: #777;
        padding: 20px;
    }
</style>
</head>

<body>
    <!-- 상단 메뉴 -->
    <c:import url="/WEB-INF/view/inc/empMenu.jsp"></c:import>

    <h1>주문 목록</h1>
    <hr>

    <div class="container">
        <div class="menu">
            <a href="${pageContext.request.contextPath}/emp/goodsList" class="btn-add">상품 관리</a>
        </div>

        <table>
            <thead>
                <tr>
                    <th>주문코드</th>
                    <th>상품명</th>
                    <th>상품가격</th>
                    <th>수량</th>
                    <th>총 주문금액</th>
                    <th>고객명</th>
                    <th>연락처</th>
                    <th>주소</th>
                    <th>주문일자</th>
                    <th>주문상태</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty list}">
                        <tr>
                            <td colspan="10" class="no-data">등록된 주문이 없습니다.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="m" items="${list}">
                            <tr>
                                <td>${m["orderCode"]}</td>
                                <td>${m["goodsName"]}</td>
                                <td>
                                    <fmt:formatNumber value="${m['goodsPrice']}" type="number" /> 원
                                </td>
                                <td>${m["orderQuantity"]}</td>
                                <td>
                                    <fmt:formatNumber value="${m['orderPrice']}" type="number" /> 원
                                </td>
                                <td>${m["customerName"]}</td>
                                <td>${m["customerPhone"]}</td>
                                <td>${m["address"]}</td>
                                <td>${m["createdate"]}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/emp/orderDetail?orderCode=${m['orderCode']}" class="state-btn">
                                        ${m["orderState"]}
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</body>
</html>
