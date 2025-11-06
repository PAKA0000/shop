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
        int rowPerPage = 10;
        int beginRow = (currentPage - 1) * rowPerPage;

        goodsDao = new GoodsDao();
        List<Map<String, Object>> list = null;

        try {
            list = goodsDao.selectGoodsList(beginRow, rowPerPage);
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("list", list);
        request.setAttribute("currentPage", currentPage);
        request.getRequestDispatcher("/WEB-INF/view/emp/goodsList.jsp").forward(request, response);
    }
}
