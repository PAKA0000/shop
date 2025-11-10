package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.GoodsDao;

@WebServlet("/customer/customerIndex")
public class CustomerIndexController extends HttpServlet {
	private GoodsDao goodsDao;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// -----------------------
		// 1. 현재 페이지 구하기
		// -----------------------
		int currentPage = 1;
		if (request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		int rowPerPage = 20; // 페이지당 출력 상품 수
		int beginRow = (currentPage - 1) * rowPerPage;
		
		goodsDao = new GoodsDao();  
		
		try {
			// -----------------------
			// 2. 상품 목록 및 전체 개수
			// -----------------------
			request.setAttribute("goodsList", goodsDao.selectGoodsList(beginRow, rowPerPage));
			request.setAttribute("bestGoodsList", goodsDao.selectBestList(0, 5)); // 상단 베스트 5개
			
			int totalRow = goodsDao.selectGoodsCount(); // 전체 상품 수
			int lastPage = totalRow / rowPerPage;
			if (totalRow % rowPerPage != 0) {
				lastPage += 1;
			}
			
			// 페이지 네비게이션 범위 계산
			int pageBlock = 5; // 페이지 번호 몇 개씩 표시할지
			int startPage = ((currentPage - 1) / pageBlock) * pageBlock + 1;
			int endPage = startPage + pageBlock - 1;
			if (endPage > lastPage) {
				endPage = lastPage;
			}

			// -----------------------
			// 3. JSP로 데이터 전달
			// -----------------------
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("lastPage", lastPage);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("totalRow", totalRow);
			
		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(500);
			return;
		}
		
		request.getRequestDispatcher("/WEB-INF/view/customer/customerIndex.jsp").forward(request, response);
	}
}
