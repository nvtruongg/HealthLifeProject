/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.healthlife.controller;

import com.healthlife.model.Cart;
import com.healthlife.model.DonHang;
import com.healthlife.model.NguoiDung;
import com.healthlife.service.IOrderService;
import com.healthlife.service.OrderService;
import java.io.IOException;
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
     * HÀM QUAN TRỌNG NHẤT: Hàm này giúp lấy giỏ hàng an toàn. Nếu session đang
     * chứa HashMap (lỗi của bạn), nó sẽ phát hiện ra, hủy cái HashMap đó đi và
     * trả về một Cart mới để không bị crash.
     */
    private Cart getCartFromSession(HttpSession session) {
        Object obj = session.getAttribute("cart");

        // Kiểm tra xem object có tồn tại và CÓ ĐÚNG LÀ CLASS CART KHÔNG?
        if (obj != null && obj instanceof Cart) {
            return (Cart) obj; // Ép kiểu an toàn
        } else {
            // Nếu null hoặc bị sai kiểu (là HashMap), ta reset lại
            System.out.println("DEBUG: Phát hiện giỏ hàng bị sai kiểu dữ liệu (" + (obj == null ? "null" : obj.getClass().getName()) + "). Đang reset...");
            Cart newCart = new Cart();
            session.setAttribute("cart", newCart); // Ghi đè lại cho đúng
            return newCart;
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
        System.out.println("------------ CHECKOUT SERVLET PHIEN BAN MOI DA CHAY ------------");
        HttpSession session = request.getSession();

        // 1. Yêu cầu đăng nhập (Rất quan trọng)
        NguoiDung user = (NguoiDung) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp"); // Chuyển đến trang đăng nhập
            return;
        }

        // 2. Yêu cầu giỏ hàng không được rỗng
        Cart cart = getCartFromSession(session);
        
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
        NguoiDung user = (NguoiDung) session.getAttribute("user");
        Cart cart = getCartFromSession(session);

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
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
            donHang.setIdNguoiDung(user.getId());
            donHang.setMaDonHang("HLF-" + System.currentTimeMillis()); // Tạo mã đơn hàng
            donHang.setTenNguoiNhan(tenNguoiNhan);
            donHang.setSdtNhan(soDienThoai);
            donHang.setDiaChiGiaoHang(diaChiGiaoHang);
            donHang.setEmailNguoiNhan(user.getEmail()); // Lấy từ user
            BigDecimal phiVanChuyen = new BigDecimal("15000.00"); // Tạm thời
            donHang.setPhiVanChuyen(phiVanChuyen);

            // TỔNG THANH TOÁN = TỔNG TIỀN HÀNG ĐÃ CHỌN + PHÍ VẬN CHUYỂN
            BigDecimal tongTienHangChon = cart.getTongTienHangDaChon();
            donHang.setTongThanhToan(tongTienHangChon.add(phiVanChuyen));

            donHang.setPhuongThucThanhToan("cod");

            // --- GỌI SERVICE ---
            orderService.placeOrder(donHang, cart);

            //Xóa giỏ hàng (hoặc chỉ xóa các SP đã mua)
            // Tốt nhất là xóa toàn bộ
            session.removeAttribute("cart");

            //Chuyển đến trang Thành công
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
