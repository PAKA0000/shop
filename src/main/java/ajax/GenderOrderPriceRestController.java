package ajax;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.util.*;
import com.google.gson.Gson;
import dao.StatsDao;

@WebServlet("/emp/genderOrderPrice")
public class GenderOrderPriceRestController extends HttpServlet {

    private StatsDao statsDao = new StatsDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");
        List<Map<String, Object>> genderOrderPriceList = statsDao.selectOrderPriceByGender();

        PrintWriter out = response.getWriter();
        out.print(new Gson().toJson(genderOrderPriceList));
        out.flush();
    }
}
