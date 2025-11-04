package controller;

import dao.EmpDao;
import dto.Emp;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/emp/updateEmp")
public class UpdateEmpController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String empId = request.getParameter("empId");
        if (empId == null || empId.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/emp/empList?error=invalidId");
            return;
        }

        EmpDao dao = new EmpDao();

        try {
            Emp emp = dao.selectEmpById(empId);
            if (emp == null) {
                response.sendRedirect(request.getContextPath() + "/emp/empList?error=notfound");
                return;
            }

            request.setAttribute("emp", emp);
            request.getRequestDispatcher("/WEB-INF/view/emp/updateEmp.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "데이터베이스 오류가 발생했습니다.");
            request.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String empId = request.getParameter("empId");
        String empName = request.getParameter("empName");
        String activeParam = request.getParameter("active");

        if (empId == null || empName == null || activeParam == null ||
            empId.isEmpty() || empName.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/emp/updateEmp?empId=" + empId + "&error=invalidInput");
            return;
        }

        int active;
        try {
            active = Integer.parseInt(activeParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/emp/updateEmp?empId=" + empId + "&error=invalidActive");
            return;
        }

        Emp emp = new Emp();
        emp.setEmpId(empId);
        emp.setEmpName(empName);
        emp.setActive(active);

        EmpDao dao = new EmpDao();

        try {
            int row = dao.updateEmp(emp);
            if (row > 0) {
                response.sendRedirect(request.getContextPath() + "/emp/empList?success=update");
            } else {
                response.sendRedirect(request.getContextPath() + "/emp/updateEmp?empId=" + empId + "&error=fail");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/emp/updateEmp?empId=" + empId + "&error=db");
        }
    }
}
