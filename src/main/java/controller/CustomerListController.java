package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import dao.CustomerDao;
import dto.Customer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/emp/customerList")
public class CustomerListController extends HttpServlet {
    private CustomerDao customerDao = new CustomerDao();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int currentPage = 1;
        if(request.getParameter("currentPage") != null) {
            currentPage = Integer.parseInt(request.getParameter("currentPage"));
        }

        int rowPerPage = 10;
        int beginRow = (currentPage - 1) * rowPerPage;

        List<Customer> customerList = null;
        int totalCount = 0;
        int lastPage = 0;

        try {
            customerList = customerDao.selectCustomerList(beginRow, rowPerPage);
            totalCount = customerDao.selectCustomerCount();
            lastPage = (int) Math.ceil((double) totalCount / rowPerPage);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // 페이지 블록 계산 (10개씩)
        int startPage = ((currentPage - 1) / 10) * 10 + 1;
        int endPage = startPage + 9;
        if(endPage > lastPage) endPage = lastPage;

        request.setAttribute("customerList", customerList);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("lastPage", lastPage);
        request.setAttribute("startPage", startPage);
        request.setAttribute("endPage", endPage);

        request.getRequestDispatcher("/WEB-INF/view/emp/customerList.jsp")
               .forward(request, response);
    }
}
