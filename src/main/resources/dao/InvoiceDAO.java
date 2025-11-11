package dao;

import model.Invoice;

import java.sql.PreparedStatement;

public class InvoiceDAO extends DAO {

    public boolean save(Invoice invoice) {
        String sql = "INSERT INTO tblInvoice (tblOrderId, tblDeliveryStaffId) VALUES (?, ?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, invoice.getOrder().getId());
            ps.setInt(2, invoice.getDeliveryStaff().getId());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
