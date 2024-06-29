<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.nio.charset.StandardCharsets"%>
<%@ page import="dbpPj.Product"%>
<%@ page import="dbpPj.ShoppingCartDAO"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./css/shoppingCart.css">
<link rel="stylesheet" href="./css/footer.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>장바구니</title>
<script>
    function toggleCheckboxes(checked) {
        var checkboxes = document.getElementsByName('selectedProducts');
        for (var i = 0; i < checkboxes.length; i++) {
            checkboxes[i].checked = checked;
        }
    }

    function checkAll() {
        toggleCheckboxes(true);
    }

    function uncheckAll() {
        toggleCheckboxes(false);
    }

    function submitSelectedProducts() {
        var checkboxes = document.getElementsByName('selectedProducts');
        var selectedValues = [];
        var totalQuantity = 0;
        var totalPrice = 0;

        for (var i = 0; i < checkboxes.length; i++) {
            if (checkboxes[i].checked) {
                selectedValues.push(checkboxes[i].value);
                var quantity = parseInt(checkboxes[i].dataset.quantity);
                var price = parseInt(checkboxes[i].dataset.price);
                if (!isNaN(quantity) && !isNaN(price)) {
                    totalQuantity += quantity;
                    totalPrice += quantity * price;
                }
            }
        }

        document.getElementById('selectedProductsInput').value = selectedValues.join(',');
        document.getElementById('totalQuantityInput').value = totalQuantity;
        document.getElementById('totalPriceInput').value = totalPrice;
        document.getElementById('buyForm').submit();
    }
</script>
</head>
<body>
	<div class="menu-wrapper">
		<jsp:include page="menu.jsp" />
	</div>
	<div class="container">
		<h1 class="inform-display-3">장바구니</h1>
		<div class="mb-3">
			<button type="button" class="btn btn-primary" onclick="checkAll()">모두
				체크하기</button>
			<button type="button" class="btn btn-secondary"
				onclick="uncheckAll()">전체 체크 해제</button>
		</div>
		<% String message = request.getParameter("message");
        if (message != null) { %>
		<div class="alert alert-warning" role="alert">
			<%=message%>
		</div>
		<% } %>

		<ul>
			<% String username = (String) session.getAttribute("sessionId");
            if (username == null) {
                String loginMessage = URLEncoder.encode("로그인이 필요합니다.", StandardCharsets.UTF_8.toString());
                response.sendRedirect("/dbpPj/login.jsp?message=" + loginMessage);
                return;
            }

            ShoppingCartDAO cartDAO = new ShoppingCartDAO();
            List<Product> items = cartDAO.getProductsInCart(username);

            if (items != null && !items.isEmpty()) {
                for (Product item : items) {
            %>
			<li-1 class="d-flex align-items-center mb-3">
				<div class="product-info">
					<input type="checkbox" name="selectedProducts"
						value="<%=item.getProductId()%>"
						data-quantity="<%=item.getQuantity()%>"
						data-price="<%=item.getUnitPrice()%>"> <img
						src="<%=request.getContextPath() + "/" + item.getImage()%>"
						alt="Product Image" class="product-image">
					<div class="product-details">
						<strong><%=item.getPname()%></strong>
						<div><%=item.getUnitPrice()%>원 x
						</div>
						<div>
							<form
								action="${pageContext.request.contextPath}/UpdateCartServlet"
								method="post" style="display: inline;">
								<input type="hidden" name="productId"
									value="<%=item.getProductId()%>"> <input type="number"
									name="quantity" value="<%=item.getQuantity()%>" min="1"
									max="<%=item.getUnitsInStock()%>" style="width: 60px;">
								<button type="submit" class="btn btn-info">수량 변경</button>
							</form>
							<form
								action="${pageContext.request.contextPath}/DeleteCartServlet"
								method="post" style="display: inline;">
								<input type="hidden" name="productId"
									value="<%=item.getProductId()%>">
								<button type="submit" class="btn btn-secondary">삭제</button>
							</form>
						</div>
						<div>
							<strong>총 가격:</strong>
							<%=item.getUnitPrice() * item.getQuantity()%>원
						</div>
					</div>
				</div>
			</li-1>
			<% }
            } else { %>
			<li-1>장바구니가 비어 있습니다.</li-1>
			<% } %>
		</ul>

		<p class="total-price">
			<strong>전체 총 가격: </strong><%=items != null ? items.stream().mapToInt(item -> item.getUnitPrice() * item.getQuantity()).sum() : 0%>원
		</p>
		<form id="buyForm"
			action="${pageContext.request.contextPath}/BuyProductServlet"
			method="post">
			<input type="hidden" id="selectedProductsInput"
				name="selectedProducts"> <input type="hidden"
				id="totalQuantityInput" name="totalQuantity"> <input
				type="hidden" id="totalPriceInput" name="totalPrice">
			<button type="button" class="btn btn-primary"
				onclick="submitSelectedProducts()">선택 상품 구매</button>
		</form>

	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>