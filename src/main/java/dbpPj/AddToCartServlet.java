package dbpPj;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("sessionId");

        if (username == null) {
            String message = URLEncoder.encode("로그인이 필요합니다.", StandardCharsets.UTF_8.toString());
            response.sendRedirect("/dbpPj/login.jsp?message=" + message);
            return;
        }

        String productId = request.getParameter("productId");
        int quantity;
        try {
            quantity = Integer.parseInt(request.getParameter("quantity"));
        } catch (NumberFormatException e) {
            String message = URLEncoder.encode("유효한 수량을 입력해주세요.", StandardCharsets.UTF_8.toString());
            response.sendRedirect("/dbpPj/productInfo.jsp?productId=" + productId + "&message=" + message);
            return;
        }

        if (productId != null && quantity > 0) {
            ShoppingCartDAO shoppingCartDAO = new ShoppingCartDAO();
            shoppingCartDAO.addProductToCart(username, productId, quantity);
            response.sendRedirect("/dbpPj/shoppingCart.jsp");
        } else {
            String message = URLEncoder.encode("유효한 제품 ID와 수량을 입력해주세요.", StandardCharsets.UTF_8.toString());
            response.sendRedirect("/dbpPj/productInfo.jsp?productId=" + productId + "&message=" + message);
        }
    }
}
