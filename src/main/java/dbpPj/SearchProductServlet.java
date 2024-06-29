package dbpPj;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/searchProduct")
public class SearchProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO = new ProductDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html; charset=UTF-8");

        String query = request.getParameter("query");

        if (query == null || query.trim().isEmpty()) {
            String referer = request.getHeader("Referer");
            response.getWriter().println("<script>alert('검색어를 입력하세요'); location.href='" + referer + "';</script>");
            return;
        }

        List<Product> products = null;

        try {
            products = productDAO.searchProducts(query);
        } catch (SQLException e) {
            throw new ServletException("Database error while searching for products", e);
        }

        HttpSession session = request.getSession();
        session.setAttribute("products", products);

        String username = (String) session.getAttribute("username");
        if (username == null) {
            username = "Guest";
        }
        session.setAttribute("username", username);

        response.sendRedirect(request.getContextPath() + "/dbpPj/searchProduct.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
