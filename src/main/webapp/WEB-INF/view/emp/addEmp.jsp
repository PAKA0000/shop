<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>새 사원 등록</title>
<style>
body { font-family: 'Noto Sans KR', sans-serif; background-color: #f8f9fa; display: flex; justify-content: center; align-items: center; height: 100vh; }
.card { background: #fff; border-radius: 15px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); width: 420px; padding: 30px; }
h2 { text-align: center; color: #03c75a; margin-bottom: 25px; }
.form-group { margin-bottom: 18px; }
label { display: block; font-weight: 600; margin-bottom: 6px; color: #333; }
input, select { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 6px; font-size: 14px; box-sizing: border-box; }
input:focus, select:focus { outline: none; border-color: #03c75a; }
button { width: 100%; background-color: #03c75a; color: white; border: none; border-radius: 6px; padding: 12px; font-size: 15px; font-weight: 600; cursor: pointer; transition: all 0.2s; }
button:hover { background-color: #02b350; }
.back-link { display: block; text-align: center; margin-top: 15px; color: #03c75a; text-decoration: none; font-size: 14px; }
.back-link:hover { text-decoration: underline; }
#idCheckMsg { display: inline-block; margin-left: 10px; font-weight: 600; }
#checkIdBtn { margin-top: 5px; width: auto; padding: 6px 12px; font-size: 13px; cursor: pointer; border: none; border-radius: 5px; background-color: #03c75a; color: white; transition: all 0.2s; }
#checkIdBtn:hover { background-color: #02b350; }
</style>
</head>
<body>

<div class="card">
  <h2>새 사원 등록</h2>
  <form id="addEmpForm" action="${pageContext.request.contextPath}/emp/addEmp" method="post">
    
    <!-- 아이디 입력 -->
    <div class="form-group">
      <label for="empId">아이디</label>
      <input type="text" id="empId" name="empId" required>
      <button type="button" id="checkIdBtn">중복확인</button>
      <span id="idCheckMsg"></span>
    </div>

    <!-- 비밀번호 -->
    <div class="form-group">
      <label for="empPw">비밀번호</label>
      <input type="password" id="empPw" name="empPw" required>
    </div>

    <!-- 비밀번호 확인 -->
    <div class="form-group">
      <label for="empPwConfirm">비밀번호 확인</label>
      <input type="password" id="empPwConfirm" name="empPwConfirm" required>
    </div>

    <!-- 이름 -->
    <div class="form-group">
      <label for="empName">이름</label>
      <input type="text" id="empName" name="empName" required>
    </div>

    <!-- ✅ 활성/비활성 상태 선택 -->
    <div class="form-group">
      <label for="active">상태</label>
      <select id="active" name="active" required>
        <option value="1" selected>활성</option>
        <option value="0">비활성</option>
      </select>
    </div>

    <button type="submit" id="submitBtn">사원 등록</button>
  </form>

  <a class="back-link" href="${pageContext.request.contextPath}/emp/empList">← 사원 목록으로 돌아가기</a>
</div>

<script>
const idInput = document.querySelector("#empId");
const pwInput = document.querySelector("#empPw");
const pwConfirmInput = document.querySelector("#empPwConfirm");
const checkBtn = document.querySelector("#checkIdBtn");
const idMsg = document.querySelector("#idCheckMsg");

let isIdAvailable = false;

// ✅ 아이디 중복확인
checkBtn.addEventListener("click", async () => {
  const id = idInput.value.trim();
  if (!id) { alert("아이디를 입력하세요."); return; }
  try {
    const response = await fetch("${pageContext.request.contextPath}/emp/checkId?empId=" + encodeURIComponent(id));
    const result = await response.json();

    if (result.available) {
      idMsg.textContent = "사용 가능한 아이디입니다.";
      idMsg.style.color = "green";
      isIdAvailable = true;
    } else {
      idMsg.textContent = "이미 사용 중인 아이디입니다. 다른 아이디를 선택해주세요.";
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

// ✅ 폼 제출 전 검증
document.querySelector("#addEmpForm").addEventListener("submit", (e) => {
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
