<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<div>
	<a href="${pageContext.request.contextPath}/customer/addressList">[배송지관리]</a>
</div>