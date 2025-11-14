/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.healthlife.controller;

import com.healthlife.model.Cart;
import com.healthlife.model.DonHang;
import com.healthlife.service.IOrderService;
import com.healthlife.service.OrderService;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;

/**
 *
 * @author Nguyen Viet Truong
 */
@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {

    IOrderService orderService;

    @Override
    public void init() throws ServletException {
        this.orderService = new OrderService();
    }
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CheckoutServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckoutServlet at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();

//        // 1. Yêu cầu đăng nhập (Rất quan trọng)
//        NguoiDung user = (NguoiDung) session.getAttribute("account"); // "account" là key session do nhóm đăng nhập quy định
//        if (user == null) {
//            response.sendRedirect("login.jsp"); // Chuyển đến trang đăng nhập
//            return;
//        }

        // 2. Yêu cầu giỏ hàng không được rỗng
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.getTongSoLuongItemsDaChon() == 0) {
            response.sendRedirect("cart-view"); // Về giỏ hàng
            return;
        }

        // Đã đủ điều kiện, cho xem trang checkout
        request.getRequestDispatcher("checkout.jsp").forward(request, response);
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
        HttpSession session = request.getSession();

        // 1. Kiểm tra lại đăng nhập và giỏ hàng
        //NguoiDung user = (NguoiDung) session.getAttribute("account");
        Cart cart = (Cart) session.getAttribute("cart");

//        if (user == null) {
//            response.sendRedirect("login.jsp");
//            return;
//        }
        if (cart == null || cart.getTongSoLuongItemsDaChon() == 0) {
            response.sendRedirect("cart-view");
            return;
        }

        // 2. Lấy thông tin từ form
        String tenNguoiNhan = request.getParameter("tenNguoiNhan");
        String soDienThoai = request.getParameter("soDienThoai");
        String diaChiGiaoHang = request.getParameter("diaChiGiaoHang");
        
        try {
            // 3. Chuẩn bị đối tượng DonHang
            DonHang donHang = new DonHang();
            donHang.setIdNguoiDung(111);
            donHang.setMaDonHang("HLF-" + System.currentTimeMillis()); // Tạo mã đơn hàng
            donHang.setTenNguoiNhan(tenNguoiNhan);
            donHang.setSoDienThoaiNhan(soDienThoai);
            donHang.setDiaChiGiaoHang(diaChiGiaoHang);
            donHang.setEmailNguoiNhan("new@gmail.com"); // Lấy từ user
            BigDecimal phiVanChuyen = new BigDecimal("15000.00"); // Tạm thời
            donHang.setPhiVanChuyen(phiVanChuyen);
            
            // TỔNG THANH TOÁN = TỔNG TIỀN HÀNG ĐÃ CHỌN + PHÍ VẬN CHUYỂN
            BigDecimal tongTienHangChon = cart.getTongTienHangDaChon();
            donHang.setTongThanhToan(tongTienHangChon.add(phiVanChuyen));
            
            donHang.setPhuongThucThanhToan("cod"); 
            
            // --- GỌI SERVICE ---
            // Service sẽ tự động:
            // 1. Kiểm tra tồn kho
            // 2. Lưu đơn hàng (chỉ SP đã chọn)
            // 3. Trừ tồn kho
            orderService.placeOrder(donHang, cart);
            
            // 5. Xóa giỏ hàng (hoặc chỉ xóa các SP đã mua)
            // Tốt nhất là xóa toàn bộ
            session.removeAttribute("cart");
            
            // 6. Chuyển đến trang Cảm ơn
            response.sendRedirect("order-success.jsp"); // Tạo trang này

        } catch (Exception e) {
            e.printStackTrace();
            // Gửi lỗi về trang checkout để người dùng thấy
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
        }
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
