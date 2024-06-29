<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dbpPj.Product"%>
<%@ page import="dbpPj.ProductDAO"%>
<%@ page import="java.io.IOException"%>
<%@ page import="javax.servlet.ServletException"%>
<%@ page import="javax.servlet.RequestDispatcher"%>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="./css/footer.css">
    <link rel="stylesheet" href="./css/changeClothing.css">
    <link rel="stylesheet"
        href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <title>제품 정보 수정</title>
</head>
<body>
    <jsp:include page="menu.jsp" />
    <div class="container" align="center">
        <h1 class="form-signin-heading">제품 정보 수정</h1>
    </div>
    <div class="container whitebackcontainer" align="center">
        <%
            String productId = request.getParameter("productId");
            if (productId != null && !productId.isEmpty()) {
                ProductDAO dao = new ProductDAO();
                Product product = dao.getProduct(productId);
                if (product != null) {
        %>
        <form name="updateProduct"
            action="${pageContext.request.contextPath}/ChangeProductServlet"
            method="post" enctype="multipart/form-data">
            <input type="hidden" name="productId"
                value="<%= product.getProductId() %>">
            <div class="form-group row">
                <label class="col-sm-2">제품명</label>
                <div class="col-sm-3">
                    <input type="text" name="pname" class="form-control"
                        value="<%= product.getPname() %>" required>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2">가격</label>
                <div class="col-sm-3">
                    <input type="number" name="unitPrice" class="form-control"
                        value="<%= product.getUnitPrice() %>" required>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2">상세 정보</label>
                <div class="col-sm-5">
                    <textarea name="description" cols="50" rows="2"
                        class="form-control" required><%= product.getDescription() %></textarea>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2">브랜드</label>
                <div class="col-sm-3">
                    <input type="text" name="manufacturer" class="form-control"
                        value="<%= product.getManufacturer() %>" required>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2">분류</label>
                <div class="col-sm-3">
                    <select name="category" class="form-control" required>
                        <option value="Outer"
                            <%= "Outer".equals(product.getCategory()) ? "selected" : "" %>>Outer</option>
                        <option value="Top"
                            <%= "Top".equals(product.getCategory()) ? "selected" : "" %>>Top</option>
                        <option value="Bottom"
                            <%= "Bottom".equals(product.getCategory()) ? "selected" : "" %>>Bottom</option>
                    </select>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2">재고 수</label>
                <div class="col-sm-3">
                    <input type="number" name="unitsInStock" class="form-control"
                        value="<%= product.getUnitsInStock() %>" required>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2">기존 이미지</label>
                <div class="col-sm-10">
                    <img
                        src="<%= request.getContextPath() + "/" + product.getImage() %>"
                        alt="Product Image" width="100">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2">이미지 파일</label>
                <div class="col-sm-3">
                    <input type="file" name="imageFile" class="form-control">
                </div>
            </div>
            <div class="form-group row">
                <div>
                    <input type="submit" class="btn-register" value="수정">
                </div>
            </div>
        </form>
        <%
                } else {
                    out.println("<p>제품 정보를 불러올 수 없습니다.</p>");
                }
            } else {
                out.println("<p>유효하지 않은 제품 ID입니다.</p>");
            }
        %>
    </div>
</body>
</html>
