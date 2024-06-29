<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="dbpPj.Product"%>
<%@ page import="dbpPj.ProductDAO"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="javax.servlet.ServletContext"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./css/welcome.css">
<link rel="stylesheet" href="./css/footer.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Welcome 환영페이지</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<img src="./img/slide01.jpeg" class="img-slide1">
	<div class="container">
		<div class="text-center">
			<h3>Welcome to clothing shopping mall!</h3>
			<%
                ServletContext application1 = getServletContext();
                Integer pageCount = (Integer) application1.getAttribute("pageCount");
                if (pageCount == null) {
                    pageCount = 1;
                } else {
                    pageCount++;
                }
                application1.setAttribute("pageCount", pageCount);
            %>
			<p>
				이 사이트 방문자로는 <span style="color: red"> <%=pageCount%>
				</span> 번째 입니다.
			</p>
		</div>
		<hr>
		<%
            HttpSession session1 = request.getSession(false);
            if (session1 != null) {
                Boolean isAdmin = (Boolean) session1.getAttribute("isAdmin");
                if (isAdmin != null && isAdmin) {
        %>
		<%
                }
            }
        %>
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
                        <button type="submit" class="btn btn-secondary">구매하기
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
</body>
</html>
