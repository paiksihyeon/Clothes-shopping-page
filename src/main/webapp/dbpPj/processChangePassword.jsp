<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="dbpPj.MemberDAO, dbpPj.Member" %>

<%
    request.setCharacterEncoding("UTF-8");

    String name = request.getParameter("name");
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    MemberDAO memberDAO = new MemberDAO();
    Member member = new Member(name, username, password);

    try {
        memberDAO.updateMember(member);
        response.sendRedirect("changePassword.jsp?success=true");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("changePassword.jsp?success=false");
    }
%>
