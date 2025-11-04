package ajax;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import dao.CustomerDao;

@WebServlet("/customer/checkId")
public class CustomerIdCheckController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String id = request.getParameter("id");
        response.setContentType("application/json;charset=UTF-8");

        CustomerDao dao = new CustomerDao();
        try {
            String existingId = dao.selectCustomerCk(id);
            boolean available = (existingId == null);
            response.getWriter().print("{\"available\": " + available + ", \"id\": \"" + id + "\"}");
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().print("{\"available\": false, \"message\": \"서버 오류\"}");
        }
    }
}


