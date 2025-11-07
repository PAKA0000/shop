package controller;

import java.io.IOException;
import dao.NoticeDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/emp/removeNotice")
public class RemoveNoticeController extends HttpServlet {
    private NoticeDao noticeDao = new NoticeDao();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int noticeCode = Integer.parseInt(request.getParameter("noticeCode"));
        noticeDao.deleteNotice(noticeCode);
        response.sendRedirect(request.getContextPath() + "/emp/noticeList");
    }
}
