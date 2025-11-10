<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지 수정</title>
<style>
body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f8f9fa;
    margin: 0;
    padding: 20px;
}

.container {
    width: 600px;
    margin: 50px auto;
    background: white;
    padding: 30px;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

h2 {
    text-align: center;
    color: #03c75a;
    margin-bottom: 25px;
}

form label {
    display: block;
    margin: 15px 0 5px;
    font-weight: 600;
}

form input[type="text"], form textarea {
    width: 100%;
    padding: 10px;
    border-radius: 6px;
    border: 1px solid #ccc;
    box-sizing: border-box;
    font-size: 14px;
}

form textarea {
    height: 150px;
    resize: vertical;
}

button {
    margin-top: 20px;
    width: 100%;
    padding: 12px;
    border: none;
    border-radius: 6px;
    background-color: #03c75a;
    color: white;
    font-size: 16px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.2s;
}

button:hover {
    background-color: #02b150;
}

.back-link {
    display: block;
    text-align: center;
    margin-top: 15px;
    color: #03c75a;
    text-decoration: none;
}

.back-link:hover {
    text-decoration: underline;
}
</style>
</head>
<body>

<div class="container">
    <h2>공지 수정</h2>

    <form method="post" action="${pageContext.request.contextPath}/emp/modifyNotice">
        <input type="hidden" name="noticeCode" value="${notice.noticeCode}">

        <label>제목</label>
        <input type="text" name="noticeTitle" value="${notice.noticeTitle}" required>

        <label>내용</label>
        <textarea name="noticeContent" required>${notice.noticeContent}</textarea>

        <button type="submit">수정 완료</button>
    </form>

    <a class="back-link" href="${pageContext.request.contextPath}/emp/noticeList">← 공지 리스트로 돌아가기</a>
</div>

</body>
</html>
