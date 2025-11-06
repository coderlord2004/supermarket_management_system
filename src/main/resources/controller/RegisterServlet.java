package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Customer;
import model.User;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String role = req.getParameter("role");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String name = req.getParameter("name");

        switch (role) {
            case "customer":
                String phone = req.getParameter("phoneNumber");
                String address = req.getParameter("address");

                Customer customer = new Customer();
                customer.setName(name);
                customer.setUsername(username);
                customer.setPassword(password);
                customer.setAddress(address);
                customer.setPhoneNumber(phone);

                if (userDAO.registerCustomer(customer)) {
                    resp.sendRedirect("index.jsp");
                } else {
                    req.setAttribute("error", "Đăng ký thất bại! Username có thể đã tồn tại.");
                    req.getRequestDispatcher("Register.jsp").forward(req, resp);
                }
                break;
            case "warehouse_staff":
                break;
            default:
                req.setAttribute("error", "Vai trò không hợp lệ!");
                req.getRequestDispatcher("Register.jsp").forward(req, resp);
        }
    }
}

