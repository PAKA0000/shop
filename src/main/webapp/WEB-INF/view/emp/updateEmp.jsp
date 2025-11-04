<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>사원 정보 수정</title>

<style>
body {
  font-family: 'Noto Sans KR', sans-serif;
  background-color: #f8f9fa;
}
.container {
  width: 400px;
  margin: 80px auto;
  background: #fff;
  border-radius: 10px;
  box-shadow: 0 4px 10px rgba(0,0,0,0.1);
  padding: 30px;
}
h2 {
  text-align: center;
  color: #03c75a;
}
form {
  display: flex;
  flex-direction: column;
  gap: 10px;
}
label {
  font-weight: bold;
  margin-top: 5px;
}
input[type=text],
select {
  padding: 8px;
  border: 1px solid #ddd;
  border-radius: 5px;
  font-size: 14px;
  width: 100%;
  box-sizing: border-box;
}
input[readonly] {
  background: #f5f5f5;
  color: #888;
}
button {
  background: #03c75a;
  color: white;
  border: none;
  border-radius: 5px;
  padding: 10px;
  cursor: pointer;
  transition: all 0.2s;
}
button:hover {
  background: #02b050;
}
</style>
</head>
<body>
<div class="container">
  <h2>사원 정보 수정</h2>
  
  <form action="${pageContext.request.contextPath}/emp/updateEmp" method="post">
    <!-- 사원아이디: 수정 불가 / 표시만 -->
    <label>사원 ID</label>
    <input type="text" name="empId_display" value="${emp.empId}" readonly>
    <!-- 실제로 DB 수정에 필요한 empId는 hidden으로 전달 -->
    <input type="hidden" name="empId" value="${emp.empId}">
    
    <label>사원 이름</label>
    <input type="text" name="empName" value="${emp.empName}" required>

    <label>활성 상태</label>
    <select name="active">
      <option value="1" ${emp.active == 1 ? 'selected' : ''}>활성</option>
      <option value="0" ${emp.active == 0 ? 'selected' : ''}>비활성</option>
    </select>

    <button type="submit">수정 완료</button>
  </form>
</div>
</body>
</html>
