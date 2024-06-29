package dbpPj;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
    final String JDBC_DRIVER = "org.h2.Driver";
    final String JDBC_URL = "jdbc:h2:tcp://localhost/~/jwbookdb";

    public Connection open() {
        Connection conn = null;
        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(JDBC_URL, "jwbook", "1234");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }

    public void addProduct(Product product) throws SQLException {
        String query = "INSERT INTO PRODUCT (PRODUCTID, PNAME, UNITPRICE, DESCRIPTION, MANUFACTURER, CATEGORY, UNITSINSTOCK, CONDITION, IMAGE) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = open();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, product.getProductId());
            pstmt.setString(2, product.getPname());
            pstmt.setInt(3, product.getUnitPrice());
            pstmt.setString(4, product.getDescription());
            pstmt.setString(5, product.getManufacturer());
            pstmt.setString(6, product.getCategory());
            pstmt.setLong(7, product.getUnitsInStock());
            pstmt.setString(8, product.getCondition());
            pstmt.setString(9, product.getImage());
            pstmt.executeUpdate();
        }
    }

    public void delProduct(String productId) throws SQLException {
        String query = "DELETE FROM PRODUCT WHERE PRODUCTID = ?";

        try (Connection conn = open();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, productId);
            pstmt.executeUpdate();
        }
    }

    public List<Product> getAll() throws SQLException {
        String query = "SELECT * FROM PRODUCT";
        List<Product> productList = new ArrayList<>();

        try (Connection conn = open();
             PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {
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
                productList.add(product);
            }
        }
        return productList;
    }

    public Product getProduct(String productId) throws SQLException {
        String query = "SELECT * FROM PRODUCT WHERE PRODUCTID = ?";
        Product product = null;

        try (Connection conn = open();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
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
        }
        return product;
    }

    public void updateProduct(Product product) throws SQLException {
        String query = "UPDATE PRODUCT SET PNAME = ?, UNITPRICE = ?, DESCRIPTION = ?, MANUFACTURER = ?, CATEGORY = ?, UNITSINSTOCK = ?, CONDITION = ?, IMAGE = ? WHERE PRODUCTID = ?";

        try (Connection conn = open();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, product.getPname());
            pstmt.setInt(2, product.getUnitPrice());
            pstmt.setString(3, product.getDescription());
            pstmt.setString(4, product.getManufacturer());
            pstmt.setString(5, product.getCategory());
            pstmt.setLong(6, product.getUnitsInStock());
            pstmt.setString(7, product.getCondition());
            pstmt.setString(8, product.getImage());
            pstmt.setString(9, product.getProductId());

            pstmt.executeUpdate();
        }
    }

    public List<Product> searchProducts(String query) throws SQLException {
        String sql = "SELECT * FROM PRODUCT WHERE PNAME LIKE ?";
        List<Product> productList = new ArrayList<>();

        try (Connection conn = open();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, "%" + query + "%");
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
                    productList.add(product);
                }
            }
        }
        return productList;
    }

    public void addProductToCart(String username, String productId, int quantity) {
        String query = "INSERT INTO SHOPPING_CART (USERNAME, PRODUCTID, QUANTITY) VALUES (?, ?, ?) "
                     + "ON DUPLICATE KEY UPDATE QUANTITY = QUANTITY + ?";

        try (Connection conn = open();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, username);
            pstmt.setString(2, productId);
            pstmt.setInt(3, quantity);
            pstmt.setInt(4, quantity);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Product> getProductsInCart(String username) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT p.PRODUCTID, p.PNAME, p.DESCRIPTION, p.UNITPRICE, sc.QUANTITY, p.MANUFACTURER, p.CATEGORY, p.UNITSINSTOCK, p.CONDITION, p.IMAGE "
                     + "FROM SHOPPING_CART sc "
                     + "JOIN PRODUCT p ON sc.PRODUCTID = p.PRODUCTID "
                     + "WHERE sc.USERNAME = ?";

        try (Connection conn = open();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getString("PRODUCTID"));
                product.setPname(rs.getString("PNAME"));
                product.setDescription(rs.getString("DESCRIPTION"));
                product.setUnitPrice(rs.getInt("UNITPRICE"));
                product.setQuantity(rs.getInt("QUANTITY"));
                product.setManufacturer(rs.getString("MANUFACTURER"));
                product.setCategory(rs.getString("CATEGORY"));
                product.setUnitsInStock(rs.getLong("UNITSINSTOCK"));
                product.setCondition(rs.getString("CONDITION"));
                product.setImage(rs.getString("IMAGE"));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }
}
