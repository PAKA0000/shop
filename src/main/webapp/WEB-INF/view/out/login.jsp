<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
/* 전체 배경 */
body {
  margin: 0;
  padding: 0;
  font-family: "Noto Sans KR", "Apple SD Gothic Neo", sans-serif;
  background-color: #f5f5f5;
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
}

/* 카드형 컨테이너 */
.login-container {
  width: 100%;
  max-width: 400px;
  background: #ffffff;
  border-radius: 8px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.1);
  padding: 40px;
  text-align: center;
}

/* 헤더 */
.login-container h1 {
  font-size: 26px;
  font-weight: 700;
  margin-bottom: 24px;
  color: #333;
}

/* 폼 */
form {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

label {
  font-size: 14px;
  color: #555;
  display: block;
  margin-bottom: 6px;
  text-align: left;
}

input[type="text"],
input[type="password"] {
  width: 100%;
  padding: 12px 14px;
  border: 1px solid #dcdcdc;
  border-radius: 4px;
  font-size: 14px;
  transition: all 0.2s;
}

input:focus {
  outline: none;
  border-color: #2db400;
  box-shadow: 0 0 0 2px rgba(45,180,0,0.2);
}

/* 로그인 버튼 */
button {
  width: 100%;
  padding: 14px;
  border: none;
  border-radius: 4px;
  background-color: #2db400;
  color: #fff;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s;
  margin-top: 8px;
}

button:hover {
  background-color: #27a300;
}

/* 고객/사원 라디오 버튼 */
.radio-group {
  display: flex;
  justify-content: center;
  gap: 20px;
  margin-top: 16px;
  font-size: 14px;
  color: #555;
}

.radio-group input[type="radio"] {
  margin-right: 6px;
}

/* 회원가입 링크 */
.signup-link {
  display: block;
  margin-top: 20px;
  font-size: 14px;
  color: #2db400;
  text-decoration: none;
}

.signup-link:hover {
  text-decoration: underline;
}
</style>
<script>
  function validateLoginForm() {
    const id = document.getElementById("id").value.trim();
    const pw = document.getElementById("pw").value.trim();

    if(id.length < 1) {
      alert("아이디를 입력하세요.");
      return false;
    }
    if(pw.length < 1) {
      alert("비밀번호를 입력하세요.");
      return false;
    }
    return true;
  }

  window.onload = function() {
    const form = document.querySelector("form");
    form.onsubmit = function() {
      return validateLoginForm(); // 유효성 검사 후 제출
    };
  };
</script>

</head>
<body>
	<div class="login-container">
  <h1>GDJ95 SHOP 로그인</h1>
  <form method="post" action="${pageContext.request.contextPath}/out/login">
    <div>
      <label for="id">아이디</label>
      <input type="text" name="id" id="id">
    </div>
    <div>
      <label for="pw">비밀번호</label>
      <input type="password" name="pw" id="pw">
    </div>
    <button type="submit">로그인</button>
    <div class="radio-group">
      <label><input type="radio" name="customerOrEmpSel" value="Customer" checked> 고객</label>
      <label><input type="radio" name="customerOrEmpSel" value="Emp"> 사원</label>
    </div>
  </form>
 <a href="${pageContext.request.contextPath}/customer/addCustomer" class="signup-link">회원가입</a>

</div>
