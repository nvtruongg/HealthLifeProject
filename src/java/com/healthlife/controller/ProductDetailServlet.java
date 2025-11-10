package com.healthlife.controller;

import com.healthlife.dao.interfaces.ISanPhamService;
import com.healthlife.model.SanPham;
import com.healthlife.service.SanPhamService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ProductDetailServlet", urlPatterns = {"/detail"})
public class ProductDetailServlet extends HttpServlet {
    private ISanPhamService sanPhamService = new SanPhamService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy ID sản phẩm từ tham số URL (pid)
        int productId;
        try {
            productId = Integer.parseInt(request.getParameter("pid"));
        } catch (NumberFormatException e) {
            response.sendRedirect("home"); // Redirect nếu ID không hợp lệ
            return;
        }

        // Lấy sản phẩm từ Service
        SanPham product = sanPhamService.getProductById(productId);

        if (product != null) {
            // Truyền dữ liệu sang JSP
            request.setAttribute("product", product);
            request.getRequestDispatcher("/detail.jsp").forward(request, response);
        } else {
            response.sendRedirect("home"); // Redirect nếu không tìm thấy
        }
    }
}