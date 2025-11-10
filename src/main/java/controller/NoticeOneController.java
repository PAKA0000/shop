package controller;

import java.io.IOException;
import dao.NoticeDao;
import dto.Notice;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/emp/noticeDetail")
public class NoticeOneController extends HttpServlet {
    private NoticeDao noticeDao = new NoticeDao();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int noticeCode = Integer.parseInt(request.getParameter("noticeCode"));
        Notice notice = noticeDao.selectNoticeOne(noticeCode);
        request.setAttribute("notice", notice);
        request.getRequestDispatcher("/WEB-INF/view/emp/noticeDetail.jsp").forward(request, response);
    }
}
