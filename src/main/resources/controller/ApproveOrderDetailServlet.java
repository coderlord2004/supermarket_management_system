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
import model.OrderDetail;

import java.io.IOException;

import java.util.List;

@WebServlet("/approve-order/detail")
public class ApproveOrderDetailServlet extends HttpServlet {
    private final OrderDAO orderDAO = new OrderDAO();
    private final OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
    private final DeliveryStaffDAO deliveryStaffDAO = new DeliveryStaffDAO();

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));

            Order order = orderDAO.findById(orderId);
            List<OrderDetail> orderDetails = orderDetailDAO.findByOrderId(orderId);
            order.setOrderDetails(orderDetails);

            List<DeliveryStaff> deliveryStaffs = deliveryStaffDAO.getAllDeliveryStaff();

            System.out.println("ApproveOrderDetailView");
            request.setAttribute("order", order);
            request.setAttribute("deliveryStaffs", deliveryStaffs);
            request.getRequestDispatcher("/ApproveOrderDetailView.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("ApproveOrderView");
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi tải chi tiết đơn hàng: " + e.getMessage());
            request.getRequestDispatcher("/ApproveOrderView.jsp").forward(request, response);
        }
    }
}
