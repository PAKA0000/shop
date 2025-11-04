package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import dto.Emp;

public class EmpDao extends DBConnection {
	// 사원목록
	public List<Emp> selectEmpListByPage(int beginRow,int rowPerPage) throws SQLException{
		
		String sql ="""
						select emp_code empCode,emp_id empId,emp_name empName,active,createdate
						FROM emp
						order by emp_code
						OFFSET  ? rows FETCH next ? ROWS only
				""";
		 try (Connection conn = getConn();
	          PreparedStatement stmt = conn.prepareStatement(sql)) {

	            stmt.setInt(1,  beginRow);
	            stmt.setInt(2, rowPerPage);
	            
	            
	          
		 }
		return null;
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
            stmt.setString(3, e.getEmpPw()); // emp_pw
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

        return e; // null이면 로그인 실패
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
