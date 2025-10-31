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
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String role = request.getParameter("role");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String name = request.getParameter("name");

        switch (role) {
            case "customer":
                String phone = request.getParameter("phoneNumber");
                String address = request.getParameter("address");

                Customer customer = new Customer();
                customer.setName(name);
                customer.setUsername(username);
                customer.setPassword(password);
                customer.setAddress(address);
                customer.setPhoneNumber(phone);

                if (userDAO.registerCustomer(customer)) {
                    response.sendRedirect("index.jsp");
                } else {
                    request.setAttribute("error", "Đăng ký thất bại! Username có thể đã tồn tại.");
                    request.getRequestDispatcher("Register.jsp").forward(request, response);
                }
                break;
            case "warehouse_staff":
                break;
            default:
                request.setAttribute("error", "Vai trò không hợp lệ!");
                request.getRequestDispatcher("Register.jsp").forward(request, response);
        }
    }
}

