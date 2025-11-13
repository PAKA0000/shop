<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
.emp-navbar {
  background-color: #03c75a;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 14px 60px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  font-family: "Noto Sans KR", sans-serif;
  flex-wrap: wrap;
  gap: 10px;
}
.emp-navbar .logo { color: #fff; font-weight: 700; font-size: 20px; text-decoration: none; }
.emp-navbar .logo:hover { opacity: 0.85; }
.emp-navbar .nav-links { display: flex; justify-content: center; flex: 1; gap: 36px; text-align: center; }
.emp-navbar .nav-links a { color: #fff; text-decoration: none; font-weight: 500; font-size: 15px; padding: 8px 14px; border-radius: 8px; min-width: 80px; text-align: center; }
.emp-navbar .nav-links a:hover { background-color: rgba(255,255,255,0.18); transform: translateY(-1px); }
.emp-navbar .user-info { display: flex; align-items: center; gap: 12px; color: #fff; font-size: 14px; flex-shrink: 0; }
.emp-navbar .logout-btn { background-color: #fff; color: #03c75a; border: none; padding: 6px 16px; border-radius: 20px; font-size: 13px; font-weight: 600; cursor: pointer; transition: all 0.25s ease; }
.emp-navbar .logout-btn:hover { background-color: #f6f6f6; transform: translateY(-1px); }
@media (max-width: 1024px) {
  .emp-navbar { flex-direction: column; align-items: center; padding: 16px 24px; gap: 14px; }
  .emp-navbar .nav-links { flex-wrap: wrap; gap: 14px; }
  .emp-navbar .nav-links a { font-size: 14px; padding: 6px 10px; min-width: 70px; }
  .emp-navbar .logout-btn { padding: 5px 12px; }
}
</style>

<div class="emp-navbar">
  <!-- 왼쪽: 로고 -->
  <a href="${pageContext.request.contextPath}/customer/customerIndex.jsp" class="logo">
    🛍 GDJ95 SHOP
  </a>

  <!-- 가운데: 메뉴 -->
  <div class="nav-links">
    <a href="${pageContext.request.contextPath}/customer/customerIndex.jsp">상품목록</a>
    <a href="${pageContext.request.contextPath}/customer/customerInfo.jsp">개인정보</a>
    <a href="${pageContext.request.contextPath}/customer/addressList.jsp">배송지관리</a>
    <a href="${pageContext.request.contextPath}/customer/cartList.jsp">장바구니</a>
  </div>

  <!-- 오른쪽: 사용자 정보 -->
  <div class="user-info">
    <span>${loginCustomer.customerName}님</span>
    <span style="opacity: 0.85;">(point: ${loginCustomer.point})</span>
    <form action="${pageContext.request.contextPath}/customer/customerLogout" method="post" style="margin:0;">
      <button type="submit" class="logout-btn">로그아웃</button>
    </form>
  </div>
</div>
