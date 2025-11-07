<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>empIndex</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<style>
    /* 전체 배경과 글꼴 */
    body {
        font-family: 'Malgun Gothic', 'Segoe UI', sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f5f5f5;
    }

    /* 상단 네비게이션 바 */
    header {
        background-color: #03c75a; /* 네이버 녹색 계열 */
        color: white;
        padding: 15px 20px;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    header h1 {
        margin: 0;
        font-size: 24px;
    }

    nav a {
        color: white;
        text-decoration: none;
        margin-left: 20px;
        font-weight: bold;
    }

    nav a:hover {
        text-decoration: underline;
    }

    /* 환영 메시지 영역 */
    .welcome {
        margin: 20px;
        font-size: 18px;
    }

    .welcome a {
        color: #03c75a;
        text-decoration: none;
        font-weight: bold;
        margin-left: 10px;
        padding: 5px 10px;
        border: 1px solid #03c75a;
        border-radius: 4px;
        background-color: white;
        transition: 0.3s;
    }

    .welcome a:hover {
        background-color: #03c75a;
        color: white;
    }
</style>
</head>
<body>

<header>
    <h1>사원 관리 시스템</h1>
    <nav>
        <a href="${pageContext.request.contextPath}/emp/empIndex">홈</a>
        <a href="${pageContext.request.contextPath}/emp/empList">사원관리</a>
        <a href="${pageContext.request.contextPath}/emp/customerList">고객관리</a>
        <a href="${pageContext.request.contextPath}/emp/OutidList">탈퇴회원관리</a>
        <a href="${pageContext.request.contextPath}/emp/goodsList">상품관리</a>
          <a href="${pageContext.request.contextPath}/emp/noticeList">공지관리</a>
        
    </nav>
</header>

<div class="welcome">
    ${loginEmp.empName}님, 반갑습니다.
    <a href="${pageContext.request.contextPath}/emp/empLogout">로그아웃</a>
</div>

</body>
</html>
