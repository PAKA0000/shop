<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GDJ95 SHOP - 상품 상세</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- ✅ 스타일 시작 -->
<style>
body {
  margin: 0;
  padding: 0;
  font-family: "Noto Sans KR", "Apple SD Gothic Neo", sans-serif;
  background-color: #f5f5f5;
  color: #333;
}

/* 헤더 */
h1 {
  text-align: center;
  background-color: #2db400;
  color: white;
  padding: 20px 0;
  margin: 0;
  font-size: 26px;
  font-weight: 700;
}

/* 로그인 정보 */
.user-info {
  text-align: right;
  padding: 20px 40px;
  font-size: 15px;
  color: #444;
}
.user-info a {
  color: #2db400;
  text-decoration: none;
  font-weight: 600;
  margin-left: 10px;
}
.user-info a:hover {
  text-decoration: underline;
}

/* 상품 상세 컨테이너 */
.goods-container {
  display: flex;
  justify-content: center;
  align-items: flex-start;
  gap: 40px;
  background-color: #fff;
  margin: 40px auto;
  padding: 40px;
  width: 80%;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.08);
}

/* 상품 이미지 */
.goods-container img {
  width: 420px;
  height: 420px;
  object-fit: cover;
  border-radius: 10px;
  box-shadow: 0 2px 6px rgba(0,0,0,0.1);
}

/* 상품 정보 */
.goods-info {
  flex: 1;
}

/* 상품 테이블 */
.goods-info table {
  border-collapse: collapse;
  width: 100%;
  font-size: 15px;
  color: #333;
}
.goods-info td {
  padding: 10px 12px;
  border-bottom: 1px solid #eee;
}
.goods-info td:first-child {
  font-weight: 600;
  background-color: #f9f9f9;
  width: 120px;
}

/* 수량 선택 */
.goods-info select {
  padding: 6px 10px;
  border: 1px solid #ccc;
  border-radius: 6px;
  font-size: 14px;
  outline: none;
}
.goods-info select:focus {
  border-color: #2db400;
}

/* 버튼 */
button {
  margin-top: 20px;
  margin-right: 10px;
  padding: 10px 18px;
  font-size: 15px;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  font-weight: 600;
  transition: all 0.2s ease;
  display: inline-flex;
  align-items: center;
  gap: 6px;
}

/* 장바구니 버튼 */
.cart-btn {
  background-color: #fff;
  color: #2db400;
  border: 2px solid #2db400;
}
.cart-btn:hover {
  background-color: #2db400;
  color: #fff;
}

/* 주문 버튼 */
.order-btn {
  background-color: #2db400;
  color: #fff;
}
.order-btn:hover {
  background-color: #28a000;
}

/* 상품 설명 영역 */
.goods-desc {
  width: 80%;
  margin: 20px auto 60px auto;
  background-color: #fff;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.08);
  padding: 30px 40px;
}
.goods-desc h2 {
  color: #2db400;
  font-size: 20px;
  border-left: 5px solid #2db400;
  padding-left: 10px;
  margin-bottom: 15px;
}
.goods-desc p {
  line-height: 1.8;
  color: #444;
  font-size: 15px;
}

/* 반응형 */
@media (max-width: 768px) {
  .goods-container {
    flex-direction: column;
    align-items: center;
    width: 90%;
    padding: 20px;
  }
  .goods-container img {
    width: 100%;
    height: auto;
  }
  .goods-desc {
    width: 90%;
    padding: 20px;
  }
}
</style>
<!-- ✅ 스타일 끝 -->
</head>

<body>
  <h1>GDJ95 SHOP</h1>

  <div class="user-info">
    ${loginCustomer.customerName}님 반갑습니다. 
    (point: ${loginCustomer.point})
    <a href="${pageContext.request.contextPath}/customer/customerLogout">로그아웃</a>
  </div>

  <div class="goods-container">
    <img src="${pageContext.request.contextPath}/upload/${goods.filename}" alt="${goods.goodsName}">
    <div class="goods-info">
      <form  method="get">
        <table>
          <tr><td>상품명</td><td>${goods.goodsName}</td></tr>
          <tr><td>가격</td> <td> <fmt:formatNumber value="${goods.goodsPrice}" type="number"/>원</td></tr>
          <tr><td>포인트율</td><td>${goods.pointRate}%</td></tr>
          <tr><td>판매상태</td><td>${goods.soldout}</td></tr>
          <tr>
            <td>수량</td>		
            <td>
              <select name = "cartQuentily">
                <c:forEach var="n" begin="1" end="10">
                  <option value="${n}">${n}</option>
                </c:forEach>
              </select>
            </td>
          </tr>
        </table>
        <button type="button" class="cart-btn">🛒 장바구니</button>
        <button type="button" class="order-btn">💳 바로 주문</button>
      </form>
    </div>
  </div>

  <div class="goods-desc">
    <h2>상품 설명</h2>
    <p>
      ${goods.goodsContent}
      <br><br>
      ※ 실제 상품 이미지는 조명, 해상도 등에 따라 색상이 다를 수 있습니다.<br>
      ※ 재고 상황에 따라 조기 품절될 수 있습니다.
    </p>
  </div>
</body>
</html>
