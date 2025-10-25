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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String role = request.getParameter("role");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        System.out.println("role: " + role + ", username: " + username + ", password: " + password);
        switch (role) {
            case "customer":
                Customer customer = userDAO.loginCustomer(username, password);
                if (customer != null) {
                    HttpSession session = request.getSession();
                    session.setAttribute("customer", customer);
                    response.sendRedirect("CustomerView.jsp");
                } else {
                    request.setAttribute("error", "Sai username hoặc password!");
                    request.getRequestDispatcher("Login.jsp").forward(request, response);
                }
                break;
            case "warehouse_staff":
                WarehouseStaff warehouseStaff = userDAO.loginWarehouseStaff(username, password);
                if (warehouseStaff != null) {
                    HttpSession session = request.getSession();
                    session.setAttribute("warehouseStaff", warehouseStaff);
                    response.sendRedirect("WarehouseStaffView.jsp");
                } else {
                    request.setAttribute("error", "Sai username hoặc password!");
                    request.getRequestDispatcher("Login.jsp").forward(request, response);
                }
            default:
                request.setAttribute("error", "Vai trò không hợp lệ!");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
                return;
        }
    }
}

