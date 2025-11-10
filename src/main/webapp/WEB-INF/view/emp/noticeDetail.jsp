<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지 상세</title>
<style>
body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f8f9fa;
    margin: 0;
    padding: 20px;
}

.container {
    width: 700px;
    margin: 50px auto;
    background: white;
    padding: 30px;
    border-radius: 12px;
    box-shadow: 0 6px 18px rgba(0,0,0,0.08);
}

h2 {
    text-align: center;
    color: #03c75a;
    margin-bottom: 25px;
}

.detail {
    margin-top: 20px;
}

.detail p {
    margin: 10px 0;
    font-size: 15px;
    color: #333;
    line-height: 1.5;
}

.detail .label {
    font-weight: 600;
    color: #555;
}

.back-link {
    display: block;
    text-align: center;
    margin-top: 25px;
    color: #03c75a;
    text-decoration: none;
    font-weight: 500;
}

.back-link:hover {
    text-decoration: underline;
}
</style>
</head>
<body>

<div class="container">
    <h2>공지사항 상세</h2>

    <div class="detail">
        <p><span class="label">번호:</span> ${notice.noticeCode}</p>
        <p><span class="label">제목:</span> ${notice.noticeTitle}</p>
        <p><span class="label">작성자:</span> ${notice.empCode}</p>
        <p><span class="label">등록일:</span> ${notice.createdate}</p>
        <p><span class="label">내용:</span><br>${notice.noticeContent}</p>
    </div>

    <a class="back-link" href="${pageContext.request.contextPath}/emp/noticeList">← 공지 리스트로 돌아가기</a>
</div>

</body>
</html>
