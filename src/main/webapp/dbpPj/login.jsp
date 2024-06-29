<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.sql.*, org.apache.commons.codec.digest.DigestUtils"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./css/login.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>Login</title>
</head>
<body>
	<jsp:include page="./menu.jsp" />
	<div class="container" align="center">
		<div class="col-md-4 col-md-offset-4">
			<h1 class="form-signin-heading">로그인</h1>
			<%
            String loginMessage = request.getParameter("message");
            if (loginMessage != null && !loginMessage.isEmpty()) {
        %>
			<script>
                alert("<%= loginMessage %>");
            </script>
			<%
            }
        %>

			<%
            String loginFailedMessage = (String) request.getAttribute("loginFailedMessage");
            if (loginFailedMessage != null && !loginFailedMessage.isEmpty()) { 
        %>
			<div class="alert alert-danger" role="alert">
				<%= loginFailedMessage %>
			</div>
			<% } %>

			<form class="form-signin" action="${pageContext.request.contextPath}/LoginServlet" method="post">
				<div class="form-group">
					<label for="inputUserName" class="sr-only">User Name</label> <input
						type="text" class="form-control" placeholder="아이디" name="username"
						required autofocus>
				</div>
				<div class="form-group">
					<label for="inputPassword" class="sr-only">Password</label> <input
						type="password" class="form-control" placeholder="비밀번호"
						name="password" required>
				</div>
				<button class="btn btn-login" type="submit">로그인</button>
			</form>
			<form class="form-signin" action="signUp.jsp">
				<button class="btn btn-signup" type="submit">회원가입</button>
			</form>
		</div>
	</div>
</body>
</html>
