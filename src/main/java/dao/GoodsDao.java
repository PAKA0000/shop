package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dto.Goods;
import dto.GoodsImg;

public class GoodsDao {
	public List<Map<String, Object>> selectBestList(int beginRow, int rowPerPage) throws Exception {
		 List<Map<String, Object>> list = new ArrayList<>();
		    Connection conn = null;
		    PreparedStatement stmt = null;
		    ResultSet rs = null;

		    String sql = """
		        SELECT 
		            g.goods_code AS goodsCode,
		            g.goods_name AS goodsName,
		            g.goods_price AS goodsPrice,
		            g.point_rate AS pointRate,
		            g.soldout AS soldout,
		            g.createdate AS createdate,
		            gi.filename AS filename
		        FROM goods g
		        LEFT JOIN goods_img gi
		            ON g.goods_code = gi.goods_code
		            where g.soldout is null
		        ORDER BY g.goods_code DESC
		        OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
		    """;

		    try {
		        conn = DBConnection.getConn();
		        stmt = conn.prepareStatement(sql);
		        stmt.setInt(1, beginRow);
		        stmt.setInt(2, rowPerPage);

		        rs = stmt.executeQuery();
		        while (rs.next()) {
		            Map<String, Object> m = new HashMap<>();
		            m.put("goodsCode", rs.getInt("goodsCode"));
		            m.put("goodsName", rs.getString("goodsName"));
		            m.put("goodsPrice", rs.getDouble("goodsPrice"));
		            m.put("pointRate", rs.getDouble("pointRate"));
		            m.put("soldout", rs.getString("soldout"));
		            m.put("createdate", rs.getString("createdate"));
		            m.put("filename", rs.getString("filename"));
		            list.add(m);
		        }

		        System.out.println("[GoodsDao] 상품 개수: " + list.size());
		    } catch (SQLException e) {
		        e.printStackTrace();
		    } finally {
		        if (rs != null) try { rs.close(); } catch (SQLException e) {}
		        if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
		        if (conn != null) try { conn.close(); } catch (SQLException e) {}
		    }

		    return list;
		}
	// 상품등록 + 이미지 등록
	// 반환값은 실패시 false
	public boolean insertGoodsAndImg(Goods goods, GoodsImg img) {
		boolean result = false;
		Connection conn = null;
		PreparedStatement stmtSeq = null; // select
		PreparedStatement stmtGoods = null; // insert
		PreparedStatement stmtImg = null; // insert
		ResultSet rs = null;
		
		String sqlSeq = """
			select seq_goods.nextval from dual
		""";
		
		String sqlGoods = """
			insert into goods(goods_code, goods_name, goods_price, emp_code, point_rate, soldout, createdate)
			values(?, ?, ?, ?, ?, null, sysdate)	
		""";
		
		String sqlImg = """
			insert into goods_img(goods_code, filename, origin_name, content_type, filesize, createdate)
			values(?, ?, ?, ?, ?, sysdate)
		""";
		
		try {
			conn = DBConnection.getConn();
			conn.setAutoCommit(false); // 단일 트랜잭션안에서 시퀀스 생성 -> 상품입력 -> 이미지입력
			
			// 1) seq_goods.nextval값을 먼저 생성 후 사용
			stmtSeq = conn.prepareStatement(sqlSeq);
			rs = stmtSeq.executeQuery();
			rs.next();
			int goodsCode = rs.getInt(1);
			
			// 2) goods 입력
			stmtGoods = conn.prepareStatement(sqlGoods);
			stmtGoods.setInt(1, goodsCode);
			stmtGoods.setString(2, goods.getGoodsName());
			stmtGoods.setInt(3, goods.getGoodsPrice());
			stmtGoods.setInt(4, goods.getEmpCode());
			stmtGoods.setDouble(5, goods.getPointRate());
			int row1 = stmtGoods.executeUpdate();
			// 상품입력에 실패하면
			if(row1 != 1) {
				conn.rollback(); 
				return result;
			}
			// 3) // 상품입력에 성공하면 img 입력
			stmtImg = conn.prepareStatement(sqlImg);
			stmtImg.setInt(1, goodsCode);
			stmtImg.setString(2, img.getFilename());
			stmtImg.setString(3, img.getOriginName());
			stmtImg.setString(4, img.getContentType());
			stmtImg.setLong(5, img.getFilesize());
			int row2 = stmtImg.executeUpdate();
			if(row2 != 1) {
				conn.rollback(); 
				return result;
				// throw new SQLException();
			}
			result = true; // 상품 & 이미지 입력성공
			conn.commit();
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return result;
	}

	public List<Map<String, Object>> selectGoodsList(int beginRow, int rowPerPage) throws Exception {
	    List<Map<String, Object>> list = new ArrayList<>();
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;

	    String sql = """
	        SELECT 
	            g.goods_code AS goodsCode,
	            g.goods_name AS goodsName,
	            g.goods_price AS goodsPrice,
	            g.point_rate AS pointRate,
	            g.soldout AS soldout,
	            g.createdate AS createdate,
	            gi.filename AS filename
	        FROM goods g
	        LEFT JOIN goods_img gi
	            ON g.goods_code = gi.goods_code
	            where g.soldout is null
	        ORDER BY g.goods_code DESC
	        OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
	    """;

	    try {
	        conn = DBConnection.getConn();
	        stmt = conn.prepareStatement(sql);
	        stmt.setInt(1, beginRow);
	        stmt.setInt(2, rowPerPage);

	        rs = stmt.executeQuery();
	        while (rs.next()) {
	            Map<String, Object> m = new HashMap<>();
	            m.put("goodsCode", rs.getInt("goodsCode"));
	            m.put("goodsName", rs.getString("goodsName"));
	            m.put("goodsPrice", rs.getDouble("goodsPrice"));
	            m.put("pointRate", rs.getDouble("pointRate"));
	            m.put("soldout", rs.getString("soldout"));
	            m.put("createdate", rs.getString("createdate"));
	            m.put("filename", rs.getString("filename"));
	            list.add(m);
	        }

	        System.out.println("[GoodsDao] 상품 개수: " + list.size());
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        if (rs != null) try { rs.close(); } catch (SQLException e) {}
	        if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
	        if (conn != null) try { conn.close(); } catch (SQLException e) {}
	    }

	    return list;
	}
	public int selectGoodsCount() throws Exception {
	    int count = 0;
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    
	    String sql = "SELECT COUNT(*) FROM goods WHERE soldout IS NULL";
	    
	    try {
	        conn = DBConnection.getConn();
	        stmt = conn.prepareStatement(sql);
	        rs = stmt.executeQuery();
	        if (rs.next()) {
	            count = rs.getInt(1);
	        }
	    } finally {
	        if (rs != null) try { rs.close(); } catch (SQLException e) {}
	        if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
	        if (conn != null) try { conn.close(); } catch (SQLException e) {}
	    }
	    return count;
	}


}
