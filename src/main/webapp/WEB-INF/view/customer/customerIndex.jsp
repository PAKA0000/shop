<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>GDJ95 SHOP - 메인</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<style>
/* ==============================
   기본 세팅
============================== */
body {
  margin: 0;
  padding: 0;
  font-family: "Noto Sans KR", "Apple SD Gothic Neo", sans-serif;
  background-color: #f5f5f5;
  color: #333;
}

/* ==============================
   상단 헤더
============================== */
header {
  background-color: #03c75a;
  color: white;
  text-align: center;
  padding: 18px 0;
  font-size: 24px;
  font-weight: 700;
  letter-spacing: 0.3px;
}

/* ==============================
   네비게이션 + 사용자정보
============================== */
nav {
  background-color: #fff;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  padding: 0 40px;
}

.navbar {
  max-width: 1200px;
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 14px 0;
}

/* 왼쪽: 로고 */
.navbar .logo {
  font-weight: 700;
  font-size: 20px;
  color: #03c75a;
  text-decoration: none;
  transition: opacity 0.2s ease;
}
.navbar .logo:hover {
  opacity: 0.8;
}

/* 가운데: 메뉴 */
.navbar .nav-links {
  display: flex;
  gap: 26px;
}
.navbar .nav-links a {
  color: #333;
  text-decoration: none;
  font-weight: 500;
  font-size: 15px;
  transition: color 0.2s ease, transform 0.1s ease;
}
.navbar .nav-links a:hover {
  color: #03c75a;
  transform: translateY(-1px);
}

/* 오른쪽: 사용자 정보 */
.navbar .user-info {
  display: flex;
  align-items: center;
  gap: 10px;
  font-size: 14px;
  color: #333;
}
.user-info .logout-btn {
  background-color: #03c75a;
  color: #fff;
  border: none;
  border-radius: 20px;
  padding: 6px 14px;
  font-size: 13px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.25s ease;
}
.user-info .logout-btn:hover {
  background-color: #02b350;
  transform: translateY(-1px);
}

/* ==============================
   섹션 제목
============================== */
h2 {
  margin: 40px 0 15px 60px;
  font-size: 22px;
  color: #222;
  border-left: 5px solid #03c75a;
  padding-left: 10px;
}

/* ==============================
   캐러셀
============================== */
.carousel {
  width: 90%;
  max-width: 900px;
  margin: 0 auto 40px auto;
  position: relative;
  overflow: hidden;
  background: #fff;
  border-radius: 10px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}
.carousel-track {
  display: flex;
  transition: transform 0.5s ease;
}
.carousel-item {
  min-width: 50%;
  box-sizing: border-box;
  padding: 20px;
  text-align: center;
}
.carousel-item img {
  width: 160px;
  height: 160px;
  object-fit: cover;
  border-radius: 8px;
  margin-bottom: 10px;
}
.carousel-item .name {
  font-weight: 600;
  margin-bottom: 5px;
}
.carousel-item .price {
  color: #03c75a;
  font-weight: 700;
}

/* 캐러셀 버튼 */
.carousel-btn {
  position: absolute;
  top: 45%;
  transform: translateY(-50%);
  background-color: rgba(0,0,0,0.3);
  color: #fff;
  border: none;
  border-radius: 50%;
  width: 40px;
  height: 40px;
  cursor: pointer;
  font-size: 20px;
  transition: all 0.2s;
}
.carousel-btn:hover {
  background-color: rgba(0,0,0,0.6);
}
.prev-btn { left: 10px; }
.next-btn { right: 10px; }

/* ==============================
   상품 목록
============================== */
table {
  width: 90%;
  margin: 0 auto 20px auto;
  border-collapse: separate;
  border-spacing: 20px;
}
td {
  background-color: #fff;
  border-radius: 10px;
  text-align: center;
  box-shadow: 0 4px 10px rgba(0,0,0,0.05);
  transition: transform 0.2s ease, box-shadow 0.2s ease;
  padding: 10px;
  vertical-align: top;
}
td:hover {
  transform: translateY(-4px);
  box-shadow: 0 6px 15px rgba(0,0,0,0.1);
}
td img {
  width: 160px;
  height: 160px;
  object-fit: cover;
  border-radius: 8px;
  margin-bottom: 10px;
}
td .price {
  font-size: 14px;
  color: #03c75a;
  font-weight: 700;
  margin-top: 4px;
}

/* ==============================
   페이징
============================== */
.pagination {
  text-align: center;
  margin: 40px 0;
}
.pagination a,
.pagination span {
  display: inline-block;
  margin: 0 5px;
  padding: 8px 12px;
  border-radius: 5px;
  background-color: #fff;
  border: 1px solid #ddd;
  color: #333;
  text-decoration: none;
  transition: all 0.2s;
}
.pagination a:hover {
  background-color: #03c75a;
  color: #fff;
}
.pagination .active {
  background-color: #03c75a;
  color: #fff;
  font-weight: bold;
}

/* ==============================
   반응형
============================== */
@media (max-width: 768px) {
  .navbar {
    flex-direction: column;
    gap: 10px;
    text-align: center;
  }
  .navbar .nav-links {
    flex-wrap: wrap;
    justify-content: center;
    gap: 12px;
  }
  td img {
    width: 120px;
    height: 120px;
  }
}
</style>

<script>
$(function(){
  const $track = $(".carousel-track");
  const $items = $(".carousel-item");
  const itemCount = $items.length;
  let index = 0;
  const visibleCount = 2;
  const moveWidth = 100 / visibleCount;
  let autoSlide;

  function moveSlide(n){
    index = (n + itemCount) % itemCount;
    $track.css("transform", "translateX(-" + (index * moveWidth) + "%)");
  }

  function nextSlide(){ moveSlide(index + visibleCount); }
  function prevSlide(){ moveSlide(index - visibleCount); }

  $(".next-btn").click(nextSlide);
  $(".prev-btn").click(prevSlide);

  function startAutoSlide(){ autoSlide = setInterval(nextSlide, 3000); }
  function stopAutoSlide(){ clearInterval(autoSlide); }

  $(".carousel").hover(stopAutoSlide, startAutoSlide);
  startAutoSlide();
});
</script>
</head>

<body>

<header>GDJ95 SHOP</header>

<nav>
  <div class="navbar">
    <!-- 로고 -->
    <a href="${pageContext.request.contextPath}/customer/customerIndex" class="logo">🛍 GDJ95 SHOP</a>

    <!-- 메뉴 -->
    <div class="nav-links">
      <a href="${pageContext.request.contextPath}/customer/customerIndex">상품목록</a>
      <a href="${pageContext.request.contextPath}/customer/customerInfo">개인정보</a>
      <a href="${pageContext.request.contextPath}/customer/addressList">배송지관리</a>
      <a href="${pageContext.request.contextPath}/customer/cartList">장바구니</a>
    </div>

    <!-- 사용자 정보 -->
    <div class="user-info">
      <span>${loginCustomer.customerName}님</span>
      <span style="opacity:0.8;">(point: ${loginCustomer.point})</span>
      <form action="${pageContext.request.contextPath}/customer/customerLogout" method="post" style="margin:0;">
        <button type="submit" class="logout-btn">로그아웃</button>
      </form>
    </div>
  </div>
</nav>

<h2>베스트 상품</h2>
<div class="carousel">
  <div class="carousel-track">
    <c:forEach var="b" items="${bestGoodsList}">
      <div class="carousel-item">
        <a href="${pageContext.request.contextPath}/customer/goodsOne?goodsCode=${b.goodsCode}">
          <img src="${pageContext.request.contextPath}/upload/${b.filename}" alt="${b.goodsName}">
        </a>
        <div class="name">${b.goodsName}</div>
        <div class="price"><fmt:formatNumber value="${b.goodsPrice}" type="number"/>원</div>
      </div>
    </c:forEach>
  </div>
  <button class="carousel-btn prev-btn">◀</button>
  <button class="carousel-btn next-btn">▶</button>
</div>

<h2>상품 목록</h2>
<div>
  <c:choose>
    <c:when test="${empty goodsList}">
      <p style="text-align:center; color:#777; margin:40px;">등록된 상품이 없습니다.</p>
    </c:when>
    <c:otherwise>
      <table>
        <tr>
          <c:forEach var="m" items="${goodsList}" varStatus="state">
            <td>
              <a href="${pageContext.request.contextPath}/customer/goodsOne?goodsCode=${m.goodsCode}">
                <img src="${pageContext.request.contextPath}/upload/${m.filename}" alt="${m.goodsName}">
              </a>
              <div>${m.goodsName}</div>
              <div class="price"><fmt:formatNumber value="${m.goodsPrice}" type="number"/>원</div>
            </td>
            <c:if test="${state.count % 5 == 0}">
              </tr><tr>
            </c:if>
          </c:forEach>
        </tr>
      </table>
    </c:otherwise>
  </c:choose>
</div>

<!-- 페이징 -->
<div class="pagination">
  <c:if test="${startPage > 1}">
    <a href="${pageContext.request.contextPath}/customer/customerIndex?currentPage=${startPage - 1}">◀ 이전</a>
  </c:if>

  <c:forEach var="i" begin="${startPage}" end="${endPage}">
    <c:choose>
      <c:when test="${i == currentPage}">
        <span class="active">${i}</span>
      </c:when>
      <c:otherwise>
        <a href="${pageContext.request.contextPath}/customer/customerIndex?currentPage=${i}">${i}</a>
      </c:otherwise>
    </c:choose>
  </c:forEach>

  <c:if test="${endPage < lastPage}">
    <a href="${pageContext.request.contextPath}/customer/customerIndex?currentPage=${endPage + 1}">다음 ▶</a>
  </c:if>
</div>

</body>
<
