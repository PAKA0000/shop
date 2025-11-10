<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배송지 추가</title>
<style>
body { 
    font-family: 'Noto Sans KR', sans-serif; 
    background-color: #f8f9fa; 
    display: flex; 
    justify-content: center; 
    align-items: center; 
    height: 100vh; 
    margin: 0;
}
.card { 
    background: #fff; 
    border-radius: 15px; 
    box-shadow: 0 4px 12px rgba(0,0,0,0.1); 
    width: 480px; 
    padding: 30px; 
}
h2 { 
    text-align: center; 
    color: #03c75a; 
    margin-bottom: 25px; 
}
.form-group { 
    margin-bottom: 15px; 
}
label { 
    display: block; 
    font-weight: 600; 
    margin-bottom: 5px; 
    color: #333; 
}
input[type="text"] { 
    width: 100%; 
    padding: 10px; 
    border: 1px solid #ccc; 
    border-radius: 6px; 
    font-size: 14px; 
    box-sizing: border-box; 
}
input:focus { 
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
#findPostcodeBtn {
    margin-top: 6px;
    background-color: #2db400;
    color: #fff;
    border: none;
    border-radius: 4px;
    padding: 8px 10px;
    cursor: pointer;
    font-size: 13px;
}
#findPostcodeBtn:hover {
    background-color: #27a300;
}
</style>
</head>
<body>
<div class="card">
    <h2>배송지 추가</h2>

    <form method="post" action="${pageContext.request.contextPath}/customer/addAddress">
        <div class="form-group">
            <label>우편번호</label>
            <input type="text" name="postcode" id="sample4_postcode" placeholder="우편번호" readonly>
            <input type="button" id="findPostcodeBtn" onclick="sample4_execDaumPostcode()" value="우편번호 찾기">
        </div>

        <div class="form-group">
            <label>도로명 주소</label>
            <input type="text" name="roadAddress" id="sample4_roadAddress" placeholder="도로명 주소" readonly>
        </div>

        <div class="form-group">
            <label>지번 주소</label>
            <input type="text" name="jibunAddress" id="sample4_jibunAddress" placeholder="지번 주소" readonly>
        </div>

        <div class="form-group">
            <label>상세주소</label>
            <input type="text" name="detailAddress" id="sample4_detailAddress" placeholder="상세 주소를 입력하세요">
        </div>

        <div class="form-group">
            <label>참고항목</label>
            <input type="text" name="extraAddress" id="sample4_extraAddress" placeholder="참고항목" readonly>
        </div>

        <button type="submit">배송지 추가</button>
    </form>

    <a class="back-link" href="${pageContext.request.contextPath}/customer/addressList">← 배송지 목록으로 돌아가기</a>
</div>

<!-- 다음 주소 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function sample4_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            let roadAddr = data.roadAddress;
            let extraRoadAddr = '';

            if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                extraRoadAddr += data.bname;
            }
            if (data.buildingName !== '' && data.apartment === 'Y') {
                extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            if (extraRoadAddr !== '') {
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

            document.getElementById('sample4_postcode').value = data.zonecode;
            document.getElementById("sample4_roadAddress").value = roadAddr;
            document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
            document.getElementById("sample4_extraAddress").value = extraRoadAddr;
        }
    }).open();
}
</script>
</body>
</html>
