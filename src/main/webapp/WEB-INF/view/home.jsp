<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GDJ95 SHOP - HOME</title>
<style>
/* 기본 폰트 및 레이아웃 */
body {
  margin: 0;
  padding: 0;
  font-family: "Noto Sans KR", "Apple SD Gothic Neo", sans-serif;
  background: linear-gradient(135deg, #f8fff2 0%, #eaffea 100%);
  height: 100vh;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  text-align: center;
  color: #333;
}

/* 로고 텍스트 */
h1 {
  font-size: 48px;
  color: #2db400;
  margin-bottom: 10px;
  font-weight: 800;
  letter-spacing: 1px;
}

/* 부제목 */
.tagline {
  font-size: 18px;
  color: #666;
  margin-bottom: 50px;
}

/* 버튼 컨테이너 */
.btn-container {
  display: flex;
  gap: 20px;
}

/* 버튼 스타일 */
.btn {
  display: inline-block;
  padding: 14px 28px;
  border-radius: 10px;
  font-size: 18px;
  font-weight: 600;
  text-decoration: none;
  transition: all 0.2s ease-in-out;
  box-shadow: 0 4px 12px rgba(0,0,0,0.08);
}

/* 로그인 버튼 */
.btn-login {
  background-color: #2db400;
  color: white;
}
.btn-login:hover {
  background-color: #28a000;
  transform: translateY(-2px);
}

/* 회원가입 버튼 */
.btn-signup {
  background-color: white;
  color: #2db400;
  border: 2px solid #2db400;
}
.btn-signup:hover {
  background-color: #2db400;
  color: white;
  transform: translateY(-2px);
}

/* 반응형 */
@media (max-width: 600px) {
  h1 {
    font-size: 36px;
  }
  .btn-container {
    flex-direction: column;
  }
  .btn {
    width: 180px;
  }
}
</style>
</head>
<body>

  <h1>GDJ95 SHOP</h1>
  <div class="tagline">당신의 일상을 더 편하게, 더 스마트하게 🛍️</div>

  <div class="btn-container">
    <a href="${pageContext.request.contextPath}/out/login" class="btn btn-login">로그인</a>
    <a href="${pageContext.request.contextPath}/customer/addCustomer" class="btn btn-signup">회원가입</a>
  </div>

</body>
</html>
