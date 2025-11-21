package com.healthlife.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy session hiện tại (nếu có)
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate(); // Hủy toàn bộ session
        }

        // Sau khi đăng xuất -> trở về trang chủ
        response.sendRedirect("shop");
    }
}
