package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import dao.CustomerDao;
import dto.Customer;

@WebServlet("/emp/customerList")
public class CustomerListController extends HttpServlet {
    private CustomerDao customerDao = new CustomerDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1️ 페이징번호
        int currentPage = 1;
        if (request.getParameter("page") != null) {
            currentPage = Integer.parseInt(request.getParameter("page"));
        }

        // 2. 페이지네이션 계산
        int rowPerPage = 10;
        int beginRow = (currentPage - 1) * rowPerPage;

        // 3️. DAO 호출 → 고객 리스트 가져오기
        List<Customer> customerList = null;
        try {
            customerList = customerDao.selectCustomerList(beginRow, rowPerPage);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("고객 목록 조회 중 오류 발생", e);
        }

        // 4️.페이징
        request.setAttribute("customerList", customerList);
        request.setAttribute("currentPage", currentPage);

        request.getRequestDispatcher("/WEB-INF/view/emp/customerList.jsp").forward(request, response);
    }
}
