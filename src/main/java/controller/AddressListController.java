package controller;

import java.io.IOException;
import java.util.List;

import dao.AddressDao;
import dto.Address;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/customer/addressList")
public class AddressListController extends HttpServlet {
    private AddressDao addressDao = new AddressDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginCustomerCode") == null) {
            response.sendRedirect(request.getContextPath() + "/customer/login");
            return;
        }

        int customerCode = (Integer) session.getAttribute("loginCustomerCode");
        List<Address> addressList = addressDao.selectAddressList(customerCode);

        request.setAttribute("addressList", addressList);
        request.getRequestDispatcher("/WEB-INF/view/customer/addressList.jsp").forward(request, response);
    }
}
