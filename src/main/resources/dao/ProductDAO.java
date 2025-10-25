package dao;

import model.Product;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO extends DAO{
    public List<Product> getProductsByKeyword(String keyword) {
        String sql = "SELECT id, name, price FROM tblProduct WHERE LOWER(name) LIKE LOWER(?)";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();

            List<Product> products = new ArrayList<>();
            while(rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setPrice(rs.getFloat("price"));

                products.add(product);
            }

            return products;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Product getProductDetail(int productId) {
        String sql = "SELECT * FROM tblProduct WHERE id = ?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setPrice(rs.getFloat("price"));
                product.setStock(rs.getInt("stock"));
                product.setDescription(rs.getString("description"));

                return product;
            } else return null;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
