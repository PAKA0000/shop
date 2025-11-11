<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
<style>
body { font-family:'Noto Sans KR',sans-serif; background:#f5f5f5; margin:0; padding:0;}
.container { width:500px; margin:60px auto; background:#fff; padding:40px; border-radius:10px; box-shadow:0 4px 15px rgba(0,0,0,0.1);}
h2 { color:#03c75a; text-align:center; margin-bottom:30px;}
form label { display:block; margin-top:15px; font-weight:500;}
form input { width:100%; padding:10px; margin-top:5px; border:1px solid #ccc; border-radius:5px; font-size:14px;}
form button { margin-top:25px; width:100%; padding:12px; background:#03c75a; color:#fff; font-weight:600; border:none; border-radius:5px; cursor:pointer; transition:0.3s;}
form button:hover { background:#02b150; }
</style>
</head>
<body>
<div class="container">
    <h2>회원 정보 수정</h2>
    <form method="post" action="${pageContext.request.contextPath}/customer/customerInfo">
        <label>아이디</label>
        <input type="text" name="id" value="${customer.customerId}" readonly>

        <label>비밀번호</label>
        <input type="password" name="pw" value="${customer.customerPw}" required>

        <label>이름</label>
        <input type="text" name="name" value="${customer.customerName}" required>

        <label>전화번호</label>
        <input type="text" name="phone" value="${customer.customerPhone}" required>

        <button type="submit">수정하기</button>
    </form>
</div>
</body>
</html>
