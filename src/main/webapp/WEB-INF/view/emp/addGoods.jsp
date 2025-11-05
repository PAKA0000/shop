<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>add Goods</h1>
	<c:import url="/WEB-INF/view/inc/empMenu.jsp"></c:import>
	<hr>
	
	<form enctype="multipart/form-data" action="${pageContext.request.contextPath}/emp/addGoods"method="post">
		<table border="1">
			<tr>
				<td>goodName</td>
				<td><input type="number" name="goodName"></td>
			</tr>
			<tr>
				<td>goodsPrice</td>
				<td><input type="number" name="goodsPrice"></td>
			</tr>
			<tr>
				<td>pointRate</td>
				<td><input type="number" name="pointRate"></td>
			</tr>
			<tr>
				<td>goodsImg(png/jpg.gif 확정자)</td>
				<td><input type="file" name="goodsImg"></td>
			</tr>
		</table>
		<button type="submit">상품등록</button>
	</form>
</body>
</html>