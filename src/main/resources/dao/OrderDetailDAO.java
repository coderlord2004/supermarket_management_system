package dao;

import model.Order;
import model.OrderDetail;
import model.Product;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderDetailDAO extends DAO{

    public List<OrderDetail> getAllOrderDetail(int orderId) {
        String sql = "SELECT od.*, p.id AS product_id, p.name, p.price, p.stock, p.description " +
                "FROM tblOrderDetail od " +
                "INNER JOIN tblProduct p ON od.tblProductId = p.id " +
                "WHERE od.tblOrderId = ?";

        List<OrderDetail> list = new ArrayList<>();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("product_id"));
                product.setName(rs.getString("name"));
                product.setPrice(rs.getFloat("price"));
                product.setStock(rs.getInt("stock"));
                product.setDescription(rs.getString("description"));

                OrderDetail detail = new OrderDetail();
                detail.setQuantity(rs.getInt("quantity"));
                detail.setUnitPrice(rs.getFloat("unit_price"));
                detail.setNote(rs.getString("note"));
                detail.setProduct(product);

                list.add(detail);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
