<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="dbpPj.Product"%>
<%@ page import="java.util.Date"%>
<%
String sessionId = (String) session.getAttribute("sessionId");
Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
Boolean loginSuccess = (sessionId != null);
%>
<html>
<head>
<link rel="stylesheet" href="./css/welcome.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>Welcome 사용자 페이지</title>
<script>
	window.onload = function() {
<%if (loginSuccess) {%>
	
<%if (Boolean.TRUE.equals(isAdmin)) {%>
	alert("관리자 모드 성공");
<%} else {%>
	alert("로그인 성공");
<%}%>
	
<%}%>
	}
</script>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<div class="display-box">
		<div class="display-3">
			<h2>
				<span class="session-name"><%=sessionId%></span>
				<% if (Boolean.TRUE.equals(isAdmin)) { %>
				님[관리자 모드] 환영합니다.
				<% } else { %>
				님 환영합니다.
				<% } %>
			</h2>
		</div>
	</div>
	<img src="./img/slide01.jpeg" class="img-slide1">
	<div class="container">
		<div class="text-center">
			<h4>Welcome to Clothing Shopping Mall!</h4>
			<%!int pageCount = 0;

	void addCount() {
		pageCount++;
	}%>
			<%
			addCount();
			%>
			<p>
				이 사이트 로그인 사용자로는 <span style="color: red"> <%=pageCount%>
				</span> 번째 입니다.
			</p>
		</div>
		<hr>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>
