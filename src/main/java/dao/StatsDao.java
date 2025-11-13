package dao;

import java.sql.*;
import java.util.*;

public class StatsDao {

	// ✅ 1. 성별 주문수 (건수)
	public List<Map<String, Object>> selectOrderCntByGender() {
		List<Map<String, Object>> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = """
			select t.g gender, count(*) cnt
			from (
				select c.gender g, o.order_code oc
				from customer c inner join orders o
				on c.customer_code = o.customer_code
			) t
			group by t.g
		""";
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Map<String, Object> map = new HashMap<>();
				map.put("gender", rs.getString("gender"));
				map.put("cnt", rs.getInt("cnt"));
				list.add(map);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try { if(rs!=null)rs.close(); if(stmt!=null)stmt.close(); if(conn!=null)conn.close(); } catch(Exception e){}
		}
		return list;
	}
	
	
	// ✅ 2. 성별 총 주문 금액
	public List<Map<String, Object>> selectOrderPriceByGender() {
		List<Map<String, Object>> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = """
			select t.g gender, sum(t.p) totalPrice
			from (
				select c.gender g, o.order_price p
				from customer c inner join orders o
				on c.customer_code = o.customer_code
			) t
			group by t.g
		""";
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Map<String, Object> map = new HashMap<>();
				map.put("gender", rs.getString("gender"));
				map.put("totalPrice", rs.getInt("totalPrice"));
				list.add(map);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try { if(rs!=null)rs.close(); if(stmt!=null)stmt.close(); if(conn!=null)conn.close(); } catch(Exception e){}
		}
		return list;
	}
	
	
	// ✅ 3. 월별 주문량 (건수)
	public List<Map<String, Object>> selectOrderCntByYM(String fromYM, String toYM) {
		List<Map<String, Object>> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = """
			select to_char(createdate, 'YYYY-MM') ym, count(*) cnt
			from orders
			where createdate between to_date(?, 'YYYY-MM-DD') 
			and to_date(?, 'YYYY-MM-DD')
			group by to_char(createdate, 'YYYY-MM')
			order by ym asc
		""";
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, fromYM);
			stmt.setString(2, toYM);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Map<String, Object> map = new HashMap<>();
				map.put("ym", rs.getString("ym"));
				map.put("cnt", rs.getInt("cnt"));
				list.add(map);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try { if(rs!=null)rs.close(); if(stmt!=null)stmt.close(); if(conn!=null)conn.close(); } catch(Exception e){}
		}
		return list;
	}
	
	
	// ✅ 4. 월별 주문량 누적
	public List<Map<String, Object>> selectOrderTotalCntByYM(String fromYM, String toYM) {
		List<Map<String, Object>> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = """
			select t.ym, sum(t.cnt) over(order by t.ym asc) totalOrder
			from (
				select to_char(createdate, 'YYYY-MM') ym, count(*) cnt
				from orders
				where createdate between to_date(?, 'YYYY-MM-DD') 
				and to_date(?, 'YYYY-MM-DD')
				group by to_char(createdate, 'YYYY-MM')
			) t
		""";
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, fromYM);
			stmt.setString(2, toYM);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Map<String, Object> map = new HashMap<>();
				map.put("ym", rs.getString("ym"));
				map.put("totalOrder", rs.getInt("totalOrder"));
				list.add(map);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try { if(rs!=null)rs.close(); if(stmt!=null)stmt.close(); if(conn!=null)conn.close(); } catch(Exception e){}
		}
		return list;
	}
	
	
	// ✅ 5. 월별 총금액 누적
	public List<Map<String, Object>> selectOrderTotalPriceByYM(String fromYM, String toYM) {
	    List<Map<String, Object>> list = new ArrayList<>();
	    String sql = """
	        select to_char(createdate,'YYYY-MM') as ym, sum(order_price) as totalPrice
	        from orders
	        where createdate between to_date(?, 'YYYY-MM-DD') 
	        and to_date(?, 'YYYY-MM-DD')
	        group by to_char(createdate,'YYYY-MM')
	        order by ym
	    """;
	    try (Connection conn = DBConnection.getConn();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {
	        
	        stmt.setString(1, fromYM);
	        stmt.setString(2, toYM);
	        
	        try (ResultSet rs = stmt.executeQuery()) {
	            while(rs.next()) {
	                Map<String, Object> map = new HashMap<>();
	                map.put("ym", rs.getString("ym"));
	                map.put("totalPrice", rs.getDouble("totalPrice"));
	                list.add(map);
	            }
	        }
	    } catch(Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}

	
	
	// ✅ 6. 고객별 주문수 TOP10
	 public List<Map<String, Object>> selectTop10OrderCntByCustomer() {
	        List<Map<String, Object>> list = new ArrayList<>();
	        Connection conn = null;
	        PreparedStatement stmt = null;
	        ResultSet rs = null;

	        // 고객 이름과 주문 횟수 계산, 조인 필요
	        String sql = """
	            SELECT c.customer_name, COUNT(o.order_code) AS cnt
	            FROM customer c
	            JOIN orders o ON c.customer_code = o.customer_code
	            GROUP BY c.customer_name
	            ORDER BY cnt DESC
	            FETCH FIRST 10 ROWS ONLY
	        """;

	        try {
	            conn = DBConnection.getConn();
	            stmt = conn.prepareStatement(sql);
	            rs = stmt.executeQuery();

	            while (rs.next()) {
	                Map<String, Object> map = new HashMap<>();
	                map.put("customerName", rs.getString("customer_name"));
	                map.put("cnt", rs.getInt("cnt"));
	                list.add(map);
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            try { if(rs!=null) rs.close(); if(stmt!=null) stmt.close(); if(conn!=null) conn.close(); } catch(Exception e) {}
	        }

	        return list;
	    }

	
	
	// ✅ 7. 고객별 총금액 TOP10
	 public List<Map<String, Object>> selectTop10OrderPriceByCustomer() {
		    List<Map<String, Object>> list = new ArrayList<>();
		    String sql = """
		        SELECT c.CUSTOMER_NAME, SUM(o.ORDER_PRICE) AS totalPrice
		        FROM ORDERS o
		        JOIN CUSTOMER c ON o.CUSTOMER_CODE = c.CUSTOMER_CODE
		        GROUP BY c.CUSTOMER_NAME
		        ORDER BY totalPrice DESC
		        FETCH FIRST 10 ROWS ONLY
		    """;
		    try (Connection conn = DBConnection.getConn();
		         PreparedStatement stmt = conn.prepareStatement(sql);
		         ResultSet rs = stmt.executeQuery()) {

		        while (rs.next()) {
		            Map<String, Object> map = new HashMap<>();
		            map.put("customerName", rs.getString("CUSTOMER_NAME"));
		            map.put("totalPrice", rs.getInt("totalPrice"));
		            list.add(map);
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		    return list;
		}

	// ✅ 8. 상품별 주문수 TOP10
	 public List<Map<String, Object>> selectTop10ProductCnt() {
		    List<Map<String, Object>> list = new ArrayList<>();
		    Connection conn = null;
		    PreparedStatement stmt = null;
		    ResultSet rs = null;
		    
		    String sql = """
		        SELECT g.goods_name AS productName, COUNT(*) AS cnt
		        FROM orders o
		        JOIN goods g ON o.goods_code = g.goods_code
		        GROUP BY g.goods_name
		        ORDER BY cnt DESC
		        FETCH FIRST 10 ROWS ONLY
		    """;
		    
		    try {
		        conn = DBConnection.getConn();
		        stmt = conn.prepareStatement(sql);
		        rs = stmt.executeQuery();
		        while(rs.next()) {
		            Map<String, Object> map = new HashMap<>();
		            map.put("productName", rs.getString("productName"));
		            map.put("cnt", rs.getInt("cnt"));
		            list.add(map);
		        }
		    } catch(Exception e) {
		        e.printStackTrace();
		    } finally {
		        try { if(rs != null) rs.close(); if(stmt != null) stmt.close(); if(conn != null) conn.close(); } catch(Exception e) {}
		    }
		    
		    return list;
		}

	
	// ✅ 9. 상품별 총금액 TOP10
	 public List<Map<String, Object>> selectTop10ProductPrice() {
		    List<Map<String, Object>> list = new ArrayList<>();
		    Connection conn = null;
		    PreparedStatement stmt = null;
		    ResultSet rs = null;
		    
		    String sql = """
		        SELECT g.goods_name AS goodsName, SUM(o.order_price) AS totalPrice
		        FROM orders o
		        JOIN goods g ON o.goods_code = g.goods_code
		        GROUP BY g.goods_name
		        ORDER BY totalPrice DESC
		        FETCH FIRST 10 ROWS ONLY
		    """;
		    
		    try {
		        conn = DBConnection.getConn();
		        stmt = conn.prepareStatement(sql);
		        rs = stmt.executeQuery();
		        while(rs.next()) {
		            Map<String, Object> map = new HashMap<>();
		            map.put("goodssName", rs.getString("goodsName"));
		            map.put("totalPrice", rs.getInt("totalPrice"));
		            list.add(map);
		        }
		    } catch(Exception e) {
		        e.printStackTrace();
		    } finally {
		        try { if(rs != null) rs.close(); if(stmt != null) stmt.close(); if(conn != null) conn.close(); } catch(Exception e) {}
		    }
		    
		    return list;
		}

	
	
	// ✅ 10. 상품별 평균 리뷰점수 TOP10
	     public List<Map<String, Object>> selectTop10Review() {
	         List<Map<String, Object>> list = new ArrayList<>();
	         String sql = """
	             SELECT g.goods_code, g.goods_name, ROUND(AVG(r.score),1) AS avgScore
					FROM review r
					JOIN orders o ON r.order_code = o.order_code
					JOIN goods g ON o.goods_code = g.goods_code
					GROUP BY g.goods_code, g.goods_name
					ORDER BY avgScore DESC
					FETCH FIRST 10 ROWS ONLY

	         """;

	         try (Connection conn = DBConnection.getConn();
	              PreparedStatement stmt = conn.prepareStatement(sql);
	              ResultSet rs = stmt.executeQuery()) {

	             while (rs.next()) {
	                 Map<String, Object> map = new HashMap<>();
	                 map.put("goodsCode", rs.getString("goods_code"));
	                 map.put("goodsName", rs.getString("goods_name"));
	                 map.put("avgScore", rs.getDouble("avgScore"));
	                 list.add(map);
	             }

	         } catch (Exception e) {
	             e.printStackTrace();
	         }

	         return list;
	     }

	// ✅ 11. 성별 총 주문수량 (파이 차트)
	     // 성별 총 주문수량
	     public List<Map<String, Object>> selectOrderByGender() {
	 		List<Map<String, Object>> list = new ArrayList<>();
	 		Connection conn = null;
	 		PreparedStatement stmt = null;
	 		ResultSet rs = null;
	 		String sql = """
	 			select t.g gender, sum(t.p) totalPrice
	 			from (
	 				select c.gender g, o.order_price p
	 				from customer c inner join orders o
	 				on c.customer_code = o.customer_code
	 			) t
	 			group by t.g
	 		""";
	 		try {
	 			conn = DBConnection.getConn();
	 			stmt = conn.prepareStatement(sql);
	 			rs = stmt.executeQuery();
	 			while(rs.next()) {
	 				Map<String, Object> map = new HashMap<>();
	 				map.put("gender", rs.getString("gender"));
	 				map.put("totalPrice", rs.getInt("totalPrice"));
	 				list.add(map);
	 			}
	 		} catch(Exception e) {
	 			e.printStackTrace();
	 		} finally {
	 			try { if(rs!=null)rs.close(); if(stmt!=null)stmt.close(); if(conn!=null)conn.close(); } catch(Exception e){}
	 		}
	 		return list;
	 	}
	 }

