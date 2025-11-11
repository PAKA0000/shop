<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GDJ95 SHOP - 메인</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<style>
body {
  margin: 0;
  padding: 0;
  font-family: "Noto Sans KR", "Apple SD Gothic Neo", sans-serif;
  background-color: #f5f5f5;
  color: #333;
}

/* 상단 영역 */
header {
  background-color: #2db400;
  color: white;
  text-align: center;
  padding: 20px 0;
  font-size: 24px;
  font-weight: 700;
}

/* 상단 메뉴 */
nav {
  background-color: #fff;
  box-shadow: 0 2px 6px rgba(0,0,0,0.1);
  padding: 12px 20px;
}

/* 로그인 정보 */
.user-info {
  text-align: right;
  padding: 20px 40px;
  font-size: 15px;
  color: #444;
}
.user-info a {
  color: #2db400;
  text-decoration: none;
  font-weight: 600;
  margin-left: 10px;
}
.user-info a:hover {
  text-decoration: underline;
}

/* 섹션 제목 */
h2 {
  margin: 30px 0 15px 40px;
  font-size: 22px;
  color: #222;
  border-left: 5px solid #2db400;
  padding-left: 10px;
}

/* 베스트 상품 캐러셀 */
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
  min-width: 50%; /* 한 화면에 2개씩 */
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
  color: #2db400;
  font-weight: 700;
}

/* 좌우 버튼 */
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

/* 상품 목록 테이블 */
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
  color: #2db400;
  font-weight: 700;
  margin-top: 4px;
}

/* 페이징 */
.pagination {
  text-align: center;
  margin: 40px 0;
}
.pagination a, .pagination span {
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
  background-color: #2db400;
  color: #fff;
}
.pagination .active {
  background-color: #2db400;
  color: #fff;
  font-weight: bold;
}

/* 반응형 */
@media (max-width: 768px) {
  .carousel-item {
    min-width: 100%;
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

  function startAutoSlide(){
    autoSlide = setInterval(nextSlide, 3000);
  }
  function stopAutoSlide(){
    clearInterval(autoSlide);
  }

  $(".carousel").hover(stopAutoSlide, startAutoSlide);
  startAutoSlide();
});
</script>
</head>

<body>

<header>GDJ95 SHOP</header>

<nav>
  <c:import url="/WEB-INF/view/inc/customerMenu.jsp"></c:import>
</nav>

<div class="user-info">
  ${loginCustomer.customerName}님 반갑습니다.
  (point: ${loginCustomer.point})
  <a href="${pageContext.request.contextPath}/customer/customerLogout">로그아웃</a>
</div>

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

<!-- ✅ 페이징 -->
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
</html>
