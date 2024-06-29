<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dbpPj.Product"%>
<%@ page import="dbpPj.ProductDAO"%>
<%@ page import="org.apache.commons.beanutils.BeanUtils"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.IOException"%>
<%@ page import="javax.servlet.ServletException"%>
<%@ page import="javax.servlet.RequestDispatcher"%>
<%@ page import="javax.servlet.annotation.MultipartConfig"%>
<%@ page import="javax.servlet.http.Part"%>

<%@ page import="java.util.UUID"%>

<%
request.setCharacterEncoding("utf-8"); //DB에서 한글로 받아들임

// 폼 데이터 수신
String productId = request.getParameter("productId");
String pname = request.getParameter("pname");
int unitPrice = Integer.parseInt(request.getParameter("unitPrice"));
String description = request.getParameter("description");
String manufacturer = request.getParameter("manufacturer");
String category = request.getParameter("category");
long unitsInStock = Long.parseLong(request.getParameter("unitsInStock"));
String condition = request.getParameter("condition");

// 파일 업로드 처리
Part filePart = request.getPart("imageFile");
String fileName = "";
if (filePart != null && filePart.getSize() > 0) {
    String submittedFileName = filePart.getSubmittedFileName();
    fileName = UUID.randomUUID().toString() + "_" + submittedFileName;
    String uploadPath = application.getRealPath("/") + "uploads";
    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) {
        uploadDir.mkdir();
    }
    filePart.write(uploadPath + File.separator + fileName);
}

// Product 객체 생성 및 설정
Product product = new Product();
product.setProductId(productId);
product.setPname(pname);
product.setUnitPrice(unitPrice);
product.setDescription(description);
product.setManufacturer(manufacturer);
product.setCategory(category);
product.setUnitsInStock(unitsInStock);
product.setCondition(condition);
product.setImage("uploads/" + fileName);

// ProductDAO를 사용하여 데이터베이스에 제품 추가
ProductDAO dao = new ProductDAO();
try {
    dao.addProduct(product);
    // 절대 경로로 제품 목록 페이지로 리다이렉트
    response.sendRedirect(request.getContextPath() + "/dbpPj/productChange.jsp");
} catch (Exception e) {
    e.printStackTrace();
    request.setAttribute("errorMessage", "제품 등록에 실패했습니다.");
    RequestDispatcher dispatcher = request.getRequestDispatcher("/dbpPj/addProduct.jsp");
    dispatcher.forward(request, response);
}
%>
