package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.Address;

public class AddressDao {

    // 기존 insertAddress 그대로
    public void insertAddress(Address address) {
        Connection conn = null;
        PreparedStatement stmt1 = null;
        PreparedStatement stmt2 = null;
        PreparedStatement stmt3 = null;
        ResultSet rs1 = null;

        String sql1 = "SELECT COUNT(*) FROM address WHERE customer_code = ?";
        String sql2 = "DELETE FROM address WHERE address_code = "
                    + "(SELECT MIN(address_code) FROM address WHERE customer_code = ?)";
        String sql3 = "INSERT INTO address(address_code, customer_code, address, createdate) "
                    + "VALUES(seq_address.nextval, ?, ?, SYSDATE)";

        try {
            conn = DBConnection.getConn();
            conn.setAutoCommit(false);

            stmt1 = conn.prepareStatement(sql1);
            stmt1.setInt(1, address.getCustomerCode());
            rs1 = stmt1.executeQuery();
            rs1.next();
            int cnt = rs1.getInt(1);

            if (cnt >= 5) {
                stmt2 = conn.prepareStatement(sql2);
                stmt2.setInt(1, address.getCustomerCode());
                stmt2.executeUpdate();
            }

            stmt3 = conn.prepareStatement(sql3);
            stmt3.setInt(1, address.getCustomerCode());
            stmt3.setString(2, address.getAddress());
            stmt3.executeUpdate();

            conn.commit();

        } catch (SQLException e) {
            try { if (conn != null) conn.rollback(); } catch (SQLException e1) { e1.printStackTrace(); }
            e.printStackTrace();
        } finally {
            try {
                if (rs1 != null) rs1.close();
                if (stmt1 != null) stmt1.close();
                if (stmt2 != null) stmt2.close();
                if (stmt3 != null) stmt3.close();
                if (conn != null) conn.close();
            } catch (SQLException e) { e.printStackTrace(); }
        }
    }

    // 1️고객의 모든 주소 조회
    public List<Address> selectAddressList(int customerCode) {
        List<Address> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        String sql = "SELECT address_code, address, createdate "
                   + "FROM address WHERE customer_code = ? ORDER BY address_code DESC";

        try {
            conn = DBConnection.getConn();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, customerCode);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Address addr = new Address();
                addr.setAddressCode(rs.getInt("address_code"));
                addr.setAddress(rs.getString("address"));
                addr.setCreatedate(rs.getString("createdate"));
                list.add(addr);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); if (stmt != null) stmt.close(); if (conn != null) conn.close(); }
            catch (SQLException e) { e.printStackTrace(); }
        }

        return list;
    }

    // 2️ 특정 주소 삭제
    public void deleteAddress(int addressCode) {
        Connection conn = null;
        PreparedStatement stmt = null;
        String sql = "DELETE FROM address WHERE address_code = ?";

        try {
            conn = DBConnection.getConn();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, addressCode);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try { if (stmt != null) stmt.close(); if (conn != null) conn.close(); }
            catch (SQLException e) { e.printStackTrace(); }
        }
    }
}
