package dbpPj;

import java.io.File;
import java.io.IOException;
import java.util.UUID;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/AddProductServlet")
@MultipartConfig
public class AddProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");

        String productId = request.getParameter("productId");
        String pname = request.getParameter("pname");
        int unitPrice = Integer.parseInt(request.getParameter("unitPrice"));
        String description = request.getParameter("description");
        String manufacturer = request.getParameter("manufacturer");
        String category = request.getParameter("category");
        long unitsInStock = Long.parseLong(request.getParameter("unitsInStock"));
        String condition = request.getParameter("condition");

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
        }

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

        ProductDAO dao = new ProductDAO();
        try {
            dao.addProduct(product);
            response.sendRedirect(request.getContextPath() + "/dbpPj/productChange.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "제품 등록에 실패했습니다.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/dbpPj/addProduct.jsp");
            dispatcher.forward(request, response);
        }
    }
}
