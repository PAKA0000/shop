<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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

/* 컨테이너 */
form {
  width: 80%;
  margin: 40px auto;
  background-color: #fff;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.08);
  padding: 30px 40px;
}

/* 테이블 */
table {
  width: 100%;
  border-collapse: collapse;
  font-size: 15px;
  text-align: center;
}

th {
  background-color: #f0f9f0;
  color: #2db400;
  padding: 12px;
  border-bottom: 2px solid #2db400;
}

td {
  padding: 12px;
  border-bottom: 1px solid #eee;
}

tr:hover {
  background-color: #fafafa;
  transition: 0.2s;
}

/* 품절 표시 */
td c\\:if {
  color: #aaa;
}

/* 체크박스 */
input[type="checkbox"] {
  width: 18px;
  height: 18px;
  cursor: pointer;
}

/* 버튼 */
button {
  display: block;
  margin: 30px auto 0 auto;
  background-color: #2db400;
  color: #fff;
  border: none;
  padding: 12px 30px;
  border-radius: 8px;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.25s ease;
}

button:hover {
  background-color: #28a000;
  transform: translateY(-1px);
  box-shadow: 0 4px 8px rgba(0,0,0,0.12);
}

/* 반응형 */
@media (max-width: 768px) {
  form {
    width: 90%;
    padding: 20px;
  }
  table {
    font-size: 14px;
  }
  th, td {
    padding: 10px;
  }
  button {
    width: 100%;
  }
}
</style>

</head>

<body>
	<h1>cartList</h1>
	<!-- customer meun include -->
	<c:import url="/WEB-INF/view/inc/customerMenu.jsp"></c:import>
	<hr>
	<form method="get" action="${pageContext.request.contextPath}/customer/addOrders">
		<table border="1">
			<tr>
				<th>선택</th>
				<th>goodsName</th>
				<th>goodsPrice</th>
				<th>cartQuantity</th>
				<th>totalPrice</th>
			</tr>
			<c:forEach var="m" items="${list}">
				<tr>
					<td>
						<c:if test="${m.soldout == 'soldout'}">
							soldout
						</c:if>
						<c:if test="${m.soldout != 'soldout'}">
							<input type="checkbox" name="cartCodeList" value="${m.cartCode}">
						</c:if>
					</td>
					<td>${m.goodsName}</td>
					<td>${m.goodsPrice}</td>
					<td>
						${m.cartQuantity}
					</td>
					<td>${m.totalPrice}</td>
				</tr>
			</c:forEach>
		</table>
		<button type="submit">주문하기</button>
	</form>
</body>
</html>