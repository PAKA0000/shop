<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>고객 회원가입</title>
<style>
body {
  font-family: 'Noto Sans KR', sans-serif;
  background-color: #f8f9fa;
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
}
.card {
  background: #fff;
  border-radius: 15px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.1);
  width: 420px;
  padding: 30px;
}
h2 {
  text-align: center;
  color: #03c75a;
  margin-bottom: 25px;
}
.form-group {
  margin-bottom: 18px;
}
label {
  display: block;
  font-weight: 600;
  margin-bottom: 6px;
  color: #333;
}
input, select {
  width: 100%;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 6px;
  font-size: 14px;
  box-sizing: border-box;
}
input:focus, select:focus {
  outline: none;
  border-color: #03c75a;
}
button {
  width: 100%;
  background-color: #03c75a;
  color: white;
  border: none;
  border-radius: 6px;
  padding: 12px;
  font-size: 15px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s;
}
button:hover {
  background-color: #02b350;
}
.back-link {
  display: block;
  text-align: center;
  margin-top: 15px;
  color: #03c75a;
  text-decoration: none;
  font-size: 14px;
}
.back-link:hover {
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
  background-color: #03c75a;
  color: white;
  transition: all 0.2s;
}
#checkIdBtn:hover {
  background-color: #02b350;
}
</style>
</head>
<body>

<div class="card">
  <h2>고객 회원가입</h2>
  <form id="addCustomerForm" action="${pageContext.request.contextPath}/customer/addMember" method="post">
    <div class="form-group">
      <label for="customerId">아이디</label>
      <input type="text" id="customerId" name="id" required>
      <button type="button" id="checkIdBtn">중복확인</button>
      <span id="idCheckMsg"></span>
    </div>

    <div class="form-group">
      <label for="customerPw">비밀번호</label>
      <input type="password" id="customerPw" name="pw" required>
    </div>

    <div class="form-group">
      <label for="customerPwConfirm">비밀번호 확인</label>
      <input type="password" id="customerPwConfirm" name="pwConfirm" required>
    </div>

    <div class="form-group">
      <label for="customerName">이름</label>
      <input type="text" id="customerName" name="name" required>
    </div>

    <div class="form-group">
      <label for="customerPhone">휴대폰번호</label>
      <input type="tel" id="customerPhone" name="phone" required pattern="\d{2,3}\d{3,4}\d{4}" placeholder="01012345678">
    </div>

    <button type="submit" id="submitBtn">회원가입</button>
  </form>

  <a class="back-link" href="${pageContext.request.contextPath}/out/login">← 로그인으로 돌아가기</a>
</div>

<script>
const idInput = document.querySelector("#customerId");
const pwInput = document.querySelector("#customerPw");
const pwConfirmInput = document.querySelector("#customerPwConfirm");
const checkBtn = document.querySelector("#checkIdBtn");
const idMsg = document.querySelector("#idCheckMsg");

let isIdAvailable = false;

// 아이디 중복 확인
checkBtn.addEventListener("click", async () => {
  const id = idInput.value.trim();
  if (!id) {
    alert("아이디를 입력하세요.");
    return;
  }
  try {
    const response = await fetch("${pageContext.request.contextPath}/customer/checkId?id=" + encodeURIComponent(id));
    const result = await response.json();

    if (result.available) {
      idMsg.textContent = "✅ 사용 가능한 아이디입니다.";
      idMsg.style.color = "green";
      isIdAvailable = true;
    } else {
      idMsg.textContent = "❌ 이미 사용 중인 아이디: " + result.id;
      idMsg.style.color = "red";
      isIdAvailable = false;
    }
  } catch (err) {
    console.error(err);
    idMsg.textContent = "⚠️ 서버 오류 발생";
    idMsg.style.color = "orange";
    isIdAvailable = false;
  }
});

// 폼 제출 시 검증
document.querySelector("#addCustomerForm").addEventListener("submit", (e) => {
  if (!isIdAvailable) {
    e.preventDefault();
    alert("아이디 중복 확인을 먼저 해주세요.");
    idInput.focus();
    return;
  }
  if (pwInput.value !== pwConfirmInput.value) {
    e.preventDefault();
    alert("비밀번호가 일치하지 않습니다.");
    pwConfirmInput.focus();
  }
});
</script>

</body>
</html>
