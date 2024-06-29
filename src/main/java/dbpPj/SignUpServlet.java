package dbpPj;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dbpPj.Member;

@WebServlet("/signUpServlet")
public class SignUpServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html; charset=UTF-8");
        
        PrintWriter out = response.getWriter();
        
        String name = request.getParameter("name");
        String username = request.getParameter("id");
        String password1 = request.getParameter("password");

        if (name != null && username != null && password1 != null) {
            String dbURL = "jdbc:h2:tcp://localhost/~/jwbookdb";
            String dbUser = "jwbook";
            String dbPassword = "1234";

            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                Class.forName("org.h2.Driver");
                conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                // 사용자 이름 중복 확인
                String checkUserSQL = "SELECT COUNT(*) FROM members WHERE username = ?";
                pstmt = conn.prepareStatement(checkUserSQL);
                pstmt.setString(1, username);
                rs = pstmt.executeQuery();
                if (rs.next() && rs.getInt(1) > 0) {
                	out.println("<script>alert('회원가입 실패: 이미 존재하는 사용자 이름입니다.'); location.href='/dbpPj/signUp.jsp';</script>");
                } else {
                    // 사용자 정보 삽입
                    String insertUserSQL = "INSERT INTO members (name, username, password) VALUES (?, ?, ?)";
                    pstmt = conn.prepareStatement(insertUserSQL);
                    pstmt.setString(1, name);
                    pstmt.setString(2, username);
                    //pstmt.setString(3, hashedPassword);
                    pstmt.setString(3, password1);

                    int row = pstmt.executeUpdate();
                    
                    if (row > 0) {
                        out.println("<script>alert('회원가입 성공'); location.href='/dbpPj/login.jsp';</script>");
                    } else {
                        out.println("<script>alert('회원가입 실패'); location.href='/dbpPj/signUp.jsp';</script>");
                    }
                }
            } catch (Exception e) {
                out.println("<script>alert('회원가입 실패: " + e.getMessage() + "'); location.href='/dbpPj/signUp.jsp';</script>");
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    out.println("<script>alert('회원가입 실패: 데이터베이스 오류'); location.href='/dbpPj/signUp.jsp';</script>");
                }
            }
        } else {
            out.println("<script>alert('회원가입 실패: 입력값이 올바르지 않습니다.'); location.href='/dbpPj/signUp.jsp';</script>");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}