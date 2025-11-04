package controller;

import dao.EmpDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet("/emp/deleteEmp")
public class EmpDeleteController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");

        String empId = request.getParameter("empId");
        PrintWriter out = response.getWriter();

        if (empId == null || empId.trim().isEmpty()) {
           
            out.flush();
            return;
        }

        EmpDao dao = new EmpDao();
        try {
            int row = dao.deleteEmp(empId);
            if (row > 0) {
            } 
        } catch (SQLException e) {
            
            e.printStackTrace();
        }
        out.flush();
    }
}
