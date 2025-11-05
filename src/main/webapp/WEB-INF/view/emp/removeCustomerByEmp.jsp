<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>탈퇴 회원 목록</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">

    <style>
        /* 🔹 기본 설정 */
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
            content: '🟢';
            font-size: 18px;
        }

        /* 🔹 카드 레이아웃 */
        .container {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 14px rgba(0, 0, 0, 0.08);
            max-width: 900px;
            margin: 0 auto;
            padding: 30px;
        }

        /* 🔹 테이블 */
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

        .empty {
            text-align: center;
            color: #999;
            padding: 20px;
        }

        /* 🔹 검색창 */
        .search-box {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 12px;
        }

        .search-box input {
            border: 1px solid #ccc;
            border-radius: 8px;
            padding: 8px 10px;
            font-size: 14px;
            width: 200px;
        }

        /* 🔹 버튼 */
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
            body {
                padding: 20px;
            }
            .container {
                padding: 20px;
            }
            th, td {
                font-size: 13px;
                padding: 8px;
            }
        }
    </style>
</head>

<body>
<div class="container">
    <h2>탈퇴 회원 관리</h2>

    <div class="search-box">
        <input type="text" id="searchBox" placeholder="아이디 또는 사유 검색">
    </div>

    <table>
        <thead>
        <tr>
            <th>아이디</th>
            <th>탈퇴 사유</th>
            <th>탈퇴 일자</th>
        </tr>
        </thead>
        <tbody id="outidTable">
        <c:forEach var="o" items="${outidList}">
            <tr>
                <td>${o.id}</td>
                <td>${o.memo}</td>
                <td>${o.createdate}</td>
            </tr>
        </c:forEach>

        <c:if test="${empty outidList}">
            <tr>
                <td colspan="3" class="empty">탈퇴한 회원이 없습니다.</td>
            </tr>
        </c:if>
        </tbody>
    </table>

    <a href="${pageContext.request.contextPath}/emp/customerList" class="btn">← 고객관리로 돌아가기</a>
</div>

<script>
    const searchBox = document.getElementById('searchBox');
    const rows = document.querySelectorAll('#outidTable tr');

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
