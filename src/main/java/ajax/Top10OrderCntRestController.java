package ajax;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;
import dao.StatsDao;

@WebServlet("/emp/top10OrderCnt")
public class Top10OrderCntRestController extends HttpServlet {
    StatsDao statsDao = new StatsDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");

        List<Map<String, Object>> top10List = statsDao.selectTop10OrderCntByCustomer(); // DAO 메서드 호출

        Gson gson = new Gson();
        String jsonResult = gson.toJson(top10List);

        try (PrintWriter out = response.getWriter()) {
            out.print(jsonResult);
            out.flush();
        }
    }
}
