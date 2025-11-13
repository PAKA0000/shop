package ajax;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;
import dao.StatsDao;

@WebServlet("/emp/genderOrderCount")
public class GenderOrderCountRestController extends HttpServlet {
    StatsDao statsDao = new StatsDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");

        List<Map<String, Object>> orderList = statsDao.selectOrderCntByGender();

        Gson gson = new Gson();
        String jsonResult = gson.toJson(orderList);

        PrintWriter out = response.getWriter();
        out.print(jsonResult);
        out.flush();
    }
}
