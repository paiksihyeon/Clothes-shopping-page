<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%
String sessionId = (String) session.getAttribute("sessionId");
Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
if (sessionId == null) {
	String message = "로그인을 하시오.";
	String encodedMessage = URLEncoder.encode(message, "UTF-8");
	response.sendRedirect("login.jsp?message=" + encodedMessage);
	return;
}
if (isAdmin == null || !isAdmin) {
	response.sendRedirect("manager.jsp");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./css/login.css">
<link rel="stylesheet" href="./css/productChange.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>제품 추가</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<div class="container" align="center">
		<h1 class="inform-display-3" style="padding-top:0px">제품 추가</h1>
		<div class="col-md-4 col-md-offset-4" style="margin-top:50px">
			<form name="newProduct"
				action="${pageContext.request.contextPath}/AddProductServlet"
				class="form-horizontal" method="post" enctype="multipart/form-data">
				<div class="form-group-margin" align="left">
					<label>제품 코드</label>
					<div class="col-sm-3">
						<input type="text" name="productId"
							class="textheight border_textbox" required>
					</div>
				</div>
				<div class="form-group-margin" align="left">
					<label>제품명</label>
					<div class="col-sm-3">
						<input type="text" name="pname" class="textheight border_textbox"
							required>
					</div>
				</div>
				<div class="form-group-margin" align="left">
					<label>가격</label>
					<div class="col-sm-3">
						<input type="number" name="unitPrice"
							class="textheight border_textbox" required>
					</div>
				</div>
				<div class="form-group-margin" align="left">
					<label>상세 정보</label>
					<div class="col-sm-3">
						<textarea name="description" cols="50" rows="2"
							class="form-control-box-1 border_textbox"></textarea>
					</div>
				</div>
				<div class="form-group-margin" align="left">
					<label>브랜드</label>
					<div class="col-sm-3">
						<input type="text" name="manufacturer"
							class="textheight border_textbox" required>
					</div>
				</div>
				<div class="form-group-margin" align="left">
					<label>분류</label>
					<div class="col-sm-3">
						<select name="category" class="form-control-box-2" required>
							<option value="Outer">Outer</option>
							<option value="Top">Top</option>
							<option value="Bottom">Bottom</option>
						</select>
					</div>
				</div>
				<div class="form-group-margin" align="left">
					<label>재고 수</label>
					<div class="col-sm-3">
						<input type="number" name="unitsInStock"
							class="textheight border_textbox border_textbox" required>
					</div>
				</div>
				<div class="form-group-margin" align="left">
					<label>이미지 파일</label>
					<div class="col-sm-3">
						<input type="file" name="imageFile" class="form-control-box-img">
					</div>
				</div>
				<div align="left">
					<div>
						<input type="submit" class="btn-register-product" value="등록">
					</div>
				</div>
			</form>
		</div>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>