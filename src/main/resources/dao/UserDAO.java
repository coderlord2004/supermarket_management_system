package dao;

import model.Customer;
import model.User;
import model.WarehouseStaff;

import java.sql.*;

public class UserDAO extends DAO{
    public UserDAO() {
        super();
    }

    public boolean registerCustomer(Customer customer) {
        String sqlCheck = "SELECT * FROM tblUser WHERE username = ?;";
        String sqlUser = "INSERT INTO tblUser(username, password, name) VALUES (?, ?, ?);";
        String sqlCustomer = "INSERT INTO tblCustomer(phone_number, address, tblUserId) VALUES (?, ?, ?);";
        try {
            PreparedStatement psCheck = conn.prepareStatement(sqlCheck);
            psCheck.setString(1, customer.getUsername());
            ResultSet rsCheck = psCheck.executeQuery();
            if (rsCheck.next()) {
                System.out.println("Username da ton tai: " + customer.getUsername());
                return false;
            }

            PreparedStatement psUser = conn.prepareStatement(sqlUser, Statement.RETURN_GENERATED_KEYS);
            psUser.setString(1, customer.getUsername());
            psUser.setString(2, customer.getPassword());
            psUser.setString(3, customer.getName());
            psUser.executeUpdate();

            ResultSet userId = psUser.getGeneratedKeys();
            if (userId.next()) {
                int id = userId.getInt(1);
                PreparedStatement psCustomer = conn.prepareStatement(sqlCustomer);
                psCustomer.setString(1, customer.getPhoneNumber());
                psCustomer.setString(2, customer.getAddress());
                psCustomer.setInt(3, id);
                psCustomer.executeUpdate();
            } else {
                System.out.println("Khong lay duoc user_id sau khi them moi user");
                return false;
            }
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Customer loginCustomer(String username, String password) {
        String sql = "SELECT u.*, c.* FROM tblUser AS u " +
                    "INNER JOIN tblCustomer AS c ON c.tblUserId = u.id " +
                    "WHERE u.username=? AND u.password=?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Customer customer = new Customer();
                customer.setId(rs.getInt("id"));
                customer.setUsername(rs.getString("username"));
                customer.setName(rs.getString("name"));
                customer.setPhoneNumber(rs.getString("phone_number"));
                customer.setAddress(rs.getString("address"));

                return customer;
            } else return null;
        } catch (SQLException e) {
            System.out.println("Error login: " + e.getMessage());
        }
        return null;
    }

    public WarehouseStaff loginWarehouseStaff(String username, String password) {
        String sql = "SELECT u.*, s.* FROM tblUser AS u " +
                "INNER JOIN tblStaff AS s ON s.tblUserId = u.id " +
                "WHERE u.username=? AND u.password=? AND s.position='WAREHOUSE_STAFF'";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                WarehouseStaff warehouseStaff = new WarehouseStaff();
                warehouseStaff.setId(rs.getInt("id"));
                warehouseStaff.setUsername(rs.getString("username"));
                warehouseStaff.setName(rs.getString("name"));
                warehouseStaff.setPosition(rs.getString("position"));

                return warehouseStaff;
            } else return null;
        } catch (SQLException e) {
            System.out.println("Error login: " + e.getMessage());
        }
        return null;
    }
}
