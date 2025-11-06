<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록 | 관리 페이지</title>

<style>
    /* 전체 레이아웃 */
    body {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: #f8f9fa;
        margin: 0;
        padding: 0;
    }

    h1 {
        color: #03c75a;
        text-align: center;
        margin-top: 40px;
        font-weight: 700;
    }

    hr {
        border: none;
        border-top: 2px solid #03c75a;
        width: 80%;
        margin: 20px auto;
    }

    /* 폼 박스 */
    form {
        background: white;
        max-width: 600px;
        margin: 40px auto;
        padding: 30px 40px;
        border-radius: 16px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.08);
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    td {
        padding: 14px 10px;
        vertical-align: middle;
        font-size: 15px;
        color: #333;
    }

    td:first-child {
        width: 35%;
        font-weight: bold;
        color: #555;
    }

    input[type="text"],
    input[type="number"],
    input[type="file"] {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 8px;
        transition: all 0.2s ease;
        font-size: 14px;
    }

    input[type="text"]:focus,
    input[type="number"]:focus,
    input[type="file"]:focus {
        border-color: #03c75a;
        outline: none;
        box-shadow: 0 0 5px rgba(3, 199, 90, 0.2);
    }

    /* 버튼 */
    button {
        background-color: #03c75a;
        color: white;
        font-size: 16px;
        font-weight: 600;
        border: none;
        border-radius: 25px;
        padding: 12px 20px;
        width: 100%;
        cursor: pointer;
        margin-top: 20px;
        transition: all 0.3s ease;
    }

    button:hover {
        background-color: #02b150;
        transform: translateY(-2px);
        box-shadow: 0 4px 10px rgba(3, 199, 90, 0.3);
    }

    /* 메뉴 포함 영역 스타일 (선택 사항) */
    .menu {
        text-align: center;
        margin-top: 15px;
    }

    .menu a {
        color: #03c75a;
        text-decoration: none;
        font-weight: 500;
        margin: 0 10px;
    }

    .menu a:hover {
        text-decoration: underline;
    }
</style>
</head>

<body>
    <h1>상품 등록</h1>
    <c:import url="/WEB-INF/view/inc/empMenu.jsp"></c:import>
    <hr>

    <form enctype="multipart/form-data" action="${pageContext.request.contextPath}/emp/addGoods" method="post">
        <table>
            <tr>
                <td>상품명</td>
                <td><input type="text" name="goodsName" required></td>
            </tr>
            <tr>
                <td>상품가격</td>
                <td><input type="number" name="goodsPrice" required></td>
            </tr>
            <tr>
                <td>포인트율</td>
                <td><input type="text" name="pointRate" placeholder="예: 0.05" required></td>
            </tr>
            <tr>
                <td>상품이미지<br>(png/jpg/gif)</td>
                <td><input type="file" name="goodsImg" accept="image/*" required></td>
            </tr>
        </table>
        <button type="submit">상품등록</button>
    </form>

    <div class="menu">
        <a href="${pageContext.request.contextPath}/emp/goodsList">← 상품목록으로 돌아가기</a>
    </div>
</body>
</html>
