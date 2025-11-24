package com.healthlife.controller;

import com.healthlife.service.ISanPhamService;
import com.healthlife.model.SanPham;
import com.healthlife.service.SanPhamService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

// Giả sử có DanhMucService và DanhGiaService
import com.healthlife.service.DanhMucService;

import com.healthlife.model.DanhMuc;

@WebServlet(name = "ProductDetailServlet", urlPatterns = {"/detail"})
public class ProductDetailServlet extends HttpServlet {
    private ISanPhamService sanPhamService = new SanPhamService();
    private DanhMucService danhMucService = new DanhMucService();
    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int productId;
        try {
            productId = Integer.parseInt(request.getParameter("pid"));
        } catch (NumberFormatException e) {
            response.sendRedirect("home");
            return;
        }

        SanPham product = sanPhamService.getProductById(productId);
        if (product == null) {
            response.sendRedirect("home");
            return;
        }

        // Sản phẩm liên quan
        List<SanPham> relatedProducts = sanPhamService.getProductsByCategoryID(String.valueOf(product.getIdDanhMuc()));

        // Đánh giá
        

        // Danh mục cho navbar
        List<DanhMuc> listC = danhMucService.getAllCategories();

        request.setAttribute("product", product);
        request.setAttribute("relatedProducts", relatedProducts);
        
        request.setAttribute("listC", listC);
        request.getRequestDispatcher("/detail.jsp").forward(request, response);
    }
}