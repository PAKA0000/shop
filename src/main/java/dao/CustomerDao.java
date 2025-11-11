package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import dto.Customer;
import dto.Outid;

public class CustomerDao extends DBConnection {

    // 직원에 의한 강제탈퇴
    public void deleteCustomerByEmp(Outid outid) throws SQLException {
        Connection conn = null;
        PreparedStatement psmtCustomer = null;
        PreparedStatement psmtOutId = null;

        String sqlCustomer = "DELETE FROM customer WHERE customer_id=?";
        String sqlOutid = "INSERT INTO outid(id, memo, createdate) VALUES(?, ?, SYSDATE)";

        try {
            conn = DBConnection.getConn();
            conn.setAutoCommit(false);

            psmtCustomer = conn.prepareStatement(sqlCustomer);
            psmtCustomer.setString(1, outid.getId());
            int row = psmtCustomer.executeUpdate();

            if (row == 1) {
                psmtOutId = conn.prepareStatement(sqlOutid);
                psmtOutId.setString(1, outid.getId());
                psmtOutId.setString(2, outid.getMemo());
                psmtOutId.executeUpdate();
            } else {
                throw new SQLException("해당 고객이 존재하지 않습니다");
            }

            conn.commit();

        } catch (SQLException e) {
            if (conn != null) conn.rollback();
            if (e.getMessage().contains("ORA-00001")) {
                throw new SQLException("이미 탈퇴 처리된 고객입니다.");
            }
            throw e;
        } finally {
            if (psmtOutId != null) psmtOutId.close();
            if (psmtCustomer != null) psmtCustomer.close();
            if (conn != null) conn.close();
        }
    }

    // 직원 로그인 시 전체 고객 리스트 확인 (페이징 포함)
    public List<Customer> selectCustomerList(int beginRow, int rowPerPage) throws SQLException {
        List<Customer> list = new ArrayList<>();
        String sql = """
                SELECT customer_code, customer_id, customer_pw, customer_name, customer_phone, point, createdate
                FROM customer
                ORDER BY createdate DESC
                OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
            """;

        try (Connection conn = getConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, beginRow);
            stmt.setInt(2, rowPerPage);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Customer c = new Customer();
                c.setCustomerCode(rs.getInt("customer_code"));
                c.setCustomerId(rs.getString("customer_id"));
                c.setCustomerPw(rs.getString("customer_pw"));
                c.setCustomerName(rs.getString("customer_name"));
                c.setCustomerPhone(rs.getString("customer_phone")); // ⚠ String으로 변경
                c.setPoint(rs.getInt("point"));
                c.setCreatedate(rs.getString("createdate"));
                list.add(c);
            }
        }
        return list;
    }

    // ID 사용 가능 여부 확인
    public String selectCustomerCk(String id) throws SQLException {
        String sql = "SELECT t.id " +
                     "FROM ( " +
                     "  SELECT customer_id AS id FROM customer " +
                     "  UNION ALL " +
                     "  SELECT emp_id AS id FROM emp " +
                     "  UNION ALL " +
                     "  SELECT id FROM outid " +
                     ") t " +
                     "WHERE t.id = ?";

        try (Connection conn = getConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) return rs.getString("id"); // ⚠ 컬럼명 수정
            }
        }
        return null; // 없으면 null 반환 → 사용 가능
    }

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
            stmt.setString(5, c.getCustomerPhone()); // ⚠ String으로 변경
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
                c.setCustomerPhone(rs.getString("customer_phone")); // ⚠ String
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
                c.setCustomerPhone(rs.getString("customer_phone")); // ⚠ String
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
                c.setCustomerPhone(rs.getString("customer_phone")); // ⚠ String
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
            stmt.setString(3, c.getCustomerPhone()); // ⚠ String
            stmt.setString(4, c.getCustomerId());

            row = stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return row;
    }

    public int selectCustomerCount() throws SQLException {
        String sql = "SELECT COUNT(*) FROM customer";
        try (Connection conn = getConn();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if(rs.next()) return rs.getInt(1);
        }
        return 0;
    }
 //  updateCustomerWithHistory 그대로 사용
    public int updateCustomerWithHistory(Customer c) throws SQLException {
        String sqlUpdate = "UPDATE customer SET customer_pw = ?, customer_name = ?, customer_phone = ? WHERE customer_id = ?";
        String sqlHistory = "INSERT INTO pw_history(customer_code, pw, createdate) VALUES (?, ?, SYSDATE)";
        
        try (Connection conn = getConn()) {
            conn.setAutoCommit(false);
            try (PreparedStatement stmtUpdate = conn.prepareStatement(sqlUpdate);
                 PreparedStatement stmtHistory = conn.prepareStatement(sqlHistory)) {

                // customer 업데이트
                stmtUpdate.setString(1, c.getCustomerPw());
                stmtUpdate.setString(2, c.getCustomerName());
                stmtUpdate.setString(3, c.getCustomerPhone());
                stmtUpdate.setString(4, c.getCustomerId());
                int row = stmtUpdate.executeUpdate();

                // pw_history 기록
                stmtHistory.setString(1, c.getCustomerId());
                stmtHistory.setString(2, c.getCustomerPw());
                stmtHistory.executeUpdate();

                conn.commit();
                return row;
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            }
        }
    }

    }

