<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 추가</title>
<style>
body { font-family: 'Noto Sans KR', sans-serif; background: #f8f9fa; padding: 20px; }
h1 { color: #03c75a; text-align: center; margin-top: 30px; }
form { width: 60%; margin: 30px auto; background: white; padding: 20px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.08); }
form input[type=text], form textarea { width: 100%; padding: 10px; margin-bottom: 15px; border-radius: 8px; border: 1px solid #ccc; }
form button { background-color: #03c75a; color: white; border: none; padding: 12px 20px; border-radius: 25px; cursor: pointer; font-size: 16px; width: 100%; }
form button:hover { background-color: #02b150; }
.menu a { display: inline-block; margin: 10px 5px; padding: 6px 12px; background-color: #e6f9f0; border-radius: 20px; text-decoration: none; color: #03c75a; }
.menu a:hover { background-color: #03c75a; color: white; }
</style>
</head>
<body>
<h1>공지사항 추가</h1>

<form action="${pageContext.request.contextPath}/emp/addNotice" method="post">
    <input type="hidden" name="empCode" value="EMP001"> 
    <label>제목</label>
    <input type="text" name="noticeTitle" required>
    <label>내용</label>
    <textarea name="noticeContent" rows="10" required></textarea>
    <button type="submit">등록</button>
</form>

<div class="menu" style="text-align:center;">
    <a href="${pageContext.request.contextPath}/emp/noticeList">목록으로</a>
</div>

</body>
</html>
