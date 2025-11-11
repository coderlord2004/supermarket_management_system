package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.*;
import dao.*;

import java.io.IOException;

@WebServlet("/invoice")
public class InvoiceServlet extends HttpServlet {
    private final InvoiceDAO invoiceDAO = new InvoiceDAO();
    private final OrderDAO orderDAO = new OrderDAO();
    private final DeliveryStaffDAO deliveryStaffDAO = new DeliveryStaffDAO();

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            int orderId = Integer.parseInt(req.getParameter("orderId"));
            int deliveryStaffId = Integer.parseInt(req.getParameter("deliveryStaffId"));

            Order order = orderDAO.getOrder(orderId);
            DeliveryStaff deliveryStaff = deliveryStaffDAO.getDeliveryStaff(deliveryStaffId);

            Invoice invoice = new Invoice();
            invoice.setOrder(order);
            invoice.setDeliveryStaff(deliveryStaff);

            boolean created = invoiceDAO.save(invoice);

            req.setAttribute("order", order);
            req.setAttribute("deliveryStaff", deliveryStaff);

            if (created) {
                req.setAttribute("success", "Tạo hóa đơn thành công.");
                req.getRequestDispatcher("InvoiceView.jsp").forward(req, resp);
            } else {
                req.setAttribute("error", "Tạo hóa đơn thất bại.");
                req.getRequestDispatcher("InvoiceView.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            req.setAttribute("error", "Lỗi khi tạo hóa đơn: " + e.getMessage());
            req.getRequestDispatcher("InvoiceView.jsp").forward(req, resp);
        }
    }
}
