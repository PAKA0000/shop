package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.CustomerDao;
import dto.Customer;


@WebServlet("/out/addCustomer")
public class AddMemberController extends HttpServlet {
	//폼
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/view/customer/addCustomer.jsp").forward(request, response);
	}
	//액션
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    
	    // 1. 폼 데이터 가져오기
	    String id = request.getParameter("id");
	    String pw = request.getParameter("pw");
	    String name = request.getParameter("name");
	    String email = request.getParameter("email"); 
	    String birth = request.getParameter("birth"); 
	    String phone = request.getParameter("phone");

	    // 2. Customer 객체 생성
	    Customer customer = new Customer();
	    customer.setCustomerId(id);
	    customer.setCustomerPw(pw);
	    customer.setCustomerName(name);
	    customer.setCustomerPhone(Integer.parseInt(phone)); 
	    customer.setPoint(0);

	    // 3. DB 저장
	    CustomerDao dao = new CustomerDao();
	    int row = dao.insertCustomer(customer);

	    // 4. 저장 성공 시 로그인 페이지로 이동
	    if (row > 0) {
	        response.sendRedirect(request.getContextPath() + "/out/login");
	    } else {
	        response.getWriter().println("회원가입 실패");
	    }
	}

	
	
}
