<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>사원 목록</title>

<style>
/* ====== 네이버 스타일 사원목록 ====== */
body {
  font-family: 'Noto Sans KR', sans-serif;
  background-color: #f8f9fa;
  margin: 0;
  padding: 0;
}

.container {
  width: 80%;
  margin: 50px auto;
}

.card {
  background: #fff;
  border-radius: 15px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
  overflow: hidden;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background: #03c75a;
  color: white;
  padding: 15px 25px;
}

.card-header h2 {
  margin: 0;
  font-size: 20px;
  font-weight: 700;
}

/* 새 사원 등록 버튼 */
.add-btn {
  background-color: white;
  color: #03c75a;
  font-weight: 600;
  border: none;
  border-radius: 5px;
  padding: 6px 12px;
  cursor: pointer;
  transition: all 0.2s;
}

.add-btn:hover {
  background-color: #f1f1f1;
  transform: scale(1.05);
}

/* 테이블 */
.card-body {
  padding: 25px;
}

.table {
  width: 100%;
  border-collapse: collapse;
  text-align: center;
  font-size: 14px;
}

.table th {
  background-color: #f2f2f2;
  padding: 10px;
  font-weight: bold;
}

.table td {
  padding: 10px;
  border-bottom: 1px solid #eee;
}

.table tr:hover {
  background-color: #fafafa;
}

/* 상태 버튼 */
.toggle-btn {
  border: none;
  padding: 6px 12px;
  border-radius: 15px;
  cursor: pointer;
  font-weight: 600;
  font-size: 13px;
  transition: all 0.25s ease;
}

.toggle-btn.on {
  background-color: #03c75a;
  color: white;
}

.toggle-btn.off {
  background-color: #ccc;
  color: #333;
}

.toggle-btn:hover {
  transform: scale(1.05);
}

/* 수정/삭제 버튼 */
.action-btn {
  padding: 6px 10px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  font-size: 13px;
  font-weight: 600;
  transition: 0.2s;
}

.edit-btn {
  background: #f1f1f1;
  color: #333;
}

.edit-btn:hover {
  background: #dfe6e9;
}

.delete-btn {
  background: #ff6b6b;
  color: white;
}

.delete-btn:hover {
  background: #e84118;
}

/* 등록일 */
.small-muted {
  color: #888;
  font-size: 13px;
}

/* 페이징 */
.pagination {
  display: flex;
  justify-content: center;
  gap: 5px;
  margin-top: 25px;
}

.page-btn {
  padding: 6px 12px;
  border: 1px solid #ddd;
  border-radius: 5px;
  background: white;
  color: #333;
  cursor: pointer;
  text-decoration: none;
  font-size: 13px;
  transition: all 0.2s;
}

.page-btn.active {
  background-color: #03c75a;
  color: white;
  border-color: #03c75a;
}

.page-btn:hover {
  background-color: #f2f2f2;
}
</style>
</head>
<body>

<div class="container">
  <div class="card">
    <div class="card-header">
      <h2>사원 목록</h2>
      <button class="add-btn" onclick="location.href='${pageContext.request.contextPath}/emp/addEmp'">+ 새 사원 등록</button>
    </div>

    <div class="card-body">
      <table class="table">
        <thead>
          <tr>
            <th>사원코드</th>
            <th>아이디</th>
            <th>이름</th>
            <th>상태</th>
            <th>등록일</th>
            <th>관리</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="emp" items="${empList}">
            <tr data-empid="${emp.empId}">
              <td>${emp.empCode}</td>
              <td>${emp.empId}</td>
              <td>${emp.empName}</td>
              <td>
                <button class="toggle-btn ${emp.active == 1 ? 'on' : 'off'}"
                        data-active="${emp.active}">
                  ${emp.active == 1 ? '활성' : '비활성'}
                </button>
              </td>
              <td class="small-muted">${emp.createdate}</td>
              <td>
                <button class="action-btn edit-btn"
                        onclick="location.href='${pageContext.request.contextPath}/emp/updateEmp?empId=${emp.empId}'">
                  수정
                </button>
                <button class="action-btn delete-btn" data-empid="${emp.empId}">삭제</button>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>

      <!-- 페이징 -->
      <div class="pagination">
        <c:if test="${currentPage > 1}">
          <a class="page-btn" href="?currentPage=${currentPage - 1}">&laquo;</a>
        </c:if>

        <c:forEach var="i" begin="1" end="${lastPage}">
          <a class="page-btn ${i == currentPage ? 'active' : ''}" href="?currentPage=${i}">
            ${i}
          </a>
        </c:forEach>

        <c:if test="${currentPage < lastPage}">
          <a class="page-btn" href="?currentPage=${currentPage + 1}">&raquo;</a>
        </c:if>
      </div>
    </div>
  </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", () => {
  initToggle();
  initDelete();
});

// 활성/비활성 토글 기능
function initToggle() {
  document.querySelectorAll(".toggle-btn").forEach(btn => {
    btn.addEventListener("click", async () => {
      const tr = btn.closest("tr");
      const empId = tr.dataset.empid;
      const currentActive = parseInt(btn.dataset.active);
      const newActive = currentActive === 1 ? 0 : 1;

      const params = new URLSearchParams();
      params.append("empId", empId);
      params.append("active", newActive);

      const response = await fetch("${pageContext.request.contextPath}/emp/updateActive", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: params.toString(),
        cache: "no-store" // 🚫 캐시 방지
      });

      const result = await response.json();
      if (result.success) {
        btn.dataset.active = newActive;
        btn.textContent = newActive === 1 ? "활성" : "비활성";
        btn.classList.toggle("on", newActive === 1);
        btn.classList.toggle("off", newActive === 0);
      } else {
        alert("상태 변경 실패: " + (result.message || "서버 오류"));
      }
    });
  });
}

// ✅ 삭제 기능 (파라미터 누적 방지 + 안전 인코딩)
function initDelete() {
  document.querySelectorAll(".delete-btn").forEach(btn => {
    btn.addEventListener("click", async () => {
      const empId = btn.dataset.empid;
      if (!confirm(empId + " 사원을 삭제하시겠습니까?")) return;

      const params = new URLSearchParams();
      params.append("empId", empId);

      const response = await fetch("${pageContext.request.contextPath}/emp/deleteEmp", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: params.toString(),
        cache: "no-store"
      });

      const result = await response.json();
      if (result.success) {
        alert("삭제 완료!");
        btn.closest("tr").remove();
      } else {
        alert("삭제 실패: " + (result.message || "서버 오류"));
      }
    });
  });
}
</script>

</body>
</html>
