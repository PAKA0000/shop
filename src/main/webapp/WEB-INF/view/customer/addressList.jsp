<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>배송지 관리 | GDJ95 SHOP</title>

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<!-- ==============================
     CSS 스타일
============================== -->
<style>
/* ==============================
   기본 스타일
============================== */
body {
  font-family: 'Noto Sans KR', sans-serif;
  background-color: #f8f9fa;
  margin: 0;
  padding: 0;
}

/* ==============================
   컨테이너 및 제목
============================== */
.container {
  width: 900px;
  margin: 40px auto;
  background: #fff;
  padding: 40px;
  border-radius: 15px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
}

h1 {
  text-align: center;
  color: #03c75a;
  margin-bottom: 25px;
}

/* ==============================
   메뉴 버튼
============================== */
.menu {
  text-align: center;
  margin-bottom: 20px;
}

.menu button {
  color: #fff;
  background: #03c75a;
  border: none;
  padding: 8px 16px;
  border-radius: 6px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s;
}

.menu button:hover {
  background: #02b350;
}

/* ==============================
   테이블 스타일
============================== */
.table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 20px;
}

.table th,
.table td {
  padding: 12px 10px;
  border-bottom: 1px solid #eee;
  text-align: left;
}

.table th {
  background: #fafafa;
  font-weight: 600;
  color: #444;
}

.table tr:hover {
  background: #f9f9f9;
}

/* ==============================
   버튼 스타일
============================== */
.btn {
  padding: 6px 12px;
  font-size: 13px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  transition: all 0.2s;
}

.btn-gray {
  background: #e9ecef;
  color: #333;
}

.btn-gray:hover {
  background: #dee2e6;
}

/* ==============================
   안내 문구
============================== */
.no-data {
  text-align: center;
  color: #777;
  padding: 30px 0;
}

.note {
  text-align: center;
  font-size: 13px;
  color: #666;
  margin-top: 20px;
}

/* ==============================
   모달 (배송지 추가창)
============================== */
.modal {
  display: none;
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.4);
  justify-content: center;
  align-items: center;
}

.modal-content {
  background: #fff;
  padding: 30px;
  border-radius: 10px;
  width: 480px;
  position: relative;
}

.modal-content h2 {
  text-align: center;
  color: #03c75a;
  margin-bottom: 20px;
}

.close {
  position: absolute;
  top: 10px;
  right: 10px;
  cursor: pointer;
  font-weight: bold;
  font-size: 18px;
  color: #999;
}

/* ==============================
   입력 폼 스타일
============================== */
input[type="text"] {
  width: 100%;
  padding: 10px;
  margin-bottom: 10px;
  border: 1px solid #ccc;
  border-radius: 5px;
}

input:focus {
  outline: none;
  border-color: #03c75a;
}

/* ==============================
   제출 버튼
============================== */
button.submit-btn {
  width: 100%;
  background: #03c75a;
  color: #fff;
  padding: 12px;
  font-weight: 600;
  border-radius: 6px;
  border: none;
  cursor: pointer;
  transition: all 0.2s;
}

button.submit-btn:hover {
  background: #02b350;
}
</style>
</head>

<body>
<div class="container">
  <h1>배송지 관리</h1>

  <!-- 메뉴 include -->
  <c:import url="/WEB-INF/view/inc/customerMenu.jsp"></c:import>
  <hr>

  <!-- 상단 메뉴 -->
  <div class="menu">
    <button id="openModalBtn">＋ 새 배송지 추가</button>
  </div>

  <!-- 배송지 목록 테이블 -->
  <table class="table">
    <thead>
      <tr>
        <th>주소</th>
        <th>등록일</th>
        <th>관리</th>
      </tr>
    </thead>
    <tbody id="addressTableBody">
      <c:choose>
        <c:when test="${empty addressList}">
          <tr>
            <td colspan="3" class="no-data">등록된 배송지가 없습니다.</td>
          </tr>
        </c:when>
        <c:otherwise>
          <c:forEach var="a" items="${addressList}">
            <tr data-code="${a.addressCode}">
              <td>${a.address}</td>
              <td>${a.createdate}</td>
              <td>
                <button class="btn btn-gray delete-btn" data-code="${a.addressCode}">삭제</button>
              </td>
            </tr>
          </c:forEach>
        </c:otherwise>
      </c:choose>
    </tbody>
  </table>

  <div class="note">
    배송지는 최대 <strong>5개</strong>까지 등록 가능하며,<br>
    6번째 입력 시 가장 오래된 배송지가 자동 삭제됩니다.
  </div>
</div>

<!-- ==============================
     모달
============================== -->
<div class="modal" id="addModal">
  <div class="modal-content">
    <span class="close" id="closeModal">&times;</span>
    <h2>배송지 추가</h2>

    <input type="text" id="postcode" placeholder="우편번호" readonly>
    <input type="text" id="roadAddress" placeholder="도로명 주소" readonly>
    <input type="text" id="jibunAddress" placeholder="지번 주소" readonly>
    <input type="text" id="detailAddress" placeholder="상세 주소">
    <input type="text" id="extraAddress" placeholder="요청사항">

    <button class="submit-btn" id="addAddressBtn">추가</button>
  </div>
</div>

<!-- 다음 주소 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<!-- ==============================
     JavaScript
============================== -->
<script>
// 모달 열기/닫기
$('#openModalBtn').click(function() {
  $('#addModal').css('display', 'flex');
});
$('#closeModal').click(function() {
  $('#addModal').hide();
});

// 주소 검색 API
$('#postcode, #roadAddress, #jibunAddress').click(sample4_execDaumPostcode);
function sample4_execDaumPostcode() {
  new daum.Postcode({
    oncomplete: function(data) {
      $('#postcode').val(data.zonecode);
      $('#roadAddress').val(data.roadAddress);
      $('#jibunAddress').val(data.jibunAddress);

      let extra = '';
      if (data.bname && /[동|로|가]$/g.test(data.bname)) extra += data.bname;
      if (data.buildingName && data.apartment === 'Y') extra += (extra ? ', ' + data.buildingName : data.buildingName);
      if (extra) extra = '(' + extra + ')';
      $('#extraAddress').val(extra);
    }
  }).open();
}

// 배송지 추가 AJAX
$('#addAddressBtn').click(function() {
  const data = {
    postcode: $('#postcode').val(),
    roadAddress: $('#roadAddress').val(),
    jibunAddress: $('#jibunAddress').val(),
    detailAddress: $('#detailAddress').val(),
    extraAddress: $('#extraAddress').val()
  };

  if (!data.detailAddress) {
    alert('상세주소를 입력하세요.');
    return;
  }

  $.post('${pageContext.request.contextPath}/customer/addAddress', data, function(resp) {
    location.reload(); // 추가 후 새로고침
  });
});

// 배송지 삭제 AJAX
$('.delete-btn').click(function() {
  const code = $(this).data('code');
  if (confirm('정말 삭제하시겠습니까?')) {
    $.post('${pageContext.request.contextPath}/customer/deleteAddress', { addressCode: code }, function() {
      $('tr[data-code="' + code + '"]').remove();
    });
  }
});
</script>
</body>
</html>
