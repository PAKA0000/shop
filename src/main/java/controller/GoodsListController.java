package controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import dao.GoodsDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/emp/goodsList")
public class GoodsListController extends HttpServlet {
    private GoodsDao goodsDao;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int currentPage = 1;
        if (request.getParameter("currentPage") != null) {
            currentPage = Integer.parseInt(request.getParameter("currentPage"));
        }

        int rowPerPage = 10;
        int beginRow = (currentPage - 1) * rowPerPage;

        goodsDao = new GoodsDao();
        List<Map<String, Object>> list = null;
        int totalCount = 0;
        int lastPage = 0;

        try {
            list = goodsDao.selectGoodsList(beginRow, rowPerPage);
            totalCount = goodsDao.selectGoodsCount(); // 전체 상품 수
            lastPage = (totalCount % rowPerPage == 0) ? (totalCount / rowPerPage) : (totalCount / rowPerPage) + 1;
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 블록 페이징 계산 (10페이지씩 블록)
        int blockSize = 10;
        int startPage = ((currentPage - 1) / blockSize) * blockSize + 1;
        int endPage = startPage + blockSize - 1;
        if (endPage > lastPage) endPage = lastPage;

        request.setAttribute("list", list);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("lastPage", lastPage);
        request.setAttribute("startPage", startPage);
        request.setAttribute("endPage", endPage);

        request.getRequestDispatcher("/WEB-INF/view/emp/goodsList.jsp").forward(request, response);
    }
}
