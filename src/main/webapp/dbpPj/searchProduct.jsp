<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="dbpPj.Product" %>
<%@ page import="dbpPj.ProductDAO" %>
<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>검색 결과</title>
    <link rel="stylesheet" href="./css/footer.css">
    <link rel="stylesheet" href="./css/searchProduct.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
<jsp:include page="menu.jsp" />
<div class="container">
    <h1 class="inform-display-3">검색 결과</h1>

    <%
        List<Product> products = (List<Product>) session.getAttribute("products");
        if (products != null && !products.isEmpty()) {
            for (Product product : products) {
    %>
                <div class="container">
        <div class="row product-list" align="center">
            <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
            %>
            <div class="alert alert-danger" role="alert">
                <%=errorMessage%>
            </div>
            <%
            }
            %>
            <div class="col-md-4 product-item" align="left">
                <p class="product-image">
                    <img src="<%=request.getContextPath() + "/" + product.getImage()%>"
                        alt="Product Image" width="100%">
                </p>
                <h4 class="product-name">
                    <b>제품 이름</b> :
                    <%=product.getPname()%>
                </h4>
                <p class="product-brand">
                    <b>브랜드</b> :
                    <%=product.getManufacturer()%>
                </p>
                <p class="product-category">
                    <b>분류</b> :
                    <%=product.getCategory()%>
                </p>
                <p class="product-price">
                    <b>가격</b> :
                    <%=product.getUnitPrice()%>원
                </p>
                <hr>
                <div class="product-actions">
                    <a href="productInfo.jsp?productId=<%= product.getProductId() %>"
                        class="btn btn-info"> 자세히 보기 &raquo;</a>
                    <form id="addToCartForm_<%=product.getProductId()%>"
                        action="<%=request.getContextPath()%>/AddToCartServlet"
                        method="post">
                        <input type="hidden" name="username"
                            value="<%=request.getSession().getAttribute("username")%>">
                        <input type="hidden" name="productId"
                            value="<%=product.getProductId()%>"> <input type="hidden"
                            name="quantity" value="1">
                        <button type="submit" class="btn btn-secondary">구매하기
                            &raquo;</button>
                    </form>
                </div>
            </div>
        </div>
        <hr>
    </div>
    <%
            }
        } else {
    %>
            <div class="alert alert-danger" role="alert">
                No products found.
            </div>
    <%
        }
    %>
</div>
</body>

<jsp:include page="footer.jsp" />
</html>
