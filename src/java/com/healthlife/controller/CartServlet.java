/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.healthlife.controller;

import com.healthlife.service.ISanPhamService;
import com.healthlife.model.Cart;
import com.healthlife.model.SanPham;
import com.healthlife.service.SanPhamService;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;

/**
 *
 * @author Nguyen Viet Truong
 */
@WebServlet(name = "CartServlet", urlPatterns = {"/cart-handler"})
public class CartServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private ISanPhamService sanPhamService;

    @Override
    public void init() throws ServletException {
        // Lấy service sản phẩm (cần để lấy SP từ ID)
        this.sanPhamService = new SanPhamService();
    }

    private Cart getCartFromSession(HttpSession session) {
        Object obj = session.getAttribute("cart");

        if (obj instanceof Cart) {
            return (Cart) obj;
        }

        Cart newCart = new Cart();
        session.setAttribute("cart", newCart);
        return newCart;
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect("cart-view"); // Hoặc trang xem giỏ hàng
            return;
        }

        // 1. Lấy giỏ hàng từ session
        HttpSession session = request.getSession();
        Cart cart = getCartFromSession(session);

        try {
            // ID không bắt buộc cho tất cả action (ví dụ: select-all)
            String idParam = request.getParameter("id");
            int idSanPham = (idParam != null) ? Integer.parseInt(idParam) : -1;

            switch (action) {
                case "add":
                    SanPham sp = sanPhamService.getProductById(idSanPham);

                    if (sp != null) {
                        int soLuong = 1; //mặc định thêm 1
                        cart.themSanPham(sp, soLuong);
                    }
                    break;

                case "update":
                    int soLuongMoi = Integer.parseInt(request.getParameter("quantity"));
                    cart.capNhatSoLuong(idSanPham, soLuongMoi);
                    break;

                case "remove":
                    cart.xoaSanPham(idSanPham);
                    break;
                // ACTION ĐỂ XỬ LÝ CHECKBOX
                case "toggle":
                    cart.toggleItemSelected(idSanPham);
                    break;
                case "toggle-all":
                    // Logic: Nếu đang chưa chọn hết -> Chọn hết. Nếu đã chọn hết -> Bỏ chọn hết.
                    boolean targetState = !cart.isAllSelected();
                    cart.setAllSelected(targetState);
                    break;
            }

            // 2. Lưu lại giỏ hàng vào session
            session.setAttribute("cart", cart);

            // --- TRẢ VỀ KẾT QUẢ ---
            if ("add".equals(action)) {
                // YÊU CẦU MỚI: Trả về JSON, không chuyển hướng
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");

                int totalItems = cart.getTongSoLuongTatCaItems();
                String message = "Thêm sản phẩm vào giỏ hàng thành công!";

                // Tạo chuỗi JSON thủ công
                String jsonResponse = String.format("{\"success\": true, \"message\": \"%s\", \"cartItemCount\": %d}", message, totalItems);

                PrintWriter out = response.getWriter();
                out.print(jsonResponse);
                out.flush();

            } else {
                // Các action khác (update, remove, toggle) vẫn chuyển hướng về giỏ hàng
                response.sendRedirect("cart-view");
            }

        } catch (NumberFormatException e) {
            if ("add".equals(action)) {
                // Trả về JSON lỗi nếu là AJAX
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                String jsonResponse = "{\"success\": false, \"message\": \"Lỗi: Sản phẩm không hợp lệ.\"}";
                PrintWriter out = response.getWriter();
                out.print(jsonResponse);
                out.flush();
            } else {
                response.sendRedirect("home");
            }
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
