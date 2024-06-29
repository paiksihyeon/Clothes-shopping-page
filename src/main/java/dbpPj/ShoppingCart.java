package dbpPj;

import java.sql.Timestamp;

public class ShoppingCart {
    private int cartId;
    private String username;
    private String productId;
    private int quantity;
    private Timestamp addedDate;

    public ShoppingCart() {
        super();
    }

    public ShoppingCart(String username, String productId, int quantity) {
        this.username = username;
        this.productId = productId;
        this.quantity = quantity;
    }
    
    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Timestamp getAddedDate() {
        return addedDate;
    }

    public void setAddedDate(Timestamp addedDate) {
        this.addedDate = addedDate;
    }

	
}
