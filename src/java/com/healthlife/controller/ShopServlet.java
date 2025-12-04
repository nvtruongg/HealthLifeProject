/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.healthlife.controller;

import com.healthlife.service.ISanPhamService;
import com.healthlife.model.DanhMuc;
import com.healthlife.model.SanPham;
import com.healthlife.model.ThuongHieu;
import com.healthlife.service.DanhMucService;
import com.healthlife.service.IDanhMucService;
import com.healthlife.service.IThuongHieuService;
import com.healthlife.service.SanPhamService;
import com.healthlife.service.ThuongHieuService;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author Nguyen Viet Truong
 */
@WebServlet(name = "ShopServlet", urlPatterns = {"/shop"})
public class ShopServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    IDanhMucService danhMucService;
    ISanPhamService sanPhamService;
    IThuongHieuService thuongHieuService;

    @Override
    public void init() {
        danhMucService = new DanhMucService();
        sanPhamService = new SanPhamService();
        this.thuongHieuService = new ThuongHieuService();
    }

   

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            //Lấy các tham số lọc từ URL
            String categoryId = request.getParameter("cid");
            String brandId = request.getParameter("bid"); // Lấy ID thương hiệu (bid)
            String priceRange = request.getParameter("price");
            String sortType = request.getParameter("sort");

            //Tải danh sách Danh Mục (cho Navbar)
            List<DanhMuc> listC = danhMucService.getAllCategories();
            request.setAttribute("listC", listC);

            // Dùng cho bộ lọc thương hiệu
            List<ThuongHieu> listTH = thuongHieuService.getAll();
            request.setAttribute("listTH", listTH);

            // 3. Tải danh sách Sản Phẩm (Logic gộp)
            List<SanPham> listProducts = sanPhamService.filterProducts(categoryId, brandId, priceRange, sortType);

            //Tiêu đề trang
            String pageTitle = "Tất cả sản phẩm";
            if (categoryId != null && !categoryId.isEmpty()) {
                request.setAttribute("activeCid", categoryId);

                boolean found = false;
                for (DanhMuc parent : listC) {
                    if (String.valueOf(parent.getId()).equals(categoryId)) {
                        pageTitle = parent.getTenDanhMuc();
                        found = true;
                        break;
                    }
                    if (parent.getDanhMucCon() != null) {
                        for (DanhMuc child : parent.getDanhMucCon()) {
                            if (String.valueOf(child.getId()).equals(categoryId)) {
                                pageTitle = child.getTenDanhMuc();
                                found = true;
                                break;
                            }
                        }
                    }
                }

                // Nếu có chọn thương hiệu, nối thêm tên thương hiệu vào tiêu đề
                if (brandId != null && !brandId.isEmpty()) {
                    for (ThuongHieu th : listTH) {
                        if (String.valueOf(th.getId()).equals(brandId)) {
                            if (pageTitle.equals("Tất cả sản phẩm")) {
                                pageTitle = "Thương hiệu: " + th.getTenThuongHieu();
                            } else {
                                pageTitle += " (" + th.getTenThuongHieu() + ")";
                            }
                            break;
                        }
                    }
                }
            }
            //Đẩy dữ liệu và chuyển trang
            request.setAttribute("listP", listProducts); // Danh sách sản phẩm đã lọc 
            request.setAttribute("pageTitle", pageTitle);
            //Forward sang shop.jsp
            request.getRequestDispatcher("shop.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi server: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
