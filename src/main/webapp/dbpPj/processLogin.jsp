<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*"%>

<%
    request.setCharacterEncoding("UTF-8");

    String username = request.getParameter("id");
    String password = request.getParameter("password");

    String dbURL = "jdbc:h2:tcp://localhost/~/jwbookdb";
    String dbUser = "jwbook";
    String dbPassword = "1234";

    HttpSession session1 = request.getSession(); 

    try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
        String checkUserSQL = "SELECT * FROM members WHERE username = ? AND password = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(checkUserSQL)) {
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    session1.setAttribute("sessionId", username);
                    response.sendRedirect("welcomeUser.jsp");
                } else {
                    request.setAttribute("loginFailedMessage", "로그인 실패: 아이디 또는 비밀번호가 올바르지 않습니다.");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
                    dispatcher.forward(request, response);
                }
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
        request.setAttribute("loginFailedMessage", "로그인 실패: 데이터베이스 오류가 발생했습니다.");
        RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
        dispatcher.forward(request, response);
    }
%>