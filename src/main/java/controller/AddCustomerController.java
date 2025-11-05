package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import dao.CustomerDao;
import dto.Customer;

@WebServlet("/out/customer/addCustomer")
public class AddCustomerController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/view/customer/addCustomer.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String id = request.getParameter("id");
        String pw = request.getParameter("pw");
        String pwConfirm = request.getParameter("pwConfirm");
        String name = request.getParameter("name");
        String phoneStr = request.getParameter("phone");

        // 필수 입력값 체크
        if(id == null || pw == null || pwConfirm == null || name == null || phoneStr == null ||
           id.isEmpty() || pw.isEmpty() || pwConfirm.isEmpty() || name.isEmpty() || phoneStr.isEmpty()) {
            return;
        }

        // 비밀번호 확인 체크
        if(!pw.equals(pwConfirm)) {
            response.getWriter().println("<script>alert('비밀번호가 일치하지 않습니다.'); history.back();</script>");
            return;
        }

        int phone = 0;
        try {
            phone = Integer.parseInt(phoneStr);
        } catch(NumberFormatException e) {
            response.getWriter().println("<script>alert('전화번호는 숫자만 입력해주세요.'); history.back();</script>");
            return;
        }

        CustomerDao dao = new CustomerDao();
        try {
            String existId = dao.selectCustomerCk(id); // 중복 체크
            if(existId != null) {
                response.getWriter().println("<script>alert('이미 사용 중인 아이디입니다.'); history.back();</script>");
                return;
            }

            Customer customer = new Customer();
            customer.setCustomerId(id);
            customer.setCustomerPw(pw);
            customer.setCustomerName(name);
            customer.setCustomerPhone(phone);
            customer.setPoint(0);

            int row = dao.insertCustomer(customer);

            if(row > 0) {
                response.sendRedirect(request.getContextPath() + "/out/login");
            } else {
                response.getWriter().println("<script>alert('회원가입 실패'); history.back();</script>");
            }

        } catch(Exception e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('서버 오류 발생: " + e.getMessage() + "'); history.back();</script>");
        }
    }
}
