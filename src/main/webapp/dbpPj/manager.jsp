<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="javax.servlet.ServletContext"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.net.URLEncoder"%>
<%
    String sessionId = (String) session.getAttribute("sessionId");
    String adminPassword = "1234";
    String message = "";

    if (sessionId == null) {
        message = "로그인을 하시오.";
        String encodedMessage = URLEncoder.encode(message, "UTF-8");
        response.sendRedirect("login.jsp?message=" + encodedMessage);
        return;
    }

    if (request.getMethod().equalsIgnoreCase("POST") && request.getParameter("password") != null) {
        String enteredPassword = request.getParameter("password");
        if (adminPassword.equals(enteredPassword)) {
            session.setAttribute("isAdmin", true);
            response.sendRedirect("welcomeUser.jsp");
            return;
        } else {
            message = "비밀번호가 틀렸습니다.";
        }
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./css/login.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>관리자 모드 로그인</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<div class="container" align="center">
		<div class="col-md-4 col-md-offset-4">
			<h1 class="form-signin-heading">관리자 모드 로그인</h1>
			<form method="post" action="manager.jsp">
				<div class="form-group" align="left">
					<label for="password">관리자 비밀번호:</label> <input type="password"
						class="form-control" id="password" name="password" required>
				</div>
				<button type="submit" class="btn btn-login">로그인</button>
			</form>
			<form method="post" action="processAdminLogout.jsp">
				<button type="submit" class="btn btn-signup">관리자 모드 해제</button>
			</form>
			<c:if test="${not empty message}">
				<div class="alert alert-danger mt-3">${message}</div>
			</c:if>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
