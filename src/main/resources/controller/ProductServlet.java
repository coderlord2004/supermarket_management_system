package controller;

import dao.ProductDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String query = request.getParameter("query");
        if (query != null && !query.trim().isEmpty()) {
            request.setAttribute("products", productDAO.getProductsByKeyword(query));
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("CustomerView.jsp");
        dispatcher.forward(request, response);
    }
}
