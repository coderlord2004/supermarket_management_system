package controller;

import dao.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Customer;
import model.WarehouseStaff;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String role = req.getParameter("role");
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        switch (role) {
            case "customer":
                Customer customer = userDAO.loginCustomer(username, password);
                if (customer != null) {
                    HttpSession session = req.getSession();
                    session.setAttribute("customer", customer);
                    resp.sendRedirect("CustomerView.jsp");
                } else {
                    req.setAttribute("error", "Sai username hoặc password!");
                    req.getRequestDispatcher("index.jsp").forward(req, resp);
                }
                break;
            case "warehouse_staff":
                WarehouseStaff warehouseStaff = userDAO.loginWarehouseStaff(username, password);
                if (warehouseStaff != null) {
                    HttpSession session = req.getSession();
                    session.setAttribute("warehouseStaff", warehouseStaff);
                    resp.sendRedirect("WarehouseStaffView.jsp");
                } else {
                    req.setAttribute("error", "Sai username hoặc password!");
                    req.getRequestDispatcher("index.jsp").forward(req, resp);
                }
                break;
            default:
                req.setAttribute("error", "Vai trò không hợp lệ!");
                req.getRequestDispatcher("index.jsp").forward(req, resp);
        }
    }
}

