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

    private AddressDao addressDao = new AddressDao();

    // ----------------------------------------
    // GET 요청: 배송지 입력 폼 보여주기
    // ----------------------------------------
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginCustomerCode") == null) {
            // 로그인 안 된 경우 로그인 페이지로 이동
            response.sendRedirect(request.getContextPath() + "/customer/login");
            return;
        }

        // 배송지 등록 폼 JSP로 포워드
        request.getRequestDispatcher("/WEB-INF/view/customer/addAddressForm.jsp")
               .forward(request, response);
    }

    // ----------------------------------------
    // POST 요청: 배송지 등록 처리
    // ----------------------------------------
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginCustomerCode") == null) {
            response.sendRedirect(request.getContextPath() + "/out/login.jsp");
            return;
        }

        // 한글 인코딩 처리
        request.setCharacterEncoding("UTF-8");

        // 세션에서 고객 코드 가져오기
        int customerCode = (int) session.getAttribute("loginCustomerCode");

        // 요청 파라미터 받기 (폼 필드 이름과 맞춰야 함)
        String postcode = request.getParameter("postcode");
        String roadAddr = request.getParameter("roadAddress");
        String jibunAddr = request.getParameter("jibunAddress");
        String detailAddr = request.getParameter("detailAddress");
        String extraAddr = request.getParameter("extraAddress");

        // 주소 합치기
        StringBuilder fullAddress = new StringBuilder();
        if (postcode != null && !postcode.isEmpty()) fullAddress.append("(").append(postcode).append(") ");
        if (roadAddr != null && !roadAddr.isEmpty()) fullAddress.append(roadAddr).append(" ");
        if (jibunAddr != null && !jibunAddr.isEmpty()) fullAddress.append(jibunAddr).append(" ");
        if (detailAddr != null && !detailAddr.isEmpty()) fullAddress.append(detailAddr).append(" ");
        if (extraAddr != null && !extraAddr.isEmpty()) fullAddress.append(extraAddr);

        Address address = new Address();
        address.setCustomerCode(customerCode);
        address.setAddress(fullAddress.toString().trim());

        try {
            addressDao.insertAddress(address);
            // 주소 등록 후 주소 목록 페이지로 리다이렉트
            response.sendRedirect(request.getContextPath() + "/customer/addressList");
        } catch (Exception e) {
            e.printStackTrace();
            // 오류 발생 시 폼으로 다시 포워드
            request.setAttribute("errorMsg", "주소 등록 중 오류가 발생했습니다. 다시 시도해주세요.");
            request.getRequestDispatcher("/WEB-INF/view/customer/addAddressForm.jsp")
                   .forward(request, response);
        }
    }
}
