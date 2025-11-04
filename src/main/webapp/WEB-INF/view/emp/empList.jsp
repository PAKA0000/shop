<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>empList</h1>
	<c:import url="/WEB-INF/view/inc/empMenu.jsp"></c:import>

	<div>
		<!-- 
		1)리스트 
		2) 비(활성화)
		3) 추가
		 -->
		<a href="${PageContext.request.contextPath}/emp/addEmp">사원추가</a>
		<table>
			<tr>
				<td>empCode</td>
				<td>empId</td>
				<td>empName</td>
				<td>createdate</td>
				<td>활성화/비활성화</td>
			</tr>
			
			<c:forEach var="" items="${empList }">
			<tr>
					<td>${e.empCode }</td>
					<td>${e.empId }</td>
					<td>${e.empPw }</td>
					<td>${e.createdate}</td>
					<td>
						<a href="${PageContext.request.contextPath}/emp/modifyEmpActive?empCode=${e.empCode}&currentActive=${e.active}">
						 ${e.acticve == 0 ? '비활성화': '활성화'}
						</a>
					</td>
				</tr>
			</c:forEach>
		</table>
		<div>
		
		</div>
	</div>
</body>
</html>
