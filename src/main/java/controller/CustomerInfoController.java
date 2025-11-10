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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        String customerId = (String) session.getAttribute("loginId");
        if (customerId == null) {
            response.sendRedirect(request.getContextPath() + "/out/login");
            return;
        }

        String pw = request.getParameter("pw");
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");

        if(pw == null || name == null || phone == null ||
           pw.isEmpty() || name.isEmpty() || phone.isEmpty()) {
            response.getWriter().println("<script>alert('모든 항목을 입력하세요'); history.back();</script>");
            return;
        }

        try {
            // 기존 비밀번호 조회
            Customer existingCustomer = customerDao.selectCustomerById(customerId);
            if(existingCustomer == null) {
                response.getWriter().println("<script>alert('사용자를 찾을 수 없습니다'); history.back();</script>");
                return;
            }

            Customer customer = new Customer();
            customer.setCustomerId(customerId);
            customer.setCustomerPw(pw);
            customer.setCustomerName(name);
            customer.setCustomerPhone(phone);

            int row = customerDao.updateCustomerWithPwHistory(customer, existingCustomer.getCustomerPw());
            if(row > 0) {
                response.getWriter().println("<script>alert('정보가 수정되었습니다'); location.href='" +
                                             request.getContextPath() + "/customer/customerInfo';</script>");
            } else {
                response.getWriter().println("<script>alert('수정 실패'); history.back();</script>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('서버 오류 발생: "+e.getMessage()+"'); history.back();</script>");
        }
    }
    
}
