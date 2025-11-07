package controller;
import java.io.IOException;
import dao.NoticeDao;
import dto.Notice;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/emp/modifyNotice")
public class ModifyNoticeController extends HttpServlet {
    private NoticeDao noticeDao = new NoticeDao();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String codeParam = request.getParameter("noticeCode");
        
        // noticeCode가 안 넘어온 경우 대비
        if (codeParam == null || codeParam.equals("")) {
            System.out.println("⚠️ noticeCode 파라미터 없음 → 목록으로 리다이렉트");
            response.sendRedirect(request.getContextPath() + "/emp/noticeList");
            return;
        }

        int noticeCode = Integer.parseInt(codeParam);
        Notice notice = noticeDao.selectNoticeOne(noticeCode);

        if (notice == null) {
            System.out.println("⚠️ 존재하지 않는 noticeCode: " + noticeCode);
            response.sendRedirect(request.getContextPath() + "/emp/noticeList");
            return;
        }

        request.setAttribute("notice", notice);
        request.getRequestDispatcher("/WEB-INF/view/emp/modifyNotice.jsp").forward(request, response);
    }
}
