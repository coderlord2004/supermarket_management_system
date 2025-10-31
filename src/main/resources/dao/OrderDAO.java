package dao;

import model.Customer;
import model.Order;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO extends DAO{

    public Order findById(int orderId) {
        String sql = "SELECT o.id AS order_id, o.shipping_address, o.status, o.order_date, o.approved_date, u.id AS customer_id, u.name, c.phone_number \n" +
                "FROM tblOrder AS o\n" +
                "INNER JOIN tblCustomer AS c ON o.tblCustomerId = c.tblUserId\n" +
                "INNER JOIN tblUser AS u ON u.id = c.tblUserId\n" +
                "WHERE o.id = ?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Customer customer = new Customer();
                customer.setId(rs.getInt("customer_id"));
                customer.setName(rs.getString("name"));
                customer.setPhoneNumber(rs.getString("phone_number"));

                Order order = new Order();
                order.setId(rs.getInt("order_id"));
                order.setShippingAddress(rs.getString("shipping_address"));
                order.setStatus(rs.getString("status"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setApprovedDate(rs.getTimestamp("approved_date"));
                order.setCustomer(customer);

                return order;
            }

            return null;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public List<Order> getAllOrder() {
        String sql = "SELECT o.id AS order_id, o.shipping_address, o.status, o.order_date, o.approved_date, u.id AS customer_id, u.name, c.phone_number \n" +
                "FROM tblOrder AS o\n" +
                "INNER JOIN tblCustomer AS c ON o.tblCustomerId = c.tblUserId\n" +
                "INNER JOIN tblUser AS u ON u.id = c.tblUserId\n" +
                "ORDER BY o.order_date DESC";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            List<Order> orders = new ArrayList<>();
            while (rs.next()) {
                Customer customer = new Customer();
                customer.setId(rs.getInt("customer_id"));
                customer.setName(rs.getString("name"));
                customer.setPhoneNumber(rs.getString("phone_number"));

                Order order = new Order();
                order.setId(rs.getInt("order_id"));
                order.setShippingAddress(rs.getString("shipping_address"));
                order.setStatus(rs.getString("status"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setApprovedDate(rs.getTimestamp("approved_date"));
                order.setCustomer(customer);

                orders.add(order);
            }

            return orders;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE tblOrder SET status = ? WHERE id = ?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, orderId);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
