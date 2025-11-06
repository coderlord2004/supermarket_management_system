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
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String query = req.getParameter("query");
        if (query != null && !query.trim().isEmpty()) {
            req.setAttribute("products", productDAO.getProductsByKeyword(query));
        }

        RequestDispatcher dispatcher = req.getRequestDispatcher("CustomerView.jsp");
        dispatcher.forward(req, resp);
    }
}
