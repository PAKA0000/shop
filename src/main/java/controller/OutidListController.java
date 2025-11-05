package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import dao.OutidDao;
import dto.Outid;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/emp/OutidList")
public class OutidListController extends HttpServlet {
    private OutidDao outidDao = new OutidDao();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Outid> outidList = outidDao.selectOutidList();
            request.setAttribute("outidList", outidList);
            request.getRequestDispatcher("/WEB-INF/view/emp/OutidList.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/emp/empIndex");
        }
    }
}
