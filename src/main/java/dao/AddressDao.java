package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.Address;

public class AddressDao {

    public void insertAddress(Address address) {
        Connection conn = null;
        PreparedStatement stmt1 = null;
        PreparedStatement stmt2 = null;
        PreparedStatement stmt3 = null;
        ResultSet rs1 = null;

        // 1) 현재 고객의 주소 개수 확인
        String sql1 = "SELECT COUNT(*) FROM address WHERE customer_code = ?";

        // 2) 주소가 5개 이상이면 가장 오래된 주소 삭제
        String sql2 = "DELETE FROM address WHERE address_code = "
                    + "(SELECT MIN(address_code) FROM address WHERE customer_code = ?)";

        // 3) 새 주소 추가
        String sql3 = "INSERT INTO address(address_code, customer_code, address, createdate) "
                    + "VALUES(seq_address.nextval, ?, ?, SYSDATE)";

        try {
            conn = DBConnection.getConn();
            conn.setAutoCommit(false);

            // 1) 주소 개수 확인
            stmt1 = conn.prepareStatement(sql1);
            stmt1.setInt(1, address.getCustomerCode());
            rs1 = stmt1.executeQuery();
            rs1.next();
            int cnt = rs1.getInt(1);

            // 2) 주소 삭제 필요 시
            if (cnt >= 5) {
                stmt2 = conn.prepareStatement(sql2);
                stmt2.setInt(1, address.getCustomerCode());
                stmt2.executeUpdate();
            }

            // 3) 새 주소 추가
            stmt3 = conn.prepareStatement(sql3);
            stmt3.setInt(1, address.getCustomerCode());
            stmt3.setString(2, address.getAddress());
            stmt3.executeUpdate();

            conn.commit();

        } catch (SQLException e) {
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            e.printStackTrace();

        } finally {
            try {
                if (rs1 != null) rs1.close();
                if (stmt1 != null) stmt1.close();
                if (stmt2 != null) stmt2.close();
                if (stmt3 != null) stmt3.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
