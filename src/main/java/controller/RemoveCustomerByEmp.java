package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import dao.CustomerDao;
import dao.OutidDao;
import dto.Outid;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/emp/RemoveCustomerByEmp")
public class RemoveCustomerByEmp extends HttpServlet {

    // 🔹 GET 요청 시에는 단순히 고객 목록으로 리다이렉트
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/emp/customerList");
    }

    // 🔹 POST 요청 시: 회원 삭제 + 탈퇴목록 조회 + JSP 이동
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String customerId = request.getParameter("customerId");
        String memo = request.getParameter("memo");

        // 입력값 검증
        if (customerId == null || memo == null || customerId.isBlank() || memo.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/emp/customerList");
            return;
        }

        Outid outid = new Outid();
        outid.setId(customerId);
        outid.setMemo(memo);

        CustomerDao customerDao = new CustomerDao();
        OutidDao outidDao = new OutidDao();

        try {
            // 🔸 회원 삭제 + Outid 테이블에 기록
            customerDao.deleteCustomerByEmp(outid);

            // 🔸 탈퇴 회원 목록 조회
            List<Outid> outidList = outidDao.selectOutidList();

            // 🔸 JSP로 포워드
            request.setAttribute("outidList", outidList);
            request.getRequestDispatcher("/WEB-INF/view/emp/OutidList.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/emp/customerList");
        }
    }
}
