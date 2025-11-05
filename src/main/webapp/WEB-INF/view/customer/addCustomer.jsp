<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GDJ95 SHOP 회원가입</title>
<style>
body {
  margin: 0;
  padding: 0;
  font-family: "Noto Sans KR", "Apple SD Gothic Neo", sans-serif;
  background-color: #f5f5f5;
  display: flex;
  flex-direction: column;
  align-items: center;
  min-height: 100vh;
}
.header {
  width: 100%;
  text-align: center;
  padding: 40px 0 20px 0;
  font-size: 28px;
  font-weight: 700;
  color: #333;
}
.signup-container {
  width: 100%;
  max-width: 480px;
  background: #ffffff;
  border-radius: 8px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.1);
  padding: 40px;
  margin-bottom: 40px;
}
.signup-container p {
  text-align: center;
  font-size: 14px;
  color: #666;
  margin-bottom: 32px;
}
form {
  display: flex;
  flex-direction: column;
  gap: 20px;
}
label {
  display: block;
  font-size: 14px;
  color: #555;
  margin-bottom: 6px;
  font-weight: 500;
}
input[type="text"],
input[type="password"],
input[type="tel"] {
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
}
button:hover {
  background-color: #27a300;
}
p a {
  color: #2db400;
  text-decoration: none;
}
p a:hover {
  text-decoration: underline;
}
#idCheckMsg {
  display: inline-block;
  margin-left: 10px;
  font-weight: 600;
}
#checkIdBtn {
  margin-top: 5px;
  width: auto;
  padding: 6px 12px;
  font-size: 13px;
  cursor: pointer;
  border: none;
  border-radius: 5px;
  background-color: #2db400;
  color: white;
  transition: all 0.2s;
}
#checkIdBtn:hover {
  background-color: #27a300;
}
#pwCheckMsg {
  display: inline-block;
  margin-left: 10px;
  font-weight: 600;
}
</style>
<script>
let isIdAvailable = false;

async function checkId() {
  const idInput = document.getElementById("id");
  const id = idInput.value.trim();
  const msg = document.getElementById("idCheckMsg");

  if (!id) {
    alert("아이디를 입력하세요.");
    return;
  }

  try {
    const response = await fetch("${pageContext.request.contextPath}/customer/checkId?id=" + encodeURIComponent(id));
    const result = await response.json();

    if (result.available) {
      msg.textContent = "사용 가능한 아이디입니다.";
      msg.style.color = "green";
      isIdAvailable = true;
    } else {
      msg.textContent = "이미 사용 중인 아이디입니다 다른 아이디를 선택해주세요. " 
      msg.style.color = "red";
      isIdAvailable = false;
    }
  } catch (err) {
    console.error(err);
    msg.textContent = "⚠️ 서버 오류 발생";
    msg.style.color = "orange";
    isIdAvailable = false;
  }
}

// 비밀번호 확인 체크
function checkPasswordMatch() {
  const pw = document.getElementById("pw").value.trim();
  const pwConfirm = document.getElementById("pwConfirm").value.trim();
  const msg = document.getElementById("pwCheckMsg");

  if (pw !== pwConfirm) {
    msg.textContent = "❌ 비밀번호가 일치하지 않습니다.";
    msg.style.color = "red";
    return false;
  } else {
    msg.textContent = "✅ 비밀번호가 일치합니다.";
    msg.style.color = "green";
    return true;
  }
}

// 폼 제출 시 체크
function validateForm() {
  const idInput = document.getElementById("id");
  const pwInput = document.getElementById("pw");
  const pwConfirmInput = document.getElementById("pwConfirm");
  const phoneInput = document.getElementById("phone");

  if (!isIdAvailable) {
    alert("아이디 중복 확인을 먼저 해주세요.");
    idInput.focus();
    return false;
  }

  if (idInput.value.trim().length < 4) {
    alert("아이디는 최소 4글자 이상이어야 합니다.");
    idInput.focus();
    return false;
  }

  if (pwInput.value.trim().length < 4) {
    alert("비밀번호는 최소 4글자 이상이어야 합니다.");
    pwInput.focus();
    return false;
  }

  if (!checkPasswordMatch()) {
    pwConfirmInput.focus();
    return false;
  }

  if (!phoneInput.value.trim()) {
    alert("전화번호를 입력해주세요.");
    phoneInput.focus();
    return false;
  }

  return true;
}
</script>
</head>
<body>

<div class="header">GDJ95 SHOP 회원가입</div>

<div class="signup-container">
  <p>계정을 생성하고 쇼핑을 시작하세요</p>
  <form method="post" action="${pageContext.request.contextPath}/out/addMember" onsubmit="return validateForm();">
    
    <div>
      <label for="id">아이디</label>
      <input type="text" name="id" id="id" required />
      <button type="button" id="checkIdBtn" onclick="checkId()">중복확인</button>
      <span id="idCheckMsg"></span>
    </div>

    <div>
      <label for="pw">비밀번호</label>
      <input type="password" name="pw" id="pw" required oninput="checkPasswordMatch()" />
    </div>

    <div>
      <label for="pwConfirm">비밀번호 확인</label>
      <input type="password" name="pwConfirm" id="pwConfirm" required oninput="checkPasswordMatch()" />
      <span id="pwCheckMsg"></span>
    </div>

    <div>
      <label for="phone">휴대폰번호</label>
      <input type="tel" name="phone" id="phone" required pattern="\d{2,3}\d{3,4}\d{4}" placeholder="01012345678" />
    </div>

    <div>
      <button type="submit">회원가입</button>
    </div>
  </form>
  <p>이미 계정이 있으신가요? 
     <a href="${pageContext.request.contextPath}/out/login">로그인</a>
  </p>
</div>

</body>
</html>
