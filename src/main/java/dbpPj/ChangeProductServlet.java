package dbpPj;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

@WebServlet("/ChangeProductServlet")
@MultipartConfig
public class ChangeProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDAO dao;

    public void init() {
        dao = new ProductDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        Product product = new Product();
        try {
            String productId = request.getParameter("productId");
            product.setProductId(productId);
            product.setPname(request.getParameter("pname"));
            product.setUnitPrice(Integer.parseInt(request.getParameter("unitPrice")));
            product.setDescription(request.getParameter("description"));
            product.setManufacturer(request.getParameter("manufacturer"));
            product.setCategory(request.getParameter("category"));
            product.setUnitsInStock(Long.parseLong(request.getParameter("unitsInStock")));
            product.setCondition(request.getParameter("condition"));

            Part filePart = request.getPart("imageFile");
            String fileName = "";
            if (filePart != null && filePart.getSize() > 0) {
                String submittedFileName = filePart.getSubmittedFileName();
                fileName = UUID.randomUUID().toString() + "_" + submittedFileName;
                String uploadPath = getServletContext().getRealPath("/") + "uploads";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }
                filePart.write(uploadPath + File.separator + fileName);
                product.setImage("uploads/" + fileName);
            } else {
                Product existingProduct = dao.getProduct(productId);
                if (existingProduct != null) {
                    product.setImage(existingProduct.getImage());
                } else {
                    request.setAttribute("errorMessage", "기존 제품을 찾을 수 없습니다.");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/dbpPj/changeClothing.jsp?productId=" + productId);
                    dispatcher.forward(request, response);
                    return;
                }
            }

            dao.updateProduct(product);
            response.sendRedirect("/dbpPj/productInfoList.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("제품 정보 수정 중 오류 발생", e);
        }
    }
}
