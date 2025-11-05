<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>탈퇴 회원 목록</title>

    <!-- ✅ Google Font: Noto Sans KR -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">

    <!-- ✅ 네이버 느낌 CSS -->
    <style>
        :root {
            --naver-green: #2DB400;
            --naver-dark:  #1f8b00;
            --muted:       #6b6b6b;
            --bg:          #f6f7f8;
            --card:        #ffffff;
            --radius:      10px;
            --max-width:   1100px;
            --gap:         16px;
        }

        * { box-sizing: border-box; }
        html, body { height: 100%; margin: 0; }
        body {
            font-family: "Noto Sans KR", "Malgun Gothic", Arial, sans-serif;
            background: var(--bg);
            color: #222;
            -webkit-font-smoothing: antialiased;
            padding: 32px 16px;
            display: flex;
            justify-content: center;
        }

        .page-wrap {
            width: 100%;
            max-width: var(--max-width);
        }

        .header {
            display: flex;
            align-items: center;
            gap: 16px;
            margin-bottom: 20px;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .logo {
            width: 44px;
            height: 44px;
            border-radius: 8px;
            background: linear-gradient(135deg, var(--naver-green), var(--naver-dark));
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
            font-weight: 700;
            font-size: 18px;
            box-shadow: 0 4px 12px rgba(45,180,0,0.15);
        }

        h1 {
            margin: 0;
            font-size: 20px;
            font-weight: 700;
            color: var(--naver-dark);
        }

        .toolbar {
            display: flex;
            gap: 12px;
            align-items: center;
            margin-left: auto;
        }

        .search {
            display: flex;
            align-items: center;
            gap: 8px;
            background: #f2f3f4;
            padding: 6px 10px;
            border-radius: 8px;
        }

        .search input {
            border: none;
            background: transparent;
            outline: none;
            font-size: 14px;
        }

        .btn {
            background: var(--naver-green);
            color: #fff;
            border: none;
            padding: 8px 14px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            box-shadow: 0 6px 12px rgba(45,180,0,0.12);
        }

        .btn.ghost {
            background: transparent;
            color: var(--naver-dark);
            border: 1px solid #e6e6e6;
            box-shadow: none;
        }

        .card {
            background: var(--card);
            border-radius: var(--radius);
            box-shadow: 0 6px 18px rgba(20,20,20,0.06);
            padding: 20px;
        }

        .table-wrap {
            overflow-x: auto;
        }

        table.naver-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 720px;
            font-size: 14px;
        }

        .naver-table thead th {
            text-align: left;
            padding: 12px 14px;
            background: linear-gradient(180deg,#fbfcfd,#f7f8f9);
            color: var(--muted);
            font-weight: 600;
            border-bottom: 1px solid #ececec;
        }

        .naver-table tbody td {
            padding: 12px 14px;
            border-bottom: 1px solid #f0f0f0;
        }

        .naver-table tbody tr:hover {
            background: #fbfffb;
        }

        .empty {
            text-align: center;
            color: var(--muted);
            padding: 18px 8px;
        }

        @media (max-width: 720px) {
            h1 { font-size: 18px; }
            .search { min-width: 140px; }
            .naver-table { font-size: 13px; }
            .btn { padding: 6px 10px; }
        }
    </style>
</head>

<body>
<div class="page-wrap">
    <div class="header">
        <div class="brand">
            <div class="logo">ID</div>
            <h1>탈퇴 회원 관리</h1>
        </div>
        <div class="toolbar">
            <div class="search">
                <input type="search" placeholder="아이디 또는 메모 검색" id="searchBox">
            </div>
            <button class="btn ghost"
                    onclick="location.href='${pageContext.request.contextPath}/emp/customerList'">
                고객관리
            </button>
        </div>
    </div>

    <div class="card">
        <div class="table-wrap">
            <table class="naver-table">
                <thead>
                <tr>
                    <th>아이디</th>
                    <th>메모</th>
                    <th>탈퇴일</th>
                </tr>
                </thead>
                <tbody id="outidTbody">
                <c:forEach var="o" items="${outidList}">
                    <tr>
                        <td>${o.id}</td>
                        <td>${o.memo}</td>
                        <td>${o.createdate}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <c:if test="${empty outidList}">
            <div class="empty">탈퇴한 회원이 없습니다.</div>
        </c:if>
    </div>
</div>

<script>
	//검색
    (function () {
        const box = document.getElementById('searchBox');
        const tbody = document.getElementById('outidTbody');
        if (!box || !tbody) return;
        box.addEventListener('input', function () {
            const q = this.value.trim().toLowerCase();
            Array.from(tbody.rows).forEach(row => {
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(q) ? '' : 'none';
            });
        });
    })();
</script>
</body>
</html>
