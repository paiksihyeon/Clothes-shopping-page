package dbpPj;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/BuyProductServlet")
public class BuyProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("sessionId");

        if (username == null) {
            String message = URLEncoder.encode("로그인이 필요합니다.", StandardCharsets.UTF_8.toString());
            response.sendRedirect("/dbpPj/login.jsp?message=" + message);
            return;
        }

        String selectedProductsParam = request.getParameter("selectedProducts");
        String totalQuantityParam = request.getParameter("totalQuantity");
        String totalPriceParam = request.getParameter("totalPrice");

        if (selectedProductsParam != null && !selectedProductsParam.isEmpty()) {
            String[] selectedProductIds = selectedProductsParam.split(",");
            ShoppingCartDAO shoppingCartDAO = new ShoppingCartDAO();
            List<Product> products = new ArrayList<>();

            for (String productId : selectedProductIds) {
                Product product = shoppingCartDAO.getProductById(productId);
                if (product != null) {
                    int quantity = shoppingCartDAO.getProductQuantityInCart(username, productId); // 장바구니에 있는 제품의 수량을 가져옴
                    product.setQuantity(quantity); // 수량 설정
                    products.add(product);
                    shoppingCartDAO.deleteProductFromCart(username, productId); // 구매 후 장바구니에서 제거
                } else {
                    System.err.println("Product not found: " + productId);
                }
            }

            int totalQuantity = 0;
            int totalPrice = 0;
            try {
                totalQuantity = Integer.parseInt(totalQuantityParam);
                totalPrice = Integer.parseInt(totalPriceParam);
            } catch (NumberFormatException e) {
                System.err.println("Invalid number format: " + e.getMessage());
            }

            // 세션에 속성 설정
            session.setAttribute("purchasedProducts", products);
            session.setAttribute("totalQuantity", totalQuantity);
            session.setAttribute("totalPrice", totalPrice);

            // 클라이언트가 buyProduct.jsp를 요청하도록 리다이렉트
            response.sendRedirect(request.getContextPath() + "/dbpPj/buyProduct.jsp");
        } else {
            String message = URLEncoder.encode("구매할 상품을 선택해주세요.", StandardCharsets.UTF_8.toString());
            response.sendRedirect("/dbpPj/shoppingCart.jsp?message=" + message);
        }
    }
}
