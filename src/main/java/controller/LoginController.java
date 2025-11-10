package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

import dao.CustomerDao;
import dao.EmpDao;
import dto.Customer;
import dto.Emp;

@WebServlet("/out/login")
public class LoginController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/view/out/login.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String userType = request.getParameter("customerOrEmpSel"); // customer 또는 emp
        String id = request.getParameter("id");
        String pw = request.getParameter("pw");

        HttpSession session = request.getSession();

        if ("Customer".equals(userType)) {
            CustomerDao cDao = new CustomerDao();
            try {
                Customer loginCustomer = cDao.login(id, pw); // SQLException 처리 필요

                if (loginCustomer != null) {
                    session.setAttribute("loginCustomer", loginCustomer);
                    response.sendRedirect(request.getContextPath() + "/customer/customerIndex");
                } else {
                    request.setAttribute("msg", "아이디 또는 비밀번호가 올바르지 않습니다.");
                    request.getRequestDispatcher("/WEB-INF/view/out/login.jsp").forward(request, response);
                }

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("msg", "서버 오류 발생: " + e.getMessage());
                request.getRequestDispatcher("/WEB-INF/view/out/login.jsp").forward(request, response);
            }

        } else if ("Emp".equals(userType)) {
            EmpDao eDao = new EmpDao();
            try {
                Emp loginEmp = eDao.login(id, pw);

                if (loginEmp != null) {
                    session.setAttribute("loginEmp", loginEmp);
                    response.sendRedirect(request.getContextPath() + "/emp/empIndex");
                } else {
                    request.setAttribute("msg", "아이디 또는 비밀번호가 올바르지 않습니다.");
                    request.getRequestDispatcher("/WEB-INF/view/out/login.jsp").forward(request, response);
                }

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("msg", "서버 오류 발생: " + e.getMessage());
                request.getRequestDispatcher("/WEB-INF/view/out/login.jsp").forward(request, response);
            }
        }
    }
}
