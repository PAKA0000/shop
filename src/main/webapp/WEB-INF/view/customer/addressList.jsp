<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>배송지 관리 | N-Shop</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<style>
body {
  font-family: 'Noto Sans KR', sans-serif;
  background-color: #f8f9fa;
  margin: 0;
  padding: 0;
}

.container {
  width: 900px;
  background: #fff;
  border-radius: 15px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.08);
  margin: 40px auto;
  padding: 40px;
}

h1 {
  color: #03c75a;
  font-size: 28px;
  text-align: center;
  margin-bottom: 25px;
}

.menu {
  text-align: center;
  margin-bottom: 20px;
}

.menu a {
  color: #03c75a;
  text-decoration: none;
  font-weight: 600;
  padding: 8px 16px;
  border-radius: 6px;
  border: 1px solid #03c75a;
  transition: all 0.2s;
}

.menu a:hover {
  background-color: #03c75a;
  color: white;
}

.table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 20px;
}

.table th, .table td {
  padding: 12px 10px;
  border-bottom: 1px solid #eee;
  text-align: left;
}

.table th {
  background-color: #fafafa;
  font-weight: 600;
  color: #444;
}

.table tr:hover {
  background-color: #f9f9f9;
}

.btn {
  padding: 6px 12px;
  font-size: 13px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  transition: all 0.2s;
}

.btn-green {
  background-color: #03c75a;
  color: white;
}

.btn-green:hover {
  background-color: #02b350;
}

.btn-gray {
  background-color: #e9ecef;
  color: #333;
}

.btn-gray:hover {
  background-color: #dee2e6;
}

.no-data {
  text-align: center;
  color: #777;
  padding: 30px 0;
}

.note {
  margin-top: 20px;
  font-size: 13px;
  color: #666;
  text-align: center;
}
</style>
</head>

<body>
  <div class="container">
    <h1>배송지 관리</h1>

    <!-- customer menu include -->
    <c:import url="/WEB-INF/view/inc/customerMenu.jsp"></c:import>
    <hr>

    <div class="menu">
      <a href="${pageContext.request.contextPath}/customer/addAddress">＋ 새 배송지 추가</a>
    </div>

    <table class="table">
      <thead>
        <tr>
          <th>받는 분</th>
          <th>주소</th>
          <th>우편번호</th>
          <th>상세주소</th>
          <th>기본배송지</th>
          <th>관리</th>
        </tr>
      </thead>
      <tbody>
        <c:choose>
          <c:when test="${empty addressList}">
            <tr><td colspan="6" class="no-data">등록된 배송지가 없습니다.</td></tr>
          </c:when>
          <c:otherwise>
            <c:forEach var="a" items="${addressList}">
              <tr>
                <td>${a.receiverName}</td>
                <td>${a.roadAddress} ${a.extraAddress}</td>
                <td>${a.postcode}</td>
                <td>${a.detailAddress}</td>
                <td>
                  <c:choose>
                    <c:when test="${a.defaultAddress eq 'Y'}">
                      ✅ 기본
                    </c:when>
                    <c:otherwise>
                      <form method="post" action="${pageContext.request.contextPath}/customer/setDefaultAddress" style="display:inline;">
                        <input type="hidden" name="addressNo" value="${a.addressNo}">
                        <button type="submit" class="btn btn-gray">기본으로 설정</button>
                      </form>
                    </c:otherwise>
                  </c:choose>
                </td>
                <td>
                  <form method="post" action="${pageContext.request.contextPath}/customer/deleteAddress" style="display:inline;">
                    <input type="hidden" name="addressNo" value="${a.addressNo}">
                    <button type="submit" class="btn btn-gray">삭제</button>
                  </form>
                </td>
              </tr>
            </c:forEach>
          </c:otherwise>
        </c:choose>
      </tbody>
    </table>

    <div class="note">
      배송지는 최대 <strong>5개</strong>까지 등록할 수 있으며,<br>
      6번째 입력 시 가장 오래된 배송지가 자동으로 삭제됩니다.
    </div>
  </div>
</body>
</html>
