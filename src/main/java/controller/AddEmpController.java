package controller;

import dao.EmpDao;
import dto.Emp;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/emp/addEmp")
public class AddEmpController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // JSP로 포워드 (등록폼)
        request.getRequestDispatcher("/WEB-INF/view/emp/addEmp.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String empId = request.getParameter("empId");
        String empPw = request.getParameter("empPw");
        String empName = request.getParameter("empName");

        // active 기본값 1(활성)
        String activeParam = request.getParameter("active");
        int active = 1;
        if (activeParam != null && !activeParam.isEmpty()) {
            active = Integer.parseInt(activeParam);
        }

        Emp e = new Emp();
        e.setEmpId(empId);
        e.setPw(empPw);
        e.setEmpName(empName);
        e.setActive(active);

        EmpDao dao = new EmpDao();
        int row = dao.insertEmp(e);

        if (row > 0) {
            System.out.println("✅ 사원 등록 성공");
            response.sendRedirect(request.getContextPath() + "/emp/empList");
        } else {
            System.out.println("❌ 사원 등록 실패");
            response.sendRedirect(request.getContextPath() + "/emp/addEmp?error=fail");
        }
    }
}
