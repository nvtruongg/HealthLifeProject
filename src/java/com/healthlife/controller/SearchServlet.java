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
import java.util.List;

// Giả sử bạn có DanhMucService cho listC
import com.healthlife.service.DanhMucService;

@WebServlet(name = "SearchServlet", urlPatterns = {"/search"})
public class SearchServlet extends HttpServlet {
    private ISanPhamService sanPhamService = new SanPhamService();
    private DanhMucService danhMucService = new DanhMucService();  // Để lấy listC cho navbar

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy keyword từ param
        String keyword = request.getParameter("keyword");
        if (keyword == null || keyword.trim().isEmpty()) {
            response.sendRedirect("home");  // Redirect nếu không có keyword
            return;
        }

        // Tìm kiếm sản phẩm
        List<SanPham> listP = sanPhamService.searchProductsByName(keyword);

        // Truyền dữ liệu
        request.setAttribute("listP", listP);
        request.setAttribute("keyword", keyword);  // Để hiển thị keyword trên trang kết quả
        request.setAttribute("listC", danhMucService.getAllCategories());  // Cho navbar

        // Forward đến search.jsp
        request.getRequestDispatcher("/search.jsp").forward(request, response);
    }
}