package dbpPj;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ShoppingCartDAO {

    private String dbURL = "jdbc:h2:tcp://localhost/~/jwbookdb";
    private String dbUser = "jwbook";
    private String dbPassword = "1234";

    // 드라이버 로드
    static {
        try {
            Class.forName("org.h2.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    // 장바구니에 상품 추가
    public void addProductToCart(String username, String productId, int quantity) {
        String checkProductSQL = "SELECT QUANTITY FROM SHOPPING_CART WHERE USERNAME = ? AND PRODUCTID = ?";
        String updateProductSQL = "UPDATE SHOPPING_CART SET QUANTITY = ? WHERE USERNAME = ? AND PRODUCTID = ?";
        String insertProductSQL = "INSERT INTO SHOPPING_CART (USERNAME, PRODUCTID, QUANTITY) VALUES (?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
            try (PreparedStatement checkStmt = conn.prepareStatement(checkProductSQL)) {
                checkStmt.setString(1, username);
                checkStmt.setString(2, productId);
                ResultSet rs = checkStmt.executeQuery();
                if (rs.next()) {
                    int currentQuantity = rs.getInt("QUANTITY");
                    int newQuantity = currentQuantity + quantity;
                    try (PreparedStatement updateStmt = conn.prepareStatement(updateProductSQL)) {
                        updateStmt.setInt(1, newQuantity);
                        updateStmt.setString(2, username);
                        updateStmt.setString(3, productId);
                        updateStmt.executeUpdate();
                    }
                } else {
                    try (PreparedStatement insertStmt = conn.prepareStatement(insertProductSQL)) {
                        insertStmt.setString(1, username);
                        insertStmt.setString(2, productId);
                        insertStmt.setInt(3, quantity);
                        insertStmt.executeUpdate();
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 장바구니의 상품 목록 조회
    public List<Product> getProductsInCart(String username) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.PRODUCTID, p.PNAME, p.UNITPRICE, p.DESCRIPTION, p.MANUFACTURER, p.CATEGORY, p.UNITSINSTOCK, p.CONDITION, p.IMAGE, c.QUANTITY " +
                     "FROM PRODUCT p INNER JOIN SHOPPING_CART c ON p.PRODUCTID = c.PRODUCTID WHERE c.USERNAME = ?";
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, username);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setProductId(rs.getString("PRODUCTID"));
                    product.setPname(rs.getString("PNAME"));
                    product.setUnitPrice(rs.getInt("UNITPRICE"));
                    product.setDescription(rs.getString("DESCRIPTION"));
                    product.setManufacturer(rs.getString("MANUFACTURER"));
                    product.setCategory(rs.getString("CATEGORY"));
                    product.setUnitsInStock(rs.getLong("UNITSINSTOCK"));
                    product.setCondition(rs.getString("CONDITION"));
                    product.setImage(rs.getString("IMAGE"));
                    product.setQuantity(rs.getInt("QUANTITY"));
                    products.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    // 장바구니의 상품 수량 업데이트
    public void updateProductQuantity(String username, String productId, int quantity) {
        String sql = "UPDATE SHOPPING_CART SET QUANTITY = ? WHERE USERNAME = ? AND PRODUCTID = ?";
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, quantity);
            pstmt.setString(2, username);
            pstmt.setString(3, productId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 장바구니에서 상품 삭제
    public void deleteProductFromCart(String username, String productId) {
        String sql = "DELETE FROM SHOPPING_CART WHERE USERNAME = ? AND PRODUCTID = ?";
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, username);
            pstmt.setString(2, productId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 특정 상품 정보 조회
    public Product getProductById(String productId) {
        Product product = null;
        String sql = "SELECT PRODUCTID, PNAME, UNITPRICE, DESCRIPTION, MANUFACTURER, CATEGORY, UNITSINSTOCK, CONDITION, IMAGE FROM PRODUCT WHERE PRODUCTID = ?";
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, productId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    product = new Product();
                    product.setProductId(rs.getString("PRODUCTID"));
                    product.setPname(rs.getString("PNAME"));
                    product.setUnitPrice(rs.getInt("UNITPRICE"));
                    product.setDescription(rs.getString("DESCRIPTION"));
                    product.setManufacturer(rs.getString("MANUFACTURER"));
                    product.setCategory(rs.getString("CATEGORY"));
                    product.setUnitsInStock(rs.getLong("UNITSINSTOCK"));
                    product.setCondition(rs.getString("CONDITION"));
                    product.setImage(rs.getString("IMAGE"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return product;
    }
    
    public int getProductQuantityInCart(String username, String productId) {
        int quantity = 0;
        String sql = "SELECT QUANTITY FROM SHOPPING_CART WHERE USERNAME = ? AND PRODUCTID = ?";
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, username);
            pstmt.setString(2, productId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    quantity = rs.getInt("QUANTITY");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return quantity;
    }

}
