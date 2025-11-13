package ajax;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.util.*;

import com.google.gson.Gson;

import dao.StatsDao;

@WebServlet("/emp/genderTotalCount")
public class GenderTotalCountRestController extends HttpServlet {
    StatsDao statsDao;
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        statsDao = new StatsDao();
        List<Map<String,Object>> list = statsDao.selectOrderTotalCntByYM(
            request.getParameter("fromYM"),
            request.getParameter("toYM")
        );
        PrintWriter out = response.getWriter();
        out.print(new Gson().toJson(list));
        out.flush();
    }
}
