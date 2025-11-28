package com.healthlife.controller;

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

/**
 * Đây là một Servlet Filter (Bộ lọc) hoạt động như một "người gác cổng". Nó sẽ
 * chặn MỌI yêu cầu ("/*") và kiểm tra.
 */
@WebFilter("/*") // Chặn tất cả mọi yêu cầu
public class AdminAuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        // Ép kiểu request và response
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        // Lấy đường dẫn (URI) mà người dùng đang cố truy cập
        String path = req.getRequestURI().substring(req.getContextPath().length());

        // === 1. KIỂM TRA CÁC TRANG CÔNG KHAI (PUBLIC) ===
        // Nếu người dùng đang cố truy cập trang login, logout, hoặc các tài nguyên
        // (CSS, JS - nếu bạn có), hãy cho họ đi qua.
        if (path.equals("/") || path.equals("/index") || path.equals("/index.jsp")
                || path.equals("/login") || path.equals("/logout") || path.equals("/shop")
                || path.equals("/login.jsp") || path.equals("/shop.jsp")
                || path.equals("/register") || path.equals("/register.jsp")
                || path.startsWith("/Images/")
                || path.startsWith("/assets/")) {

            chain.doFilter(request, response); // Cho phép đi tiếp
            return; // Dừng bộ lọc ở đây
        }

        // === 2. KIỂM TRA CÁC TRANG CẦN BẢO VỆ (ADMIN) ===
        // Lấy session hiện tại (không tạo mới nếu chưa có)
        HttpSession session = req.getSession(false);

        // Kiểm tra xem người dùng đã đăng nhập chưa (session có tồn tại VÀ có "user" không)
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);

        if (isLoggedIn) {
            // NẾU ĐÃ ĐĂNG NHẬP:

            // --- GIẢI QUYẾT VẤN ĐỀ CACHE (NÚT BACK) ---
            // Ra lệnh cho trình duyệt không được lưu cache các trang này
            res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
            res.setHeader("Pragma", "no-cache"); // HTTP 1.0
            res.setDateHeader("Expires", 0); // Proxies

            // Cho phép người dùng đi tiếp vào trang admin họ muốn
            chain.doFilter(request, response);

        } else {
            // NẾU CHƯA ĐĂNG NHẬP:

            // Đẩy họ về trang đăng nhập
            System.out.println("FILTER: Đã chặn truy cập trái phép vào: " + path);
            res.sendRedirect(req.getContextPath() + "/shop");
        }
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // (Không cần code ở đây)
    }

    @Override
    public void destroy() {
        // (Không cần code ở đây)
    }
}
