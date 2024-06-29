<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.sql.*, org.apache.commons.codec.digest.DigestUtils"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./css/login.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>회원가입</title>
</head>
<body>
	<jsp:include page="./menu.jsp" />
	<div class="container" align="center">
		<div class="col-md-4 col-md-offset-4">
			<h1 class="form-signin-heading">정보 입력</h1>
			<form class="form-signin"
				action="${pageContext.request.contextPath}/signUpServlet"
				method="post">
				<div class="form-group">
					<label for="inputName" class="sr-only">이름</label> <input
						type="text" id="inputName" class="form-control" placeholder="이름"
						name="name" required autofocus>
				</div>
				<div class="form-group">
					<label for="inputUserName" class="sr-only">아이디</label> <input
						type="text" id="inputUserName" class="form-control"
						placeholder="아이디" name="id" required>
				</div>
				<div class="form-group">
					<label for="inputPassword" class="sr-only">비밀번호</label> <input
						type="password" id="inputPassword" class="form-control"
						placeholder="비밀번호" name="password" required>
				</div>
				<button class="btn btn-login" type="submit">회원가입</button>
			</form>
		</div>
	</div>
</body>
</html>
