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

@WebServlet("/emp/top10OrderPrice")
public class Top10OrderPriceRestController extends HttpServlet {
    StatsDao statsDao;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        statsDao = new StatsDao();

        // 고객별 총 주문금액 TOP10 조회
        List<Map<String, Object>> top10List = statsDao.selectTop10OrderPriceByCustomer();

        // JSON 변환 후 응답
        Gson gson = new Gson();
        String jsonResult = gson.toJson(top10List);

        PrintWriter out = response.getWriter();
        out.print(jsonResult);
        out.flush();
    }
}
