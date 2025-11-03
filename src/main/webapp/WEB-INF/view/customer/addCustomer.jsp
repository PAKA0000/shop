<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
/* 전체 배경 */
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

/* 상단 헤더 */
.header {
  width: 100%;
  text-align: center;
  padding: 40px 0 20px 0;
  font-size: 28px;
  font-weight: 700;
  color: #333;
}

/* 카드 컨테이너 */
.signup-container {
  width: 100%;
  max-width: 480px;
  background: #ffffff;
  border-radius: 8px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.1);
  padding: 40px;
  margin-bottom: 40px;
}

/* 카드 안 문구 */
.signup-container p {
  text-align: center;
  font-size: 14px;
  color: #666;
  margin-bottom: 32px;
}

/* 폼 */
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
input[type="email"],
input[type="tel"],
input[type="date"] {
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

/* 버튼 */
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

/* 링크 */
p a {
  color: #2db400;
  text-decoration: none;
}

p a:hover {
  text-decoration: underline;
}
</style>
<meta charset="UTF-8">
<script>
function validateForm() {
  // 입력값 가져오기
  const id = document.getElementById("id").value.trim();
  const pw = document.getElementById("pw").value.trim();
  const email = document.getElementById("email").value.trim();
  const birth = document.getElementById("birth").value.trim();

  // 아이디 4글자 이상 체크
  if (id.length < 4) {
    alert("아이디는 최소 4글자 이상이어야 합니다.");
    document.getElementById("id").focus();
    return false;
  }

  // 비밀번호 4글자 이상 체크
  if (pw.length < 4) {
    alert("비밀번호는 최소 4글자 이상이어야 합니다.");
    document.getElementById("pw").focus();
    return false;
  }

  // 이메일 @ 포함 체크
  if (email.length === 0 || !email.includes("@")) {
    alert("올바른 이메일을 입력해주세요.");
    document.getElementById("email").focus();
    return false;
  }

  // 생년월일 필수 체크
  if (birth.length === 0) {
    alert("생년월일을 입력해주세요.");
    document.getElementById("birth").focus();
    return false;
  }

 
  return true;
}
</script>

</script>
</head>
<title>GDJ95 SHOP 회원가입</title>
<body>
  <!-- 상단 헤더 -->
  <div class="header">
    GDJ95 SHOP 회원가입
  </div>

  <!-- 회원가입 카드 -->
  <div class="signup-container">
    <p>계정을 생성하고 쇼핑을 시작하세요</p>
    <form method="post" action="${pageContext.request.contextPath}/customer/addMember">
      <div>
        <label for="id">아이디</label>
        <input type="text" name="id" id="id" required />
      </div>
      <div>
        <label for="pw">비밀번호</label>
        <input type="password" name="pw" id="pw" required />
      </div>
      <div>
        <label for="email">이메일</label>
        <input type="email" name="email" id="email" required />
      </div>
      <div>
        <label for="birth">생년월일</label>
        <input type="date" name="birth" id="birth" required />
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

 