<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>GDJ95 SHOP - 주문하기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<style>
/* ==============================
   기본 스타일
============================== */
body {
  margin: 0;
  padding: 0;
  font-family: "Noto Sans KR", "Apple SD Gothic Neo", sans-serif;
  background-color: #f5f5f5;
  color: #333;
}

h1 {
  text-align: center;
  background-color: #03c75a;
  color: #fff;
  padding: 20px 0;
  margin: 0;
  font-size: 26px;
  font-weight: 700;
}

.container {
  width: 80%;
  margin: 40px auto;
  background-color: #fff;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.08);
  padding: 40px 50px;
  box-sizing: border-box;
}

table {
  width: 100%;
  border-collapse: collapse;
  font-size: 15px;
  text-align: center;
  margin-bottom: 40px;
}

th {
  background-color: #f0f9f0;
  color: #03c75a;
  padding: 12px;
  border-bottom: 2px solid #03c75a;
}

td {
  padding: 12px;
  border-bottom: 1px solid #eee;
  vertical-align: middle;
}

tr:hover {
  background-color: #fafafa;
  transition: 0.2s;
}

td img {
  width: 80px;
  height: 80px;
  object-fit: cover;
  border-radius: 8px;
  box-shadow: 0 2px 6px rgba(0,0,0,0.1);
}

.section {
  background-color: #fafafa;
  padding: 25px 30px;
  border-radius: 10px;
  margin-bottom: 30px;
  box-shadow: inset 0 0 5px rgba(0,0,0,0.05);
}

.section h3 {
  color: #03c75a;
  font-size: 18px;
  margin-bottom: 15px;
  border-left: 5px solid #03c75a;
  padding-left: 10px;
}

input[type="text"],
input[type="number"],
select {
  padding: 8px 10px;
  border: 1px solid #ccc;
  border-radius: 6px;
  font-size: 14px;
  outline: none;
}

input:focus,
select:focus {
  border-color: #03c75a;
}

button {
  background-color: #03c75a;
  color: #fff;
  border: none;
  padding: 10px 22px;
  border-radius: 8px;
  font-size: 15px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s ease;
}

button:hover {
  background-color: #028a4f;
  transform: translateY(-1px);
  box-shadow: 0 4px 8px rgba(0,0,0,0.12);
}

button.gray {
  background-color: #fff;
  color: #03c75a;
  border: 2px solid #03c75a;
}

button.gray:hover {
  background-color: #03c75a;
  color: #fff;
}

#addressList {
  width: 100%;
  margin-top: 10px;
  padding: 8px;
  border-radius: 8px;
  border: 1px solid #ccc;
  font-size: 14px;
}

.submit-area {
  text-align: center;
  margin-top: 40px;
}

@media (max-width: 768px) {
  .container { width: 90%; padding: 25px; }
  table { font-size: 14px; }
  th, td { padding: 10px; }
  button { width: 100%; }
}
</style>
</head>

<body>
<h1>GDJ95 SHOP - 주문하기</h1>

<!-- 고객 메뉴 -->
<c:import url="/WEB-INF/view/inc/customerMenu.jsp"></c:import>
<hr>

<div class="container">
  <form method="post" action="${pageContext.request.contextPath}/customer/addOrders">

    <!-- 상품 목록 -->
    <c:choose>
      <c:when test="${not empty list}">
        <table>
          <tr>
            <th>상품 이미지</th>
            <th>상품명</th>
            <th>가격</th>
            <th>포인트율</th>
            <th>수량</th>
          </tr>
          <c:forEach var="m" items="${list}">
            <input type="hidden" name="goodsCode" value="${m.goodsCode}">
            <input type="hidden" name="cartQuantity" value="${m.cartQuantity}">
            <input type="hidden" name="goodsPrice" value="${m.goodsPrice}">
            <tr>
              <td><img src="${pageContext.request.contextPath}/upload/${m.filename}" alt="${m.goodsName}"></td>
              <td>${m.goodsName}</td>
              <td><fmt:formatNumber value="${m.goodsPrice}" type="number"/>원</td>
              <td>${m.pointRate}%</td>
              <td>${m.cartQuantity}</td>
            </tr>
          </c:forEach>
        </table>
      </c:when>
      <c:otherwise>
        <p style="text-align:center; color:#777;">장바구니가 비어 있습니다.</p>
      </c:otherwise>
    </c:choose>

    <!-- 배송지 정보 -->
    <div class="section">
      <h3>배송지 정보</h3>
      <div style="display:flex; align-items:center; gap:10px; margin-bottom:15px;">
        <input type="text" id="addressCodeInput" name="addressCode" placeholder="배송지 코드 또는 직접 입력" style="flex:1;">
        <button type="button" id="addressBtn" class="gray">배송지 선택</button>
      </div>
      <select id="addressList" size="5">
        <c:forEach var="addr" items="${addressList}">
          <option value="${addr.addressCode}">${addr.address}</option>
        </c:forEach>
      </select>
      <input type="text" id="addressCode" readonly>
      <input type="text" id="address" readonly>
    </div>

    <!-- 결제 정보 -->
    <div class="section">
      <h3>결제 정보</h3>
      <div style="margin-bottom:12px;">
        <label>포인트 사용:</label>
        <input type="number" name="usePoint" value="0" min="0" style="width:120px;">
      </div>
      <div>
        <label>결제 금액:</label>
        <input type="number" name="orderPrice" value="${orderPrice}" readonly style="width:120px;"> 원
      </div>
    </div>

    <!-- 결제 버튼 -->
    <div class="submit-area">
      <button type="submit">💳 결제하기 (주문완료)</button>
    </div>

  </form>
</div>

<script>
  // 배송지 선택
  $('#addressBtn').click(function(){
    var selected = $('#addressList').val();
    var selectedText = $('#addressList option:selected').text();
    $('#addressCodeInput').val(selected);
    $('#addressCode').val(selected);
    $('#address').val(selectedText);
  });
</script>
</body>
</html>
