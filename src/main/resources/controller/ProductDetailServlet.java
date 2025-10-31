package controller;

import dao.ProductDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.Product;

@WebServlet("/product/detail")
public class ProductDetailServlet extends HttpServlet {
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam != null) {
            try {
                int id = Integer.parseInt(idParam);
                Product product = productDAO.getProductDetail(id);
                request.setAttribute("product", product);
                request.getRequestDispatcher("/ProductDetailView.jsp").forward(request, response);
                return;
            } catch (Exception e) {}
        }
        response.sendRedirect("products");
    }
}
