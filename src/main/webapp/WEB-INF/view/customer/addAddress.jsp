<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>배송지 추가 | N-Shop</title>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
body {
  font-family: 'Noto Sans KR', sans-serif;
  background-color: #f8f9fa;
  margin: 0;
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
}

.card {
  background: #fff;
  border-radius: 15px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.1);
  padding: 40px 50px;
  width: 500px;
}

h2 {
  color: #03c75a;
  text-align: center;
  margin-bottom: 25px;
  font-weight: 700;
}

.form-group {
  margin-bottom: 16px;
}

label {
  display: block;
  font-weight: 600;
  margin-bottom: 6px;
  color: #333;
}

input[type="text"] {
  width: 100%;
  padding: 10px 12px;
  border: 1px solid #ccc;
  border-radius: 8px;
  font-size: 14px;
  box-sizing: border-box;
  transition: border-color 0.2s;
}

input[type="text"]:focus {
  border-color: #03c75a;
  outline: none;
}

button, input[type="button"] {
  background-color: #03c75a;
  border: none;
  color: white;
  font-weight: 600;
  padding: 10px 16px;
  border-radius: 8px;
  cursor: pointer;
  transition: background-color 0.2s;
}

button:hover, input[type="button"]:hover {
  background-color: #02b350;
}

.actions {
  text-align: center;
  margin-top: 25px;
}

#guide {
  color: #999;
  font-size: 13px;
}
</style>
</head>

<body>
<div class="card">
  <h2>배송지 추가</h2>
  <form method="post" action="${pageContext.request.contextPath}/customer/addAddress">
    
    <div class="form-group">
      <label>우편번호</label>
      <div style="display: flex; gap: 8px;">
        <input type="text" id="sample4_postcode" name="postcode" placeholder="우편번호" readonly>
        <input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기">
      </div>
    </div>

    <div class="form-group">
      <label>도로명 주소</label>
      <input type="text" id="sample4_roadAddress" name="roadAddress" placeholder="도로명 주소" readonly>
    </div>

    <div class="form-group">
      <label>지번 주소</label>
      <input type="text" id="sample4_jibunAddress" name="jibunAddress" placeholder="지번 주소" readonly>
    </div>

    <div class="form-group">
      <label>상세 주소</label>
      <input type="text" id="sample4_detailAddress" name="detailAddress" placeholder="상세 주소를 입력하세요">
    </div>

    <div class="form-group">
      <label>참고 항목</label>
      <input type="text" id="sample4_extraAddress" name="extraAddress" placeholder="참고 항목" readonly>
      <span id="guide" style="display:none"></span>
    </div>

    <div class="actions">
      <button type="submit">배송지 등록</button>
    </div>

  </form>
</div>

<script>
function sample4_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            var roadAddr = data.roadAddress;
            var extraRoadAddr = '';

            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

            document.getElementById('sample4_postcode').value = data.zonecode;
            document.getElementById("sample4_roadAddress").value = roadAddr;
            document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
            document.getElementById("sample4_extraAddress").value = extraRoadAddr;

            var guideTextBox = document.getElementById("guide");
            if(data.autoRoadAddress) {
                guideTextBox.innerHTML = '(예상 도로명 주소 : ' + data.autoRoadAddress + extraRoadAddr + ')';
                guideTextBox.style.display = 'block';
            } else if(data.autoJibunAddress) {
                guideTextBox.innerHTML = '(예상 지번 주소 : ' + data.autoJibunAddress + ')';
                guideTextBox.style.display = 'block';
            } else {
                guideTextBox.innerHTML = '';
                guideTextBox.style.display = 'none';
            }
        }
    }).open();
}
</script>
</body>
</html>
