package dbpPj;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductRepository {
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

    public List<Product> getAllProducts() {
        List<Product> listOfProducts = new ArrayList<>();
        String query = "SELECT * FROM PRODUCT";

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
                listOfProducts.add(product);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return listOfProducts;
    }

    public Product getProductById(String productId) {
        Product product = null;
        String query = "SELECT * FROM PRODUCT WHERE PRODUCTID = ?";

        try (Connection conn = open();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, productId);
            ResultSet rs = pstmt.executeQuery();

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
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return product;
    }

    public void deleteProduct(String productId) {
        String query = "DELETE FROM PRODUCT WHERE PRODUCTID = ?";

        try (Connection conn = open();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, productId);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void addProduct(Product product) {
        String query = "INSERT INTO PRODUCT (PRODUCTID, PNAME, UNITPRICE, DESCRIPTION, MANUFACTURER, CATEGORY, UNITSINSTOCK, CONDITION) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

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
            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
