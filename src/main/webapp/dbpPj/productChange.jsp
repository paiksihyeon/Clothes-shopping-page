<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="dbpPj.Product"%>
<%@ page import="dbpPj.ProductDAO"%>
<%@ page import="java.net.URLEncoder" %>

<%
    if (session.getAttribute("sessionId") == null) {
        String message = "로그인을 하시오.";
        String encodedMessage = URLEncoder.encode(message, "UTF-8");
        response.sendRedirect("login.jsp?message=" + encodedMessage);
        return;
    }
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
    if (isAdmin == null || !isAdmin) {
        response.sendRedirect("manager.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="./css/productChange.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <title>의류 정보 목록</title>
</head>
<body>
    <jsp:include page="menu.jsp" />
    <div class="slideclass">
        <h1 class="inform-display-3">제품 수정</h1>
    </div>
    <%
        ProductDAO dao = new ProductDAO();
        ArrayList<Product> listOfProducts = (ArrayList<Product>) dao.getAll();
    %>
    <div class="container">
       <div class="row product-list" align="left">
            <%
                for (Product product : listOfProducts) {
            %>
                <div class="col-md-4 product-item">
                    <p>
                        <img src="<%=request.getContextPath() + "/" + product.getImage()%>" alt="Product Image" width="100%"> <!-- 이미지 표시 부분 추가 -->
                    </p>
                    <h5><b>제품</b> : <%=product.getPname()%></h5>
                    <p><b>가격</b> : <%=product.getUnitPrice()%>원</p>
                    <p><b>제품 설명</b> : <%=product.getDescription()%></p>
                    <p>
                        <b>의류 코드 : </b><span class="badge text-bg-primary"><%=product.getProductId()%></span>
                    </p>
                    <p>
                        <b>브랜드</b> : <%=product.getManufacturer()%>
                    </p>
                    <p>
                        <b>분류</b> : <%=product.getCategory()%>
                    </p>
                    <p>
                        <b>재고 수</b> : <%=product.getUnitsInStock()%>
                    </p>
     				<hr>
                    <div class="product-actions">
                    <form action="deleteProduct.jsp" method="post">
                        <input type="hidden" name="productId" value="<%= product.getProductId() %>">
                        <button type="submit" class="btn btn-info">삭제</button>
                    </form>
                        <a href="changeClothing.jsp?productId=<%= product.getProductId() %>" class="btn btn-secondary"> 의류 정보 수정 &raquo;</a>
                </div>
                </div>
            <%
                }
            %>
        </div>
        <hr>
    </div>
    <jsp:include page="footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</body>
</html>
