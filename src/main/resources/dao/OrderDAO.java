package dao;

import model.Customer;
import model.Order;
import model.OrderDetail;
import model.WarehouseStaff;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO extends DAO{
    private final OrderDetailDAO orderDetailDAO = new OrderDetailDAO();

    public Order getOrder(int orderId) {
        String sql = "SELECT o.id AS order_id, o.shipping_address, o.status, o.order_date, o.approved_date, u.id AS customer_id, u.name, c.phone_number " +
                "FROM tblOrder AS o " +
                "INNER JOIN tblCustomer AS c ON o.tblCustomerId = c.tblUserId " +
                "INNER JOIN tblUser AS u ON u.id = c.tblUserId " +
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

                List<OrderDetail> orderDetails = orderDetailDAO.getAllOrderDetail(orderId);
                order.setOrderDetails(orderDetails);
                order.setCustomer(customer);

                return order;
            }

            return null;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public List<Order> getAllOrder() {
        String sql = "SELECT o.id AS order_id, o.shipping_address, o.status, o.order_date, o.approved_date, u1.id AS customer_id, u1.name, c.phone_number, u2.name AS approver " +
                "FROM tblOrder AS o " +
                "INNER JOIN tblCustomer AS c ON o.tblCustomerId = c.tblUserId " +
                "INNER JOIN tblUser AS u1 ON u1.id = c.tblUserId " +
                "LEFT JOIN tblUser AS u2 ON u2.id = o.tblWarehouseStaffId " +
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

                WarehouseStaff warehouseStaff = null;
                if (rs.getString("approver") != null) {
                    warehouseStaff = new WarehouseStaff();
                    warehouseStaff.setName(rs.getString("approver"));
                    order.setWarehouseStaff(warehouseStaff);
                }

                orders.add(order);
            }

            return orders;
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    public boolean updateOrderStatus(int orderId, int warehouseStaffId, String status) {
        String sql = "UPDATE tblOrder SET tblWarehouseStaffId = ?, status = ?, approved_date = CURRENT_TIMESTAMP WHERE id = ?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, warehouseStaffId);
            ps.setString(2, status);
            ps.setInt(3, orderId);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
