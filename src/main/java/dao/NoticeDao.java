package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dto.Notice;

public class NoticeDao {

    // 공지사항 목록
    public List<Notice> selectNoticeList(int beginRow, int rowPerPage) {
        List<Notice> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = """
            SELECT notice_code noticeCode,
                   notice_title noticeTitle,
                   createdate
            FROM notice
            ORDER BY notice_code DESC
            OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
        """;
        try {
            conn = DBConnection.getConn();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, beginRow);
            stmt.setInt(2, rowPerPage);
            rs = stmt.executeQuery();
            while(rs.next()) {
                Notice n = new Notice();
                n.setNoticeCode(rs.getInt("noticeCode"));
                n.setNoticeTitle(rs.getString("noticeTitle"));
                n.setCreatedate(rs.getString("createdate"));
                list.add(n);
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            try { if(rs != null) rs.close(); if(stmt != null) stmt.close(); if(conn != null) conn.close(); } catch(Exception e2) { e2.printStackTrace(); }
        }
        return list;
    }

    // 공지사항 총 개수
    public int selectCount() {
        int count = 0;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "SELECT COUNT(*) FROM notice";
        try {
            conn = DBConnection.getConn();
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            if(rs.next()) {
                count = rs.getInt(1);
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            try { if(rs != null) rs.close(); if(stmt != null) stmt.close(); if(conn != null) conn.close(); } catch(Exception e2) { e2.printStackTrace(); }
        }
        return count;
    }

    // 공지사항 등록
    public int insertNotice(Notice n) {
        int row = 0;
        Connection conn = null;
        PreparedStatement stmt = null;
        String sql = """
            INSERT INTO notice (notice_code, notice_title, notice_content, emp_code, createdate)
            VALUES (seq_notice.NEXTVAL, ?, ?, ?, SYSDATE)
        """;
        try {
            conn = DBConnection.getConn();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, n.getNoticeTitle());
            stmt.setString(2, n.getNoticeContent());
            stmt.setString(3, n.getEmpCode());
            row = stmt.executeUpdate();
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            try { if(stmt != null) stmt.close(); if(conn != null) conn.close(); } catch(Exception e2) { e2.printStackTrace(); }
        }
        return row;
    }

    // 공지사항 상세 조회
    public Notice selectNoticeOne(int noticeCode) {
        Notice n = null;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = """
            SELECT notice_code noticeCode,
                   notice_title noticeTitle,
                   notice_content noticeContent,
                   emp_code empCode,
                   createdate
            FROM notice
            WHERE notice_code = ?
        """;
        try {
            conn = DBConnection.getConn();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, noticeCode);
            rs = stmt.executeQuery();
            if(rs.next()) {
                n = new Notice();
                n.setNoticeCode(rs.getInt("noticeCode"));
                n.setNoticeTitle(rs.getString("noticeTitle"));
                n.setNoticeContent(rs.getString("noticeContent"));
                n.setEmpCode(rs.getString("empCode"));
                n.setCreatedate(rs.getString("createdate"));
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            try { if(rs != null) rs.close(); if(stmt != null) stmt.close(); if(conn != null) conn.close(); } catch(Exception e2) { e2.printStackTrace(); }
        }
        return n;
    }

    // 공지사항 삭제
    public int deleteNotice(int noticeCode) {
        int row = 0;
        Connection conn = null;
        PreparedStatement stmt = null;
        String sql = "DELETE FROM notice WHERE notice_code = ?";
        try {
            conn = DBConnection.getConn();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, noticeCode);
            row = stmt.executeUpdate();
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            try { if(stmt != null) stmt.close(); if(conn != null) conn.close(); } catch(Exception e2) { e2.printStackTrace(); }
        }
        return row;
    }

    // 공지사항 수정
    public int updateNotice(Notice n) {
        int row = 0;
        Connection conn = null;
        PreparedStatement stmt = null;
        String sql = """
            UPDATE notice
            SET notice_title = ?,
                notice_content = ?
            WHERE notice_code = ?
        """;
        try {
            conn = DBConnection.getConn();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, n.getNoticeTitle());
            stmt.setString(2, n.getNoticeContent());
            stmt.setInt(3, n.getNoticeCode());
            row = stmt.executeUpdate();
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            try { if(stmt != null) stmt.close(); if(conn != null) conn.close(); } catch(Exception e2) { e2.printStackTrace(); }
        }
        return row;
    }
}
