package dbpPj;

import java.io.IOException;
import java.lang.reflect.Method;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

@WebServlet("/product.nhn")
@MultipartConfig(maxFileSize = 1024 * 1024 * 2, location = "c:/Temp/img")
public class ProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ProductDAO dao;
    private ServletContext ctx;

    private final String START_PAGE = "dbpPj/productList.jsp";

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        dao = new ProductDAO();
        ctx = getServletContext();
    }

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String action = request.getParameter("action");

        if (action == null) {
            action = "listProducts";
        }

        String view = null;
        try {
            Method m = this.getClass().getDeclaredMethod(action, HttpServletRequest.class, HttpServletResponse.class);
            view = (String) m.invoke(this, request, response);
        } catch (NoSuchMethodException e) {
            ctx.log("Requested action does not exist: " + action, e);
            request.setAttribute("error", "Invalid action parameter!");
            view = START_PAGE;
        } catch (Exception e) {
            ctx.log("Error invoking method for action: " + action, e);
            request.setAttribute("error", "An unexpected error occurred!");
            view = START_PAGE;
        }

        if (view != null) {
            if (view.startsWith("redirect:/")) {
                response.sendRedirect(view.substring("redirect:/".length()));
            } else {
                RequestDispatcher dispatcher = request.getRequestDispatcher(view);
                dispatcher.forward(request, response);
            }
        }
    }

    public String addProduct(HttpServletRequest request, HttpServletResponse response) {
        Product p = new Product();
        try {
            BeanUtils.populate(p, request.getParameterMap());
            dao.addProduct(p);
        } catch (Exception e) {
            ctx.log("Error adding product", e);
            request.setAttribute("error", "Product could not be added!");
            return START_PAGE;
        }
        return "redirect:/product.nhn?action=listProducts";
    }

    public String deleteProduct(HttpServletRequest request, HttpServletResponse response) {
        String productId = request.getParameter("productId");
        try {
            dao.delProduct(productId);
        } catch (SQLException e) {
            ctx.log("Error deleting product", e);
            request.setAttribute("error", "Product could not be deleted!");
            return listProducts(request, response);
        }
        return "redirect:/product.nhn?action=listProducts";
    }

    public String listProducts(HttpServletRequest request, HttpServletResponse response) {
        try {
            List<Product> list = dao.getAll();
            request.setAttribute("productList", list);
        } catch (Exception e) {
            ctx.log("Error listing products", e);
            request.setAttribute("error", "Product list could not be retrieved!");
        }
        return "dbpPj/productList.jsp";
    }

    public String getProduct(HttpServletRequest request, HttpServletResponse response) {
        String productId = request.getParameter("productId");
        try {
            Product p = dao.getProduct(productId);
            request.setAttribute("product", p);
        } catch (SQLException e) {
            ctx.log("Error retrieving product", e);
            request.setAttribute("error", "Product could not be retrieved!");
        }
        return "dbpPj/productView.jsp";
    }

    // search 메서드 추가
    public String search(HttpServletRequest request, HttpServletResponse response) {
        String search = request.getParameter("search");
        try {
            List<Product> products = dao.searchProducts(search);
            request.setAttribute("products", products);
        } catch (Exception e) {
            ctx.log("Error searching products", e);
            request.setAttribute("error", "Product search could not be completed!");
            return START_PAGE;
        }
        return "productinfo.jsp";
    }

    // updateProduct 메서드 추가
    public String updateProduct(HttpServletRequest request, HttpServletResponse response) {
        Product p = new Product();
        try {
            BeanUtils.populate(p, request.getParameterMap());
            dao.updateProduct(p);
        } catch (Exception e) {
            ctx.log("Error updating product", e);
            request.setAttribute("error", "Product could not be updated!");
            return START_PAGE;
        }
        return "redirect:/product.nhn?action=listProducts";
    }
}
