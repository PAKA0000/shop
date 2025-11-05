package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import dto.Outid;

public class OutidDao extends DBConnection {

    // 전체 탈퇴 회원 목록
    public List<Outid> selectOutidList() throws SQLException {
        List<Outid> list = new ArrayList<>();
        String sql = "SELECT * FROM outid ORDER BY createdate DESC";

        try (Connection conn = getConn();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Outid o = new Outid();
                o.setId(rs.getString("id"));
                o.setMemo(rs.getString("memo"));
                o.setCreatedate(rs.getString("createdate"));
                list.add(o);
            }
        }

        return list;
    }
}
