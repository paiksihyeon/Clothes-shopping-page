<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String sessionId = (String) session.getAttribute("sessionId");
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin"); 
    Boolean loginSuccess = (Boolean) session.getAttribute("loginSuccess");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Navigation Bar</title>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="./css/menu.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light">
        <div class="container-fluid">
            <a class="navbar-brand" href="./welcome.jsp">Home</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse"
                data-target="#navbarColor03" aria-controls="navbarColor03"
                aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarColor03">
                <ul class="navbar-nav mr-auto">
                     <c:choose>
                        <c:when test="${empty sessionId}">
                            <li class="nav-item"><a class="nav-link" href="<c:url value='./login.jsp'/>">로그인</a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="nav-link" href="<c:url value='./changePassword.jsp'/>">
                                    ${sessionId}님
                                    <c:if test="${isAdmin}">
                                        [관리자 모드]
                                    </c:if>
                                </a>
                            </li>
                            <li class="nav-item"><a class="nav-link" href="<c:url value='./processLogout.jsp'/>">로그아웃</a></li>
                        </c:otherwise>
                    </c:choose>
                    <li class="nav-item"><a class="nav-link" href="./productInfoList.jsp">카테고리</a></li>
                    <li class="nav-item"><a class="nav-link" href="./shoppingCart.jsp">장바구니</a></li>
                    <li class="nav-item dropdown"><a class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
                        role="button" data-toggle="dropdown" aria-expanded="false"> 기타 </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="manager.jsp">관리자 모드</a>
                            <a class="dropdown-item" href="addProduct.jsp">제품 추가</a>
                            <a class="dropdown-item" href="productChange.jsp">제품 수정</a>
                            <a class="dropdown-item" href="memberControl.jsp">회원 관리</a>
                        </div>
                    </li>
                </ul>
                <form class="form-inline my-2 my-lg-0" action="${pageContext.request.contextPath}/searchProduct" method="post">
                    <input class="form-control mr-sm-2" type="search" name="query" placeholder="Search">
                    <button class="btn btn-secondary my-2 my-sm-0" type="submit">Search</button>
                </form>
            </div>
        </div>
    </nav>

    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
