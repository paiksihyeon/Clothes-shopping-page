<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="dbpPj.Product"%>
<%@ page import="dbpPj.ProductDAO"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="./css/productInfoList.css">
    <link rel="stylesheet"
        href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap">
    <title>의류 정보 목록</title>
</head>
<body>
    <jsp:include page="menu.jsp" />
    <div class="slideclass">
        <h1 class="inform-display-3">쇼핑몰 상품</h1>
    </div>
    <%
    ProductDAO dao = new ProductDAO();
    ArrayList<Product> listOfProducts = (ArrayList<Product>) dao.getAll();
    String errorMessage = (String) request.getAttribute("errorMessage");
    %>
    <div class="container">
        <div class="row product-list" align="center">
            <%
            if (errorMessage != null) {
            %>
            <div class="alert alert-danger" role="alert">
                <%=errorMessage%>
            </div>
            <%
            }
            %>
            <%
            for (Product product : listOfProducts) {
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
                        <button type="submit" class="btn btn-secondary">장바구니
                            &raquo;</button>
                    </form>
                </div>
            </div>
            <%
            }
            %>
        </div>
        <hr>
    </div>
    <jsp:include page="footer.jsp" />
    <script
        src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
        integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
        crossorigin="anonymous"></script>
    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
    <script
        src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        function submitForm(username) {
            console.log("Username: " + username);
        }
    </script>
</body>
</html>
