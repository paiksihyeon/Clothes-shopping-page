<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="dbpPj.MemberDAO, dbpPj.Member" %>

<%
    String sessionId = (String) session.getAttribute("sessionId");

    MemberDAO memberDAO = new MemberDAO();
    Member member = null;

    if (sessionId != null) {
        try {
            member = memberDAO.getMember(sessionId);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>계정 정보 수정</title>
<link rel="stylesheet" href="./css/login.css">
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="menu.jsp" />
    <div class="container" align="center">
		<div class="col-md-4 col-md-offset-4">
        <h1 class="form-signin-heading">계정 정보 수정</h1>
        <c:if test="${param.success == 'true'}">
            <div class="alert alert-success" role="alert">
                수정이 성공하였습니다.
            </div>
        </c:if>
        <form action="processChangePassword.jsp" method="post">
            <div class="form-group" align="Left">
                <label for="name">이름</label>
                <input type="text" class="form-control" id="name" name="name" value="<%= member != null ? member.getName() : "" %>" required>
            </div>
            <div class="form-group" align="Left">
                <label for="username">아이디</label>
                <input type="text" class="form-control" id="username" name="username" value="<%= member != null ? member.getUsername() : "" %>" readonly>
            </div>
            <div class="form-group" align="Left">
                <label for="password">비밀번호</label>
                <input type="password" class="form-control" id="password" name="password" value="<%= member != null ? member.getPassword() : "" %>" required>
            </div>
            <button class="btn btn-login" type="submit">수정</button>
        </form>
    </div>
 </div>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>