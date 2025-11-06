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
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String idParam = req.getParameter("id");
        if (idParam != null) {
            try {
                int id = Integer.parseInt(idParam);
                Product product = productDAO.getProductDetail(id);
                req.setAttribute("product", product);
                req.getRequestDispatcher("/ProductDetailView.jsp").forward(req, resp);
                return;
            } catch (Exception e) {}
        }
        resp.sendRedirect("products");
    }
}
