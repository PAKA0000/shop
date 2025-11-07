package controller;
import java.io.IOException;
import dao.NoticeDao;
import dto.Notice;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/emp/addNotice")
public class AddNoticeController extends HttpServlet {
    private NoticeDao noticeDao = new NoticeDao();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/view/emp/addNotice.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String title = request.getParameter("noticeTitle");
        String content = request.getParameter("noticeContent");
        String empCode = request.getParameter("empCode"); // 로그인한 사원코드

        Notice notice = new Notice();
        notice.setNoticeTitle(title);
        notice.setNoticeContent(content);
        notice.setEmpCode(empCode);

        noticeDao.insertNotice(notice);
        response.sendRedirect(request.getContextPath() + "/emp/noticeList");
    }
}
