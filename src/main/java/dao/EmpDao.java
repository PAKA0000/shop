package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import dto.Emp;

public class EmpDao extends DBConnection {
    // 사원목록
    public List<Emp> selectEmpListByPage(int beginRow, int rowPerPage) throws SQLException {

        List<Emp> list = new ArrayList<>();

        String sql = """
                SELECT emp_code empCode,
                       emp_id empId,
                       emp_name empName,
                       active,
                       createdate
                  FROM emp
                 ORDER BY emp_code
                 OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
                """;

        try (Connection conn = getConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, beginRow);
            stmt.setInt(2, rowPerPage);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Emp emp = new Emp();
                    emp.setEmpCode(rs.getInt("empCode"));
                    emp.setEmpId(rs.getString("empId"));
                    emp.setEmpName(rs.getString("empName"));
                    emp.setActive(rs.getInt("active"));
                    emp.setCreatedate(rs.getString("createdate"));
                    list.add(emp);
                }
            }
        }

        return list;
    }

    // 직원 추가 (INSERT)
    public int insertEmp(Emp e) {
        String sql = "INSERT INTO emp (emp_code, emp_id, emp_pw, emp_name, active, createdate) "
                   + "VALUES (?, ?, ?, ?, ?, SYSDATE)";
        int row = 0;

        try (Connection conn = getConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, e.getEmpCode());
            stmt.setString(2, e.getEmpId());
            stmt.setString(3, e.getEmpPw()); 
            stmt.setString(4, e.getEmpName());
            stmt.setInt(5, e.getActive());

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
                e.setActive(rs.getInt("active"));
                e.setCreatedate(rs.getString("createdate"));
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return e; 
    }

   
    // 직원 활성/비활성 상태 반전 
    public int toggleActive(String id) {
        String sql = "UPDATE emp SET active = CASE WHEN active = 1 THEN 0 ELSE 1 END WHERE emp_id = ?";
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

    // 직원목록페이징
    public int selectEmpCount() throws SQLException {
        String sql = "SELECT COUNT(*) FROM emp";
        try (Connection conn = getConn();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }
  
    	
    // 사원 정보 수정
    public int updateEmp(Emp emp) throws SQLException {
        String sql = """
            UPDATE emp
               SET emp_name = ?, active = ?
             WHERE emp_id = ?
        """;
        try (Connection conn = getConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, emp.getEmpName());
            stmt.setInt(2, emp.getActive());
            stmt.setString(3, emp.getEmpId());
            return stmt.executeUpdate();
        }
    }


    //사원정보 삭제	

    public int deleteEmp(String empId) throws SQLException {
        String sql = "DELETE FROM emp WHERE emp_id = ?";
        try (Connection conn = getConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, empId);
            return stmt.executeUpdate();
        }
    }

    public Emp selectEmpById(String empId) throws SQLException {
        Emp emp = null;

        String sql = "SELECT emp_id, emp_name, active FROM emp WHERE emp_id = ?";

        try (Connection conn = getConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, empId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    emp = new Emp();
                    emp.setEmpId(rs.getString("emp_id"));
                    emp.setEmpName(rs.getString("emp_name"));
                    emp.setActive(rs.getInt("active"));
                }
            }
        }

        return emp; 
    }
    
    //중복아이디 사용불가
    public String selectEmpCk(String id) throws SQLException {
        String sql = """
            SELECT t.id
            FROM (
                SELECT customer_id AS id FROM customer
                UNION ALL
                SELECT emp_id AS id FROM emp
                UNION ALL
                SELECT id FROM outid
            ) t
            WHERE t.id = ?
        """;

        try (Connection conn = getConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("id"); // 존재하면 해당 ID 반환
                } else {
                    return null; // 존재하지 않으면 null
                }
            }
        }
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
