<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>탈퇴 회원 목록</title>
</head>
<body>
    <h2>탈퇴 회원 관리</h2>

    <table border="1" cellpadding="5">
        <tr>
            <th>아이디</th>
            <th>탈퇴사유</th>
            <th>탈퇴일자</th>
        </tr>
        <c:forEach var="o" items="${outidList}">
            <tr>
                <td>${o.id}</td>
                <td>${o.memo}</td>
                <td>${o.createdate}</td>
            </tr>
        </c:forEach>
        <c:if test="${empty outidList}">
            <tr><td colspan="3">탈퇴한 회원이 없습니다.</td></tr>
        </c:if>
    </table>

    <br>
    <a href="${pageContext.request.contextPath}/emp/customerList">[고객관리로 돌아가기]</a>
</body>
</html>
