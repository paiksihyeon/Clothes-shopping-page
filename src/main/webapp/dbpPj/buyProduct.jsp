<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="dbpPj.Product"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매한 상품</title>
<link rel="stylesheet" href="./css/footer.css">
<link rel="stylesheet" href="./css/buyProduct.css">
<link rel="stylesheet"
    href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap">
<link rel="stylesheet"
    href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
	<jsp:include page="menu.jsp" />
    <div class="container">
        <h1 class="inform-display-3">구매한 상품</h1>
        <ul>
            <%

            List<Product> products = (List<Product>) session.getAttribute("purchasedProducts");
            Integer totalQuantity = (Integer) session.getAttribute("totalQuantity");
            Integer totalPrice = (Integer) session.getAttribute("totalPrice");

            if (products != null && !products.isEmpty()) {
                for (Product product : products) {
                    if (product != null) {
            %>
            <li class="d-flex align-items-center mb-3">
                <div class="product-info">
                    <img src="<%=request.getContextPath() + "/" + product.getImage()%>"
                        alt="Product Image" style="width: 50px; height: 50px;"
                        class="mr-3">
                    <div class="product-details">
                        <strong><%= product.getPname() %></strong>
                        <div>
                            <%= product.getUnitPrice() %>원 x
                            <%= product.getQuantity() %>
                        </div>
                        <div>
                            <strong>상품 가격:</strong>
                            <%= product.getUnitPrice() * product.getQuantity() %>원
                        </div>
                    </div>
                </div>
            </li>
            <%
                    }
                }
            } else {
            %>
            <li>구매한 상품이 없습니다.</li>
            <%
            }
            %>
        </ul>
        <div class="total-info">
            <p>
                <strong>총 상품 갯수:</strong>
                <%= totalQuantity != null ? totalQuantity : 0 %></p>
            <p>
                <strong>총 가격:</strong>
                <%= totalPrice != null ? totalPrice : 0 %>원
            </p>
        </div>
    </div>
    <jsp:include page="footer.jsp" />
</body>
</html>
