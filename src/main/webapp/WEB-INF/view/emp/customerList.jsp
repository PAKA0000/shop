<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>고객 리스트</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f6f7f8;
            margin: 0;
            padding: 40px;
            color: #333;
        }

        h2 {
            color: #1f8b00;
            font-weight: 700;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        h2::before {
            content: '👥';
            font-size: 18px;
        }

        .container {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 14px rgba(0, 0, 0, 0.08);
            max-width: 1100px;
            margin: 0 auto;
            padding: 30px;
        }

        .search-box {
            display: flex;
            justify-content: space-between;
            margin-bottom: 12px;
        }

        .search-box input {
            border: 1px solid #ccc;
            border-radius: 8px;
            padding: 8px 10px;
            font-size: 14px;
            width: 200px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            font-size: 14px;
        }

        th, td {
            padding: 12px 14px;
            border-bottom: 1px solid #e6e6e6;
            text-align: left;
        }

        th {
            background-color: #f9fafb;
            color: #666;
            font-weight: 600;
        }

        tr:hover {
            background-color: #f9fff9;
        }

        form {
            display: flex;
            gap: 8px;
            align-items: center;
        }

        input[type="text"] {
            border: 1px solid #ccc;
            border-radius: 6px;
            padding: 5px 8px;
            font-size: 13px;
        }

        button {
            background-color: #2DB400;
            color: #fff;
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 13px;
            font-weight: 600;
            transition: 0.2s;
        }

        button:hover {
            background-color: #1f8b00;
        }

        .btn {
            display: inline-block;
            padding: 10px 18px;
            background-color: #2DB400;
            color: #fff;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            margin-top: 20px;
            transition: 0.2s;
        }

        .btn:hover {
            background-color: #1f8b00;
        }

        @media (max-width: 600px) {
            body { padding: 20px; }
            .container { padding: 20px; }
            th, td { font-size: 13px; padding: 8px; }
            form { flex-direction: column; gap: 4px; }
        }
    </style>
</head>

<body>
<div class="container">
    <h2>고객 리스트</h2>

    <div class="search-box">
        <input type="text" id="searchBox" placeholder="이름 또는 아이디 검색">
        <!-- ✅ 경로 수정: OutIdList → OutidList -->
        <a href="${pageContext.request.contextPath}/emp/OutidList" class="btn">탈퇴 회원 목록 보기</a>
    </div>

    <table>
        <thead>
        <tr>
            <th>고객코드</th>
            <th>아이디</th>
            <th>이름</th>
            <th>전화번호</th>
            <th>포인트</th>
            <th>가입일</th>
            <th>관리</th>
        </tr>
        </thead>

        <tbody id="customerTable">
        <c:forEach var="c" items="${customerList}">
            <tr>
            
                <td>${c.customerCode}</td>
                <td>${c.customerId}</td>
                <td>${c.customerName}</td>
                <td>${c.customerPhone}</td>
                <td>${c.point}</td>
                <td>${c.createdate}</td>
                <td>
                    <form action="${pageContext.request.contextPath}/emp/RemoveCustomerByEmp"
                          method="post"
                          onsubmit="return confirm('정말로 ${c.customerId} 회원을 탈퇴시키겠습니까?');">
                        <input type="hidden" name="customerId" value="${c.customerId}">
                        <input type="text" name="memo" placeholder="탈퇴 사유" required>
                        <button type="submit">탈퇴</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<!-- 🔍 검색 기능 -->
<script>
    const searchBox = document.getElementById('searchBox');
    const rows = document.querySelectorAll('#customerTable tr');

    searchBox.addEventListener('input', () => {
        const keyword = searchBox.value.toLowerCase();
        rows.forEach(row => {
            const text = row.textContent.toLowerCase();
            row.style.display = text.includes(keyword) ? '' : 'none';
        });
    });
</script>

</body>
</html>
