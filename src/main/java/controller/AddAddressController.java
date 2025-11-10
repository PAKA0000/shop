package controller;

import java.io.IOException;

import dao.AddressDao;
import dto.Address;
import dto.Customer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/customer/addAddress")
public class AddAddressController extends HttpServlet {

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

        request.getRequestDispatcher("/WEB-INF/view/customer/addAddress.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 세션 확인
        HttpSession session = request.getSession(false);
        Customer loginCustomer = (session != null) ? (Customer) session.getAttribute("loginCustomer") : null;

        if (loginCustomer == null) {
            response.sendRedirect(request.getContextPath() + "/out/login");
            return;
        }

        // 폼 데이터 가져오기
        String postcode = request.getParameter("postcode");
        String roadAddress = request.getParameter("roadAddress");
        String jibunAddress = request.getParameter("jibunAddress");
        String detailAddress = request.getParameter("detailAddress");
        String extraAddress = request.getParameter("extraAddress");

        // 주소 합치기 (원하면)
        String fullAddress = "[" + postcode + "] " + roadAddress + " " + jibunAddress + " " + detailAddress + " " + extraAddress;

        Address address = new Address();
        address.setCustomerCode(loginCustomer.getCustomerCode());
        address.setAddress(fullAddress);

        // DAO에 저장
        addressDao.insertAddress(address);

        // 목록 페이지로 이동
        response.sendRedirect(request.getContextPath() + "/customer/addressList");
    }
}
