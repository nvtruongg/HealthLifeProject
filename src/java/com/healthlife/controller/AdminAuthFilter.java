package com.healthlife.controller;

import com.healthlife.model.NguoiDung;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class AdminAuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        // 1. CHỐNG CACHE (Để nút Back hoạt động đúng logic bảo mật)
        res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); 
        res.setHeader("Pragma", "no-cache"); 
        res.setDateHeader("Expires", 0); 

        String path = req.getRequestURI().substring(req.getContextPath().length());

        // 2. LẤY THÔNG TIN NGƯỜI DÙNG
        HttpSession session = req.getSession(false);
        // Lưu ý: Dùng key "user" khớp với code LoginServlet và Header của bạn
        NguoiDung account = (session != null) ? (NguoiDung) session.getAttribute("user") : null;
        boolean isLoggedIn = (account != null);
        boolean isAdmin = (isLoggedIn && "admin".equals(account.getRole()));

        // 3. XỬ LÝ CÁC TRANG LOGIN/REGISTER (Sửa lỗi ấn Back vẫn hiện form login)
        if (path.equals("/login") || path.equals("/login.jsp") || 
            path.equals("/register") || path.equals("/register.jsp")) {
            
            if (isLoggedIn) {
                // Nếu ĐÃ ĐĂNG NHẬP mà cố vào lại trang login -> Đẩy về trang chủ/admin tương ứng
                if (isAdmin) {
                    res.sendRedirect(req.getContextPath() + "/admin");
                } else {
                    res.sendRedirect(req.getContextPath() + "/index");
                }
                return; // Dừng, không cho hiện form login
            } else {
                // Chưa đăng nhập -> Cho phép hiện form
                chain.doFilter(request, response);
                return;
            }
        }

        // 4. XỬ LÝ CÁC TÀI NGUYÊN TĨNH & CÔNG KHAI (Cho qua)
        if (path.startsWith("/assets/") || path.startsWith("/Images/") || path.startsWith("/css/") || path.startsWith("/js/") ||
            path.equals("/") || path.equals("/index") || path.equals("/index.jsp") || 
            path.equals("/shop") || path.equals("/shop.jsp") || 
            path.equals("/logout") || path.equals("/search") || path.equals("/cart-view")) {
            
            chain.doFilter(request, response);
            return;
        }

        // 5. XỬ LÝ CÁC TRANG ADMIN (Sửa lỗi khách hàng vào được admin)
        // Bắt tất cả các link có chứa chữ "admin" ở đầu
        if (path.startsWith("/admin") || path.startsWith("/ADMIN")) {
            
            if (!isLoggedIn) {
                // Chưa đăng nhập -> Đá về Login
                res.sendRedirect(req.getContextPath() + "/login");
                return;
            }

            if (!isAdmin) {
                // Đã đăng nhập nhưng KHÔNG PHẢI ADMIN -> Đá về trang chủ
                res.sendRedirect(req.getContextPath() + "/index");
                return;
            }

            // Là Admin -> Cho qua
            chain.doFilter(request, response);
            return;
        }

        // 6. CÁC TRƯỜNG HỢP KHÁC (Mặc định cho qua hoặc chặn tùy logic dự án)
        // Ví dụ: Trang profile, history... cần đăng nhập mới xem được
        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void destroy() {}
}