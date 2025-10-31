package controller;

import dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/orders")
public class OrderServlet extends HttpServlet {
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
            request.setAttribute("orders", orderDAO.getAllOrder());
            request.getRequestDispatcher("ApproveOrderView.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi khi tải đơn hàng: " + e.getMessage());
            request.getRequestDispatcher("ApproveOrderView.jsp").forward(request, response);
        }
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String status = request.getParameter("status");

            boolean updated = orderDAO.updateOrderStatus(orderId, status);
            if (updated) {
                request.getRequestDispatcher("InvoiceView.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Cập nhật trạng thái đơn hàng thất bại.");
                request.getRequestDispatcher("ApproveOrderView.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi khi cập cập nhật trạng thái đơn hàng: " + e.getMessage());
            request.getRequestDispatcher("ApproveOrderView.jsp").forward(request, response);
        }
    }
}
