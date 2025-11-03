package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import dto.Emp;

public class EmpDao extends DBConnection {

    // 직원 추가 (INSERT)
    public int insertEmp(Emp e) {
        String sql = "INSERT INTO emp (emp_code, emp_id, emp_pw, emp_name, active, createdate) "
                   + "VALUES (?, ?, ?, ?, ?, SYSDATE)";
        int row = 0;

        try (Connection conn = getConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, e.getEmpCode());
            stmt.setString(2, e.getEmpId());
            stmt.setString(3, e.getEmpPw()); // emp_pw
            stmt.setString(4, e.getEmpName());
            stmt.setString(5, e.getActive());

            row = stmt.executeUpdate();

        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return row;
    }

    // 직원 로그인 (ID & PW)
    public Emp login(String id, String pw) {
        String sql = "SELECT * FROM emp WHERE emp_id = ? AND emp_pw = ?";
        Emp e = null;

        try (Connection conn = getConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, id);
            stmt.setString(2, pw);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                e = new Emp();
                e.setEmpCode(rs.getInt("emp_code"));
                e.setEmpId(rs.getString("emp_id"));
                e.setPw(rs.getString("emp_pw")); // emp_pw
                e.setEmpName(rs.getString("emp_name"));
                e.setActive(rs.getString("active"));
                e.setCreatedate(rs.getString("createdate"));
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return e; // null이면 로그인 실패
    }

    // 전체 직원 목록 (SELECT)
    public List<Emp> selectEmpList() {
        List<Emp> list = new ArrayList<>();
        String sql = "SELECT * FROM emp ORDER BY createdate DESC";

        try (Connection conn = getConn();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Emp e = new Emp();
                e.setEmpCode(rs.getInt("emp_code"));
                e.setEmpId(rs.getString("emp_id"));
                e.setPw(rs.getString("emp_pw")); // emp_pw
                e.setEmpName(rs.getString("emp_name"));
                e.setActive(rs.getString("active"));
                e.setCreatedate(rs.getString("createdate"));
                list.add(e);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return list;
    }

    // 특정 직원 조회 (ID 기준)
    public Emp selectEmpById(String id) {
        String sql = "SELECT * FROM emp WHERE emp_id = ?";
        Emp e = null;

        try (Connection conn = getConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                e = new Emp();
                e.setEmpCode(rs.getInt("emp_code"));
                e.setEmpId(rs.getString("emp_id"));
                e.setPw(rs.getString("emp_pw")); // emp_pw
                e.setEmpName(rs.getString("emp_name"));
                e.setActive(rs.getString("active"));
                e.setCreatedate(rs.getString("createdate"));
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return e;
    }

    // 직원 정보 수정 (비밀번호, 이름, 재직 상태)
    public int updateEmp(Emp e) {
        String sql = "UPDATE emp SET emp_pw = ?, emp_name = ?, active = ? WHERE emp_id = ?";
        int row = 0;

        try (Connection conn = getConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, e.getEmpPw()); // emp_pw
            stmt.setString(2, e.getEmpName());
            stmt.setString(3, e.getActive());
            stmt.setString(4, e.getEmpId());

            row = stmt.executeUpdate();

        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return row;
    }

    // 직원 삭제 (퇴사 처리)
    public int deleteEmp(String id) {
        String sql = "DELETE FROM emp WHERE emp_id = ?";
        int row = 0;

        try (Connection conn = getConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, id);
            row = stmt.executeUpdate();

        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return row;
    }

    // 직원 활성/비활성 상태 변경 (active Y/N 토글)
    public int updateActive(String id, String active) {
        String sql = "UPDATE emp SET active = ? WHERE emp_id = ?";
        int row = 0;

        try (Connection conn = getConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, active);
            stmt.setString(2, id);
            row = stmt.executeUpdate();

        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return row;
    }
}
