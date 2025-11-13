<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    /* 네비게이션 전체 바 */
    .emp-navbar {
        background-color: #03c75a;
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 12px 40px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }

    /* 로고/타이틀 */
    .emp-navbar .logo {
        color: white;
        font-weight: 700;
        font-size: 20px;
        text-decoration: none;
        letter-spacing: 0.5px;
    }

    /* 메뉴 영역 */
    .emp-navbar .nav-links {
        display: flex;
        gap: 20px;
        align-items: center;
    }

    .emp-navbar .nav-links a {
        color: white;
        text-decoration: none;
        font-weight: 500;
        font-size: 15px;
        padding: 6px 10px;
        border-radius: 6px;
        transition: all 0.2s ease;
    }

    .emp-navbar .nav-links a:hover {
        background-color: rgba(255, 255, 255, 0.2);
    }

    /* 오른쪽 사용자 정보 */
    .emp-navbar .user-info {
        color: white;
        font-size: 14px;
    }

    .emp-navbar .logout-btn {
        margin-left: 10px;
        background: white;
        color: #03c75a;
        border: none;
        padding: 5px 12px;
        border-radius: 20px;
        font-size: 13px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    .emp-navbar .logout-btn:hover {
        background-color: #f1f1f1;
        transform: translateY(-1px);
    }
</style>

<div class="emp-navbar">
    <!-- 좌측 로고 -->
    <a href="${pageContext.request.contextPath}/emp/empIndex" class="logo">관리자 메뉴</a>

    <!-- 중앙 메뉴 -->
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/emp/goodsList">상품 목록</a>
        <a href="${pageContext.request.contextPath}/emp/addGoods">상품 등록</a>
         <a href="${pageContext.request.contextPath}/emp/ordersList">주문 내역</a>
        <a href="${pageContext.request.contextPath}/emp/customerList">고객 관리</a>
          <a href="${pageContext.request.contextPath}/emp/questionList">주문질문관리</a>
           <a href="${pageContext.request.contextPath}/emp/reviewList">상품리뷰관리</a>
        <a href="${pageContext.request.contextPath}/emp/noticeList">공지관리</a>
        
    </div>

    <!-- 우측 사용자 정보 -->
    <div class="user-info">
        <c:choose>
            <c:when test="${not empty loginEmp}">
                ${loginEmp.empName} 님
                <form action="${pageContext.request.contextPath}/out/logout" method="post" style="display:inline;">
                    <button type="submit" class="logout-btn">로그아웃</button>
                </form>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/out/login" class="logout-btn">로그인</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>
