package controller;

import java.io.IOException;
import java.util.List;

import dao.AddressDao;
import dto.Address;
import dto.Customer;
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
        // 세션 확인
        HttpSession session = request.getSession(false);
        Customer loginCustomer = (session != null) ? (Customer) session.getAttribute("loginCustomer") : null;

        if (loginCustomer == null) {
            response.sendRedirect(request.getContextPath() + "/out/login");
            return;
        }

        int customerCode = loginCustomer.getCustomerCode();

        // DAO 호출하여 주소 목록 가져오기
        List<Address> addressList = addressDao.selectAddressList(customerCode);

        // JSP에 전달
        request.setAttribute("addressList", addressList);
        request.getRequestDispatcher("/WEB-INF/view/customer/addressList.jsp")
               .forward(request, response);
    }
}
