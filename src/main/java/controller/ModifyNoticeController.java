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

    // 수정 페이지 보여주기
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int noticeCode = Integer.parseInt(request.getParameter("noticeCode"));
        Notice notice = noticeDao.selectNoticeOne(noticeCode);
        request.setAttribute("notice", notice);
        request.getRequestDispatcher("/WEB-INF/view/emp/modifyNotice.jsp").forward(request, response);
    }

    // 수정 처리
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        int noticeCode = Integer.parseInt(request.getParameter("noticeCode"));
        String noticeTitle = request.getParameter("noticeTitle");
        String noticeContent = request.getParameter("noticeContent");

        Notice notice = new Notice();
        notice.setNoticeCode(noticeCode);
        notice.setNoticeTitle(noticeTitle);
        notice.setNoticeContent(noticeContent);

        noticeDao.updateNotice(notice);
        response.sendRedirect(request.getContextPath() + "/emp/noticeList");
    }
}
