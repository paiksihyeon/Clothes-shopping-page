<%@ page
    import="java.util.*, java.sql.*, java.io.*, dbpPj.MemberDAO, dbpPj.Member"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%
    String sessionId = (String) session.getAttribute("sessionId");
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
    if (sessionId == null) {
        String message = "로그인을 하시오.";
        String encodedMessage = URLEncoder.encode(message, "UTF-8");
        response.sendRedirect("login.jsp?message=" + encodedMessage);
        return;
    }
    if (isAdmin == null || !isAdmin) {
        response.sendRedirect("/dbpPj/manager.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<title>Member Control</title>
<link rel="stylesheet" href="./css/memberControl.css">
<link rel="stylesheet"
    href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
    <jsp:include page="menu.jsp" />
    <div class="container">
        <h1 class="form-signin-heading">회원 정보 수정</h1>
        <table class="table table-striped">
            <tr>
                <th>Name</th>
                <th>Username</th>
                <th>Password</th>
                <th>Actions</th>
            </tr>
            <%
                try {
                    MemberDAO memberDAO = new MemberDAO();
                    List<Member> members = memberDAO.getAllMembers();
                    for (Member member : members) {
            %>
            <tr>
                <td><%= member.getName() %></td>
                <td><%= member.getUsername() %></td>
                <td><%= member.getPassword() %></td>
                <td>
                    <form action="memberControl.jsp" method="post" style="display: inline;">
                        <input type="hidden" name="action" value="delete"> 
                        <input type="hidden" name="username" value="<%= member.getUsername() %>">
                        <input type="submit" value="Delete" class="styled-button delete-button">
                    </form>
                    <form action="updateMember.jsp" method="get" style="display: inline;">
                        <input type="hidden" name="username" value="<%= member.getUsername() %>">
                        <input type="submit" value="Update" class="styled-button update-button">
                    </form>
                </td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                    StringWriter sw = new StringWriter();
                    e.printStackTrace(new PrintWriter(sw));
                    out.println("<pre>" + sw.toString() + "</pre>");
                }
            %>
        </table>

        <h1 class="form-signin-heading">회원 추가</h1>
        <form action="memberControl.jsp" method="post" class="form-container">
            <input type="hidden" name="action" value="add"> 
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" class="form-control">
            </div>
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" class="form-control">
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" class="form-control">
            </div>
            <input type="submit" value="Add Member" class="styled-button">
        </form>

        <%
            String action = request.getParameter("action");
            if (action != null) {
                try {
                    MemberDAO memberDAO = new MemberDAO();
                    if (action.equals("add")) {
                        String name = request.getParameter("name");
                        String username = request.getParameter("username");
                        String password = request.getParameter("password");
                        if (name != null && username != null && password != null) {
                            Member newMember = new Member(name, username, password);
                            memberDAO.addMember(newMember);
                            response.sendRedirect("memberControl.jsp");
                        }
                    } else if (action.equals("delete")) {
                        String username = request.getParameter("username");
                        if (username != null) {
                            memberDAO.deleteMember(username);
                            response.sendRedirect("memberControl.jsp");
                        }
                    }
                } catch (Exception e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                    StringWriter sw = new StringWriter();
                    e.printStackTrace(new PrintWriter(sw));
                    out.println("<pre>" + sw.toString() + "</pre>");
                }
            }
        %>
    </div>
</body>
</html>
