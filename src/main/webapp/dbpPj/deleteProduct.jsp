<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dbpPj.ProductDAO"%>

<%
    String productId = request.getParameter("productId");

    ProductDAO dao = new ProductDAO();
    try {
        dao.delProduct(productId);
        // 절대 경로를 사용하여 productChange.jsp로 리디렉션
        response.sendRedirect(request.getContextPath() + "/dbpPj/productChange.jsp");
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("errorMessage", "제품 삭제에 실패했습니다.");
        RequestDispatcher dispatcher = request.getRequestDispatcher("/dbpPj/productChange.jsp");
        dispatcher.forward(request, response);
    }
%>
