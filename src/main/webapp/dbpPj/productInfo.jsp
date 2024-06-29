<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dbpPj.Product"%>
<%@ page import="dbpPj.ProductDAO"%>
<%@ page import="java.sql.SQLException"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./css/productInfo.css">
<link rel="stylesheet" href="./css/footer.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>제품 정보</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<div class="slideclass">
		<h1 class="inform-display-3">상품 정보</h1>
	</div>

	<%
        String productId = request.getParameter("productId");
        if (productId == null || productId.isEmpty()) {
            out.println("<h2>유효한 제품 ID를 제공해주세요.</h2>");
        } else {
            ProductDAO dao = new ProductDAO();
            Product product = null;
            try {
                product = dao.getProduct(productId);
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<h2>제품 정보를 가져오는 중 오류가 발생했습니다.</h2>");
            }

            if (product != null) {
    %>
	<div class="container product-info-container">
		<div class="row">
			<div class="col-md-6 product-image-container">
				<img src="<%=request.getContextPath() + "/" + product.getImage()%>"
					alt="Product Image" class="product-image">
			</div>
			<div class="col-md-6 product-details-container">
				<h2 class="product-title"><%=product.getPname()%></h2>
				<p class="product-price">
					<strong>가격:</strong>
					<%=product.getUnitPrice()%>원
				</p>
				<p class="product-description">
					<strong>제품 설명:</strong>
					<%=product.getDescription()%></p>
				<p class="product-manufacturer">
					<strong>브랜드:</strong>
					<%=product.getManufacturer()%></p>
				<p class="product-category">
					<strong>분류:</strong>
					<%=product.getCategory()%></p>
				<p class="product-stock">
					<strong>재고 수:</strong>
					<%=product.getUnitsInStock()%></p>
				<form id="addToCartForm_<%=product.getProductId()%>"
					action="<%=request.getContextPath()%>/AddToCartServlet"
					method="post">
					<input type="hidden" name="username"
						value="<%=request.getSession().getAttribute("username")%>">
					<input type="hidden" name="productId"
						value="<%=product.getProductId()%>">
					<p class="product-quantity">
						<strong>수량:</strong> <select
							class="form-control quantity-dropdown" name="quantity">
							<% for (int i = 1; i <= product.getUnitsInStock(); i++) { %>
							<option value="<%= i %>"><%= i %></option>
							<% } %>
						</select>
					</p>
					<button type="submit" class="btn btn-infom">장바구니 &raquo;</button>
				</form>
				<div class="product-actions">
					<form action="buyProduct.jsp" method="post">
						<input type="hidden" name="productId"
							value="<%= product.getProductId() %>">
						<button type="submit" class="btn btn-secondary">구매하기</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	<%
            } else {
                out.println("<h2>해당 제품을 찾을 수 없습니다.</h2>");
            }
        }
    %>

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
</body>
<jsp:include page="footer.jsp" />
</html>
