/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.healthlife.controller;

import com.healthlife.service.ISanPhamService;
import com.healthlife.model.DanhMuc;
import com.healthlife.model.SanPham;
import com.healthlife.service.DanhMucService;
import com.healthlife.service.IDanhMucService;

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
        request.setAttribute("listC", listCategories); // Dùng cho Navbar
        
        // 3. Tải danh sách Sản Phẩm (Logic gộp)
        List<SanPham> listProducts;
        String pageTitle;
        if (categoryId != null && !categoryId.isEmpty()) {
            pageTitle = "Danh Mục";
            // Nếu CÓ cid -> Lọc theo danh mục
            listProducts = sanPhamService.getProductsByCategoryID(categoryId);
            // Đặt cid đang active để JSP tô màu menu
            for(DanhMuc parent : listCategories){
                if(parent.getId() == Integer.parseInt(categoryId)){
                    pageTitle = parent.getTenDanhMuc();
                    break;
                }
                for(DanhMuc child : parent.getDanhMucCon()){
                    if(child.getId() == Integer.parseInt(categoryId)){
                        pageTitle = child.getTenDanhMuc();
                        break;
                    }
                }
            }
            request.setAttribute("activeCid", categoryId); 
        } else {
            // Nếu KHÔNG có cid -> Lấy tất cả sản phẩm
            listProducts = sanPhamService.getAllProducts();
            pageTitle = "Tất cả sản phẩm";
            
        }

        request.setAttribute("listP", listProducts); // Danh sách sản phẩm đã lọc 
        request.setAttribute("pageTitle", pageTitle);

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
