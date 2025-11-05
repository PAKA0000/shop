<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>고객 리스트</title>
</head>
<body>
<h2>고객 리스트</h2>

<table border="1" cellspacing="0" cellpadding="5">
    <tr>
        <th>고객코드</th>
        <th>아이디</th>
        <th>이름</th>
        <th>전화번호</th>
        <th>포인트</th>
        <th>가입일</th>
        <th>관리</th>
    </tr>

    <c:forEach var="c" items="${customerList}">
        <tr>
            <td>${c.customerCode}</td>
            <td>${c.customerId}</td>
            <td>${c.customerName}</td>
            <td>${c.customerPhone}</td>
            <td>${c.point}</td>
            <td>${c.createdate}</td>
            <td>
					<form
						action="${pageContext.request.contextPath}/emp/RemoveCustomerByEmp"
						method="post"
						onsubmit="return confirm('정말로 ${c.customerId} 회원을 탈퇴시키겠습니까?');">
						<input type="hidden" name="customerId" value="${c.customerId}">
						<input type="text" name="memo" placeholder="탈퇴 사유" required>
						<button type="submit">탈퇴</button>
					</form>

				</td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
