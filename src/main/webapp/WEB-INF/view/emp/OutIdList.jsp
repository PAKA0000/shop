<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>탈퇴 회원 목록</title>
</head>
<body>
<h2>탈퇴 회원 목록</h2>

<table border="1" cellpadding="5" cellspacing="0">
    <tr>
        <th>아이디</th>
        <th>탈퇴 사유</th>
        <th>탈퇴일</th>
    </tr>
    <c:forEach var="o" items="${outidList}">
        <tr>
            <td>${o.id}</td>
            <td>${o.memo}</td>
            <td>${o.createdate}</td>
        </tr>
    </c:forEach>
</table>

<br>
<a href="${pageContext.request.contextPath}/emp/customerList">← 고객 목록으로 돌아가기</a>
</body>
</html>
