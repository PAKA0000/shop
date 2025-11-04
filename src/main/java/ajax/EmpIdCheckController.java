package ajax;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import dao.EmpDao;


@WebServlet("/emp/checkId")
public class EmpIdCheckController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("application/json; charset=UTF-8");
        String empId = request.getParameter("empId");

        EmpDao dao = new EmpDao();
        String existId = null;
        try {
            existId = dao.selectEmpCk(empId);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        PrintWriter out = response.getWriter();
        if (existId != null) {
            out.print("{\"available\": false, \"id\": \"" + existId + "\"}");
        } else {
            out.print("{\"available\": true}");
        }
        out.flush();
    }
}
