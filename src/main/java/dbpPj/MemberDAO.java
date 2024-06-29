package dbpPj;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MemberDAO {
    final String JDBC_DRIVER = "org.h2.Driver";
    final String JDBC_URL = "jdbc:h2:tcp://localhost/~/jwbookdb";

    public Connection open() {
        Connection conn = null;
        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(JDBC_URL, "jwbook", "1234");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }

    public List<Member> getAllMembers() {
        List<Member> members = new ArrayList<>();
        String query = "SELECT * FROM MEMBERS";

        try (Connection conn = open();
             PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                Member member = new Member();
                member.setName(rs.getString("NAME"));
                member.setUsername(rs.getString("USERNAME"));
                member.setPassword(rs.getString("PASSWORD"));
                members.add(member);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return members;
    }

    public void addMember(Member member) {
        String query = "INSERT INTO MEMBERS (NAME, USERNAME, PASSWORD) VALUES (?, ?, ?)";

        try (Connection conn = open();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, member.getName());
            pstmt.setString(2, member.getUsername());
            pstmt.setString(3, member.getPassword());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteMember(String username) {
        String query = "DELETE FROM MEMBERS WHERE USERNAME = ?";

        try (Connection conn = open();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, username);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Member getMember(String username) {
        Member member = null;
        String query = "SELECT * FROM MEMBERS WHERE USERNAME = ?";

        try (Connection conn = open();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, username);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    member = new Member();
                    member.setName(rs.getString("NAME"));
                    member.setUsername(rs.getString("USERNAME"));
                    member.setPassword(rs.getString("PASSWORD"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return member;
    }

    public Member getMemberByUsername(String username) {
        Member member = null;
        String query = "SELECT * FROM MEMBERS WHERE USERNAME = ?";

        try (Connection conn = open();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, username);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    member = new Member();
                    member.setName(rs.getString("NAME"));
                    member.setUsername(rs.getString("USERNAME"));
                    member.setPassword(rs.getString("PASSWORD"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return member;
    }

    // updateMember 메소드 추가
    public void updateMember(Member member) {
        String query = "UPDATE MEMBERS SET NAME = ?, PASSWORD = ? WHERE USERNAME = ?";

        try (Connection conn = open();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, member.getName());
            pstmt.setString(2, member.getPassword()); // 비밀번호는 해싱하지 않고 그대로 저장
            pstmt.setString(3, member.getUsername());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
