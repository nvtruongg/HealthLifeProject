/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.healthlife.controller;

import com.healthlife.dao.DanhMucDAO;
import com.healthlife.dao.SanPhamDAO;
import com.healthlife.model.DanhMuc;
import com.healthlife.model.SanPham;
import com.healthlife.service.DanhMucService;
import com.healthlife.service.IDanhMucService;
import com.healthlife.service.ISanPhamService;
import com.healthlife.service.SanPhamService;
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
    
    @Override
    public void init(){
        danhMucService = new DanhMucService();
        sanPhamService = new SanPhamService();
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        // 1. Lấy `cid` (category id) từ URL
        String categoryId = request.getParameter("cid");

        // 2. Tải danh sách Danh Mục (cho Navbar)
        List<DanhMuc> listCategories = danhMucService.getAllCategories();

        // 3. Tải danh sách Sản Phẩm
        List<SanPham> listProducts = sanPhamService.getProductsByCategoryID(categoryId);

        // 4. Đặt dữ liệu lên request
        request.setAttribute("listC", listCategories); // Dùng cho Navbar
        request.setAttribute("listP", listProducts); // Danh sách sản phẩm đã lọc
        request.setAttribute("activeCid", categoryId); // Đánh dấu danh mục đang được chọn

        // 5. Forward sang shop.jsp
        request.getRequestDispatcher("shop.jsp").forward(request, response);
        
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ShopServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ShopServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
