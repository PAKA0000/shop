<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>배송지 관리 | N-Shop</title>
<style>
body { font-family: 'Noto Sans KR', sans-serif; background:#f8f9fa; margin:0; padding:0; }
.container { width:900px; margin:40px auto; background:#fff; padding:40px; border-radius:15px; box-shadow:0 4px 12px rgba(0,0,0,0.08);}
h1 { text-align:center; color:#03c75a; margin-bottom:25px; }

.card { background: #fff; border-radius: 15px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); padding: 20px; margin-bottom:30px;}
.form-group { margin-bottom:15px;}
label { display:block; font-weight:600; margin-bottom:5px; color:#333;}
input[type="text"] { width:100%; padding:10px; border:1px solid #ccc; border-radius:6px; box-sizing:border-box;}
input:focus { outline:none; border-color:#03c75a;}
button { background-color:#03c75a; color:#fff; border:none; border-radius:6px; padding:10px 15px; cursor:pointer; }
button:hover { background-color:#02b350;}
.table { width:100%; border-collapse:collapse; margin-top:20px;}
.table th, .table td { padding:12px 10px; border-bottom:1px solid #eee; text-align:left;}
.table th { background:#fafafa; font-weight:600; color:#444;}
.table tr:hover { background:#f9f9f9;}
.btn-gray { background:#e9ecef; color:#333; border:none; padding:5px 10px; border-radius:5px; cursor:pointer;}
.btn-gray:hover { background:#dee2e6;}
.no-data { text-align:center; color:#777; padding:20px 0;}
</style>
</head>
<body>
<div class="container">
<h1>배송지 관리</h1>

<!-- 배송지 추가 폼 -->
<div class="card">
<h2>새 배송지 추가</h2>
<form method="post" action="${pageContext.request.contextPath}/customer/addAddress">
    <div class="form-group">
        <label>우편번호</label>
        <input type="text" name="postcode" id="sample4_postcode" readonly required>
        <input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기">
    </div>
    <div class="form-group">
        <label>도로명 주소</label>
        <input type="text" name="roadAddress" id="sample4_roadAddress" readonly required>
    </div>
    <div class="form-group">
        <label>지번 주소</label>
        <input type="text" name="jibunAddress" id="sample4_jibunAddress" readonly required>
    </div>
    <div class="form-group">
        <label>상세주소</label>
        <input type="text" name="detailAddress" required>
    </div>
    <div class="form-group">
        <label>참고사항</label>
        <input type="text" name="extraAddress">
    </div>
    <button type="submit">추가</button>
</form>
</div>

<!-- 배송지 목록 -->
<table class="table">
<thead>
<tr>
<th>주소</th>
<th>등록일</th>
<th>관리</th>
</tr>
</thead>
<tbody>
<c:choose>
    <c:when test="${empty addressList}">
        <tr><td colspan="3" class="no-data">등록된 배송지가 없습니다.</td></tr>
    </c:when>
    <c:otherwise>
        <c:forEach var="a" items="${addressList}">
        <tr>
            <td>${a.address}</td>
            <td>${a.createdate}</td>
            <td>
                <form method="post" action="${pageContext.request.contextPath}/customer/deleteAddress" style="display:inline;">
                    <input type="hidden" name="addressCode" value="${a.addressCode}">
                    <button type="submit" class="btn-gray">삭제</button>
                </form>
            </td>
        </tr>
        </c:forEach>
    </c:otherwise>
</c:choose>
</tbody>
</table>
<div style="text-align:center; color:#666; margin-top:20px;">
배송지는 최대 <strong>5개</strong>까지 등록 가능하며, 6번째 입력 시 가장 오래된 배송지가 자동 삭제됩니다.
</div>
</div>

<!-- 다음 주소 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function sample4_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            let roadAddr = data.roadAddress;
            let extraRoadAddr = '';
            if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) extraRoadAddr += data.bname;
            if (data.buildingName !== '' && data.apartment === 'Y') extraRoadAddr += (extraRoadAddr ? ', ' + data.buildingName : data.buildingName);
            if (extraRoadAddr) extraRoadAddr = ' (' + extraRoadAddr + ')';
            document.getElementById('sample4_postcode').value = data.zonecode;
            document.getElementById('sample4_roadAddress').value = roadAddr;
            document.getElementById('sample4_jibunAddress').value = data.jibunAddress;
            document.getElementById('sample4_extraAddress').value = extraRoadAddr;
        }
    }).open();
}
</script>
</body>
</html>
