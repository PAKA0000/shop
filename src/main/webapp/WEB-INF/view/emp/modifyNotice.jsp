<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 목록</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
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

    .notice-container {
        max-width: 900px;
        margin: 40px auto;
        background: #fff;
        border-radius: 16px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        padding: 30px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    th {
        background-color: #03c75a;
        color: white;
        padding: 12px;
        text-align: center;
        font-weight: 600;
        border-top-left-radius: 8px;
        border-top-right-radius: 8px;
    }

    td {
        padding: 12px;
        border-bottom: 1px solid #ddd;
        text-align: center;
    }

    tr:hover {
        background-color: #f1f1f1;
    }

    a {
        text-decoration: none;
        color: #03c75a;
        font-weight: 500;
    }

    a:hover {
        text-decoration: underline;
    }

    .menu {
        text-align: center;
        margin-bottom: 20px;
    }

    .menu a {
        background-color: #03c75a;
        color: #fff;
        padding: 8px 16px;
        border-radius: 20px;
        margin: 0 5px;
        font-size: 14px;
        transition: all 0.3s ease;
    }

    .menu a:hover {
        background-color: #02b150;
    }

    .pagination {
        text-align: center;
        margin-top: 25px;
    }

    .pagination a {
        color: #03c75a;
        font-weight: 500;
        margin: 0 5px;
    }

    .pagination span {
        font-weight: 700;
        color: #333;
    }
</style>
</head>

<body>
    <h1>공지사항 목록</h1>
    <hr>

    <div class="notice-container">
        <div class="menu">
            <a href="${pageContext.request.contextPath}/emp/addNotice">공지 추가</a>
        </div>

        <table>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성일</th>
                <th>관리</th>
            </tr>

           <c:forEach var="n" items="${list}">
    <tr>
        <td>${n.noticeCode}</td>
        <td>
            <a href="${pageContext.request.contextPath}/emp/noticeOne?noticeCode=${n.noticeCode}">
                ${n.noticeTitle}
            </a>
        </td>
        <td>${n.createdate}</td>
        <td>
            <a href="${pageContext.request.contextPath}/emp/modifyNotice?noticeCode=${n.noticeCode}">수정</a> |
            <a href="${pageContext.request.contextPath}/emp/deleteNotice?noticeCode=${n.noticeCode}"
               onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
        </td>
    </tr>
</c:forEach>

        </table>

        <!-- 페이지 네비게이션 -->
        <div class="pagination">
            <a href="${pageContext.request.conte
