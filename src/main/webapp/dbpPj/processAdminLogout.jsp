<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
    HttpSession session1 = request.getSession(false);
    if (session1 != null) {
        session1.removeAttribute("isAdmin"); // 관리자 모드 해제
%>
        <script type="text/javascript">
            alert("관리자모드가 해제되었습니다.");
            window.location.href = "welcome.jsp";
        </script>
<%
    } else {
%>
        <c:redirect url="welcome.jsp" />
<%
    }
%>
