package controller;

import java.io.IOException;

import dao.AddressDao;
import dto.Address;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/customer/addAddress")
public class AddAddressController extends HttpServlet {
    private AddressDao addressDao;

   

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginCustomerCode") == null) {
            response.sendRedirect(request.getContextPath() + "/customer/login");
            return;
        }

        Integer customerCodeObj = (Integer) session.getAttribute("loginCustomerCode");
        int customerCode = customerCodeObj.intValue();

        // 주소 입력값 가져오기 (우편번호 + 도로명 + 지번 + 상세 + 참고)
        String postcode = request.getParameter("postcode");
        String roadAddr = request.getParameter("roadAddress");
        String jibunAddr = request.getParameter("jibunAddress");
        String detailAddr = request.getParameter("detailAddress");
        String extraAddr = request.getParameter("extraAddress");

        // 주소 합치기
        String fullAddress = String.join(" ", postcode, roadAddr, jibunAddr, detailAddr, extraAddr).trim();

        Address address = new Address();
        address.setCustomerCode(customerCode);
        address.setAddress(fullAddress);

        addressDao = new AddressDao();
        addressDao.insertAddress(address);

        response.sendRedirect(request.getContextPath() + "/customer/addressList");
    }
}
