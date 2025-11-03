package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import dto.Customer;

public class CustomerDao extends DBConnection {

    // 회원 가입 (INSERT)
    public int insertCustomer(Customer c) {
        String sql = "INSERT INTO customer (customer_code, customer_id, customer_pw, customer_name, customer_phone, point, createdate) "
                   + "VALUES (?, ?, ?, ?, ?, ?, SYSDATE)";
        int row = 0;

        try (Connection conn = getConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, c.getCustomerCode());
            stmt.setString(2, c.getCustomerId());
            stmt.setString(3, c.getCustomerPw());
            stmt.setString(4, c.getCustomerName());
            stmt.setInt(5, c.getCustomerPhone());
            stmt.setInt(6, c.getPoint());

            row = stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return row;
    }

    // 로그인 (ID & PW로 회원 조회)
    public Customer login(String id, String pw) {
        String sql = "SELECT * FROM customer WHERE customer_id = ? AND customer_pw = ?";
        Customer c = null;

        try (Connection conn = getConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, id);
            stmt.setString(2, pw);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                c = new Customer();
                c.setCustomerCode(rs.getInt("customer_code"));
                c.setCustomerId(rs.getString("customer_id"));
                c.setCustomerPw(rs.getString("customer_pw"));
                c.setCustomerName(rs.getString("customer_name"));
                c.setCustomerPhone(rs.getInt("customer_phone"));
                c.setPoint(rs.getInt("point"));
                c.setCreatedate(rs.getString("createdate"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return c; 
    }

    // 전체 회원 목록 (SELECT)
    public List<Customer> selectCustomerList() {
        List<Customer> list = new ArrayList<>();
        String sql = "SELECT * FROM customer ORDER BY createdate DESC";

        try (Connection conn = getConn();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Customer c = new Customer();
                c.setCustomerCode(rs.getInt("customer_code"));
                c.setCustomerId(rs.getString("customer_id"));
                c.setCustomerPw(rs.getString("customer_pw"));
                c.setCustomerName(rs.getString("customer_name"));
                c.setCustomerPhone(rs.getInt("customer_phone"));
                c.setPoint(rs.getInt("point"));
                c.setCreatedate(rs.getString("createdate"));
                list.add(c);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    // 특정 회원 조회 (ID 기반)
    public Customer selectCustomerById(String id) {
        String sql = "SELECT * FROM customer WHERE customer_id = ?";
        Customer c = null;

        try (Connection conn = getConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                c = new Customer();
                c.setCustomerCode(rs.getInt("customer_code"));
                c.setCustomerId(rs.getString("customer_id"));
                c.setCustomerPw(rs.getString("customer_pw"));
                c.setCustomerName(rs.getString("customer_name"));
                c.setCustomerPhone(rs.getInt("customer_phone"));
                c.setPoint(rs.getInt("point"));
                c.setCreatedate(rs.getString("createdate"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return c;
    }

    // 회원 정보 수정 (비밀번호, 이름, 전화번호)
    public int updateCustomer(Customer c) {
        String sql = "UPDATE customer SET customer_pw = ?, customer_name = ?, customer_phone = ? WHERE customer_id = ?";
        int row = 0;

        try (Connection conn = getConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, c.getCustomerPw());
            stmt.setString(2, c.getCustomerName());
            stmt.setInt(3, c.getCustomerPhone());
            stmt.setString(4, c.getCustomerId());

            row = stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return row;
    }

    // 회원 삭제
    public int deleteCustomer(String id) {
        String sql = "DELETE FROM customer WHERE customer_id = ?";
        int row = 0;

        try (Connection conn = getConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, id);
            row = stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return row;
    }
}
