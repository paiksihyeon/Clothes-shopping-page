package dbpPj;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username"); // JSP에서 받아오는 name 값을 확인
        String password = request.getParameter("password"); // JSP에서 받아오는 name 값을 확인

        String dbURL = "jdbc:h2:tcp://localhost/~/jwbookdb";
        String dbUser = "jwbook";
        String dbPassword = "1234";

        try {
            Class.forName("org.h2.Driver");
        } catch (ClassNotFoundException e) {
            throw new ServletException("Unable to load JDBC Driver", e);
        }

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
            String checkUserSQL = "SELECT * FROM MEMBERS WHERE USERNAME = ? AND PASSWORD = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(checkUserSQL)) {
                pstmt.setString(1, username);
                pstmt.setString(2, password);
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        HttpSession session = request.getSession();
                        session.setAttribute("sessionId", username);
                        session.setAttribute("name", rs.getString("NAME"));
                        session.setAttribute("isAdmin", checkAdmin(username));
                        session.setAttribute("loginSuccess", true);

                        response.sendRedirect("/dbpPj/welcomeUser.jsp");
                    } else {
                        String message = URLEncoder.encode("로그인 실패: 아이디 또는 비밀번호가 올바르지 않습니다.", StandardCharsets.UTF_8.toString());
                        response.sendRedirect("/dbpPj/login.jsp?message=" + message);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            String message = URLEncoder.encode("로그인 실패: 데이터베이스 오류가 발생했습니다.", StandardCharsets.UTF_8.toString());
            response.sendRedirect("/dbpPj/login.jsp?message=" + message);
        }
    }

    private boolean checkAdmin(String username) {
        return "admin".equals(username);
    }
}
