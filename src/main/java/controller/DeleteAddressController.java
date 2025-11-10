package controller;

import java.io.IOException;

import dao.AddressDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dto.Customer;

@WebServlet("/customer/deleteAddress")
public class DeleteAddressController extends HttpServlet {

    private AddressDao addressDao = new AddressDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 세션 확인
        HttpSession session = request.getSession(false);
        Customer loginCustomer = (session != null) ? (Customer) session.getAttribute("loginCustomer") : null;

        if (loginCustomer == null) {
            response.sendRedirect(request.getContextPath() + "/out/login");
            return;
        }

        String addressCodeStr = request.getParameter("addressCode");

        if (addressCodeStr != null) {
            try {
                int addressCode = Integer.parseInt(addressCodeStr);
                addressDao.deleteAddress(addressCode);
            } catch (NumberFormatException e) {
                e.printStackTrace(); // 필요 시 로깅
            }
        }

        // 삭제 후 목록 페이지로 이동
        response.sendRedirect(request.getContextPath() + "/customer/addressList");
    }
}
