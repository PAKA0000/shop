package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import dao.EmpDao;
import dto.Emp;

@WebServlet("/emp/empList")
public class EmpListController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int currentPage = 1;
        if (request.getParameter("currentPage") != null) {
            currentPage = Integer.parseInt(request.getParameter("currentPage"));
        }

        int rowPerPage = 10;
        int beginRow = (currentPage - 1) * rowPerPage;

        EmpDao empDao = new EmpDao();
        List<Emp> empList = null;
        int totalCount = 0;
        int lastPage = 0;

        try {
            empList = empDao.selectEmpListByPage(beginRow, rowPerPage);
            totalCount = empDao.selectEmpCount(); //전체직원수
            lastPage = (int) Math.ceil((double) totalCount / rowPerPage);
        } catch (SQLException e) {
            e.printStackTrace();
        }

       
        request.setAttribute("empList", empList);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("lastPage", lastPage);

        request.getRequestDispatcher("/WEB-INF/view/emp/empList.jsp")
               .forward(request, response);
    }
}
