<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dbpPj.Product"%>
<%@ page import="dbpPj.ProductDAO"%>
<%@ page import="org.apache.commons.beanutils.BeanUtils"%>
<%@ page import="java.io.IOException"%>
<%@ page import="javax.servlet.RequestDispatcher"%>
<%@ page import="javax.servlet.ServletException"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.Arrays"%>

<%
    request.setCharacterEncoding("UTF-8");

    System.out.println("Starting processChange.jsp");

    Product product = new Product();
    ProductDAO dao = new ProductDAO();

    try {
        // 디버깅 메시지를 추가하여 폼 데이터 출력
        Map<String, String[]> parameterMap = request.getParameterMap();
        for (String key : parameterMap.keySet()) {
            System.out.println(key + " : " + Arrays.toString(parameterMap.get(key)));
        }

        BeanUtils.populate(product, parameterMap);
        System.out.println("Populated product: " + product);

        dao.updateProduct(product);

        response.sendRedirect("/dbpPj/productInfoList.jsp");
    } catch (Exception e) {
        e.printStackTrace();
        throw new ServletException("제품 정보 수정 중 오류 발생", e);
    }
%>
