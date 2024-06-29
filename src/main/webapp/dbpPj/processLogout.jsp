<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
    HttpSession session2 = request.getSession(false);
    if (session2 != null) {
        session2.invalidate(); 
%>
        <script type="text/javascript">
            alert("로그아웃이 되었습니다.");
            window.location.href = "welcome.jsp";
        </script>
<%
    } else {
%>
        <script type="text/javascript">
            window.location.href = "login.jsp";
        </script>
<%
    }
%>
