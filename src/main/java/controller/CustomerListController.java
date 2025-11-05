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
        List<Customer> customerList = customerDao.selectCustomerList();
		request.setAttribute("customerList", customerList);
		request.getRequestDispatcher("/WEB-INF/view/emp/customerList.jsp")
		       .forward(request, response);
    }
}
