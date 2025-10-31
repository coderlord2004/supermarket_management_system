package dao;

import model.DeliveryStaff;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

public class DeliveryStaffDAO extends DAO{
    public List<DeliveryStaff> getAllDeliveryStaff() {
        String sql = "SELECT u.id, u.name FROM tblStaff AS s " +
                "INNER JOIN tblUser AS u ON s.tblUserId = u.id " +
                "WHERE s.position = 'DELIVERY_STAFF'";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            List<DeliveryStaff> deliveryStaffList = new java.util.ArrayList<>();
            while (rs.next()) {
                DeliveryStaff staff = new DeliveryStaff();
                staff.setId(rs.getInt("id"));
                staff.setName(rs.getString("name"));

                deliveryStaffList.add(staff);
            }
            return deliveryStaffList;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
