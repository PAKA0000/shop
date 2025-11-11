package controller;

import java.io.IOException;
import dao.CustomerDao;
import dto.Customer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/customer/customerInfo")
public class CustomerInfoController extends HttpServlet {
    private CustomerDao customerDao = new CustomerDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer loginCustomer = (Customer) session.getAttribute("loginCustomer");

        if (loginCustomer == null) {
            response.sendRedirect(request.getContextPath() + "/out/login");
            return;
        }

        Customer c = customerDao.selectCustomerById(loginCustomer.getCustomerId());
        request.setAttribute("customer", c);
        request.getRequestDispatcher("/WEB-INF/view/customer/customerInfo.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Customer loginCustomer = (Customer) session.getAttribute("loginCustomer");

        if (loginCustomer == null) {
            response.sendRedirect(request.getContextPath() + "/out/login");
            return;
        }

        // JSP에서 전달받은 값
        String customerId = request.getParameter("id"); 
        String newPw = request.getParameter("pw");
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");

        Customer c = new Customer();
        c.setCustomerId(customerId);
        c.setCustomerPw(newPw);
        c.setCustomerName(name);
        c.setCustomerPhone(phone);

        try {
            int row = customerDao.updateCustomer(c); // DAO 호출
            if (row > 0) {
                // 세션 갱신
                loginCustomer.setCustomerPw(newPw);
                loginCustomer.setCustomerName(name);
                loginCustomer.setCustomerPhone(phone);
                session.setAttribute("loginCustomer", loginCustomer);

                response.getWriter().println("<script>alert('수정 완료'); location.href='"
                        + request.getContextPath() + "/customer/customerInfo';</script>");
            } else {
                response.getWriter().println("<script>alert('수정 실패'); history.back();</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('서버 오류'); history.back();</script>");
        }
    }
}
