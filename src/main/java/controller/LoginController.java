package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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
        
        // 1. 폼 데이터 가져오기
        String userType = request.getParameter("customerOrEmpSel"); // customer 또는 emp
        String id = request.getParameter("id");
        String pw = request.getParameter("pw");

        // 2. 세션 가져오기
        HttpSession session = request.getSession();

        // 3. 고객 로그인 처리
        if ("Customer".equals(userType)) {
            CustomerDao cDao = new CustomerDao();
            Customer loginCustomer = cDao.login(id, pw); // DB 조회 후 일치하면 Customer 객체 반환

            if (loginCustomer != null) {
                session.setAttribute("loginCustomer", loginCustomer); // 세션 저장
                response.sendRedirect(request.getContextPath() + "/customer/customerIndex");
            } else {
                // 로그인 실패
                request.setAttribute("msg", "아이디 또는 비밀번호가 올바르지 않습니다.");
                request.getRequestDispatcher("/WEB-INF/view/out/login.jsp").forward(request, response);
            }

        } else if ("Emp".equals(userType)) { // 4. 사원 로그인 처리
            EmpDao eDao = new EmpDao();
            Emp loginEmp = eDao.login(id, pw);

            if (loginEmp != null) {
                session.setAttribute("loginEmp", loginEmp);
                response.sendRedirect(request.getContextPath() + "/emp/empIndex");
            } else {
                request.setAttribute("msg", "아이디 또는 비밀번호가 올바르지 않습니다.");
                request.getRequestDispatcher("/WEB-INF/view/out/login.jsp").forward(request, response);
            }
        }
    }
}
