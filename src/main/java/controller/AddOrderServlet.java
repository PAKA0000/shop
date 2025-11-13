package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import dao.AddressDao;
import dao.CartDao;
import dao.GoodsDao;
import dao.OrdersDao;
import dto.Address;
import dto.Customer;
import dto.Orders;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/customer/addOrders")
public class AddOrderServlet extends HttpServlet {
	GoodsDao goodsDao;
	CartDao cartDao;
	AddressDao addressDao;
	OrdersDao ordersDao;
	// addOrders.jsp action
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    
	    String goodsCode = request.getParameter("goodsCode");
	    String cartQuantity = request.getParameter("cartQuantity");
	    System.out.println("goodsCode: "+goodsCode);
	    System.out.println("cartQuantity: "+cartQuantity);
	            
	    // cartList action
	    String[] cartCodeList = request.getParameterValues("cartCodeList");
	    System.out.println("cartCodeList: "+cartCodeList);
	    
	    List<Map<String, Object>> list = new ArrayList<>();
	    
	    // Map : 상품정보 + (이미지정보) + 수량
	    if(goodsCode != null) { // goodsOne action
	        goodsDao = new GoodsDao();
	        Map<String, Object> m = goodsDao.selectGoodsOne(Integer.parseInt(goodsCode));
	        m.put("cartQuantity", cartQuantity);
	        list.add(m);
	    } else { // cartList action
	        if(cartCodeList != null && cartCodeList.length > 0) {
	            cartDao = new CartDao(); 
	            for(String cc : cartCodeList) {
	                int cartCode = Integer.parseInt(cc);
	                Map<String, Object> m = cartDao.selectCartListByKey(cartCode);
	                list.add(m);
	                
	                // cartDao.deleteCart(cc); // 주문 완료 후 삭제
	            }
	        } else {
	            // 선택된 장바구니 항목이 없는 경우
	            request.setAttribute("msg", "선택된 장바구니 상품이 없습니다.");
	            request.getRequestDispatcher("/WEB-INF/view/customer/cartList.jsp").forward(request, response);
	            return; // 더 이상 진행하지 않음
	        }
	    }   
	    
	    int orderPrice = 0;
	    for(Map m : list) {
	        orderPrice += (Integer)(m.get("goodsPrice"));
	    }
	    
	    request.setAttribute("list", list);
	    request.setAttribute("orderPrice", orderPrice);
	    
	    HttpSession session = request.getSession();
	    Customer loginCustomer = (Customer)(session.getAttribute("loginCustomer"));
	    addressDao = new AddressDao();
	    List<Address> addressList = addressDao.selectAddressList(loginCustomer.getCustomerCode());
	    request.setAttribute("addressList", addressList);
	    
	    request.getRequestDispatcher("/WEB-INF/view/customer/addOrders.jsp").forward(request, response);
	}
}
