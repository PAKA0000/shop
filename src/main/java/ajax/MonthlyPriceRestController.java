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

@WebServlet("/emp/monthlyPrice")
public class MonthlyPriceRestController extends HttpServlet {
    StatsDao statsDao;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        statsDao = new StatsDao();

        // 요청 파라미터에서 연도 가져오기
        String year = request.getParameter("year"); // 예: "2025"

        // fromYM, toYM 계산 (년도의 1월 ~ 12월)
        String fromYM = year + "-01-01";
        String toYM = year + "-12-31";

        // DB 조회
        List<Map<String, Object>> monthlyPriceList = statsDao.selectOrderTotalPriceByYM(fromYM, toYM);

        // JSON 변환 후 응답
        Gson gson = new Gson();
        String jsonResult = gson.toJson(monthlyPriceList);

        PrintWriter out = response.getWriter();
        out.print(jsonResult);
        out.flush();
    }
}
