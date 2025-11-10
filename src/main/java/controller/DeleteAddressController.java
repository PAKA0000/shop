package controller;

import java.io.IOException;

import dao.AddressDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/customer/deleteAddress")
public class DeleteAddressController extends HttpServlet {
    private AddressDao addressDao = new AddressDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginCustomerCode") == null) {
            response.sendRedirect(request.getContextPath() + "/customer/login");
            return;
        }

        int addressCode = Integer.parseInt(request.getParameter("addressCode"));
        addressDao.deleteAddress(addressCode);

        response.sendRedirect(request.getContextPath() + "/customer/addressList");
    }
}
