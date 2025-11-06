package controller;

import dao.DeliveryStaffDAO;
import dao.OrderDAO;
import dao.OrderDetailDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.DeliveryStaff;
import model.Order;

import java.io.IOException;

import java.util.List;

@WebServlet("/approve-order/detail")
public class OrderDetailServlet extends HttpServlet {
    private final OrderDAO orderDAO = new OrderDAO();
    private final DeliveryStaffDAO deliveryStaffDAO = new DeliveryStaffDAO();

    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        try {
            int orderId = Integer.parseInt(req.getParameter("orderId"));

            Order order = orderDAO.getOrder(orderId);
            List<DeliveryStaff> deliveryStaffs = deliveryStaffDAO.getAllDeliveryStaff();

            req.setAttribute("order", order);
            req.setAttribute("deliveryStaffs", deliveryStaffs);
            req.getRequestDispatcher("/ApproveOrderDetailView.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi khi tải chi tiết đơn hàng: " + e.getMessage());
            req.getRequestDispatcher("/ApproveOrderView.jsp").forward(req,resp);
        }
    }

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        try {
            int orderId = Integer.parseInt(req.getParameter("orderId"));
            int deliveryStaffId = Integer.parseInt(req.getParameter("deliveryStaffId"));
            int warehouseStaffId = Integer.parseInt(req.getParameter("warehouseStaffId"));

            boolean updated = orderDAO.updateOrderStatus(orderId, warehouseStaffId, "EXPORTED");
            if (updated) {
                Order order = orderDAO.getOrder(orderId);

                req.setAttribute("updateOrderSuccess", "Cập nhật trạng thái đơn hàng thành công.");
                req.setAttribute("order", order);
                req.setAttribute("deliveryStaff", deliveryStaffDAO.getDeliveryStaff(deliveryStaffId));
                req.getRequestDispatcher("/InvoiceView.jsp").forward(req, resp);
            } else {
                req.setAttribute("error", "Cập nhật trạng thái đơn hàng thất bại.");
                req.getRequestDispatcher("/ApproveOrderDetailView.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi khi cập cập nhật trạng thái đơn hàng: " + e.getMessage());
            req.getRequestDispatcher("/ApproveOrderDetailView.jsp").forward(req, resp);
        }
    }
}
