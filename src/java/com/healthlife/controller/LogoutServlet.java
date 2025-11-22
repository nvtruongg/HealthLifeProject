package com.healthlife.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet này xử lý yêu cầu đăng xuất.
 * Nó lắng nghe tại URL "/logout" (khớp với href="logout" trong các tệp JSP).
 */
@WebServlet(name = "LogoutServlet", urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Lấy session hiện tại (không tạo mới nếu không có)
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            // 2. Hủy session
            // Thao tác này sẽ xóa tất cả các attribute (như "account")
            session.invalidate(); 
            System.out.println("LOGOUT: Session đã được hủy.");
        }
        
        // 3. Chuyển hướng người dùng về trang đăng nhập (Servlet /login)
        response.sendRedirect("home");
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

    @Override
    public String getServletInfo() {
        return "Servlet xử lý đăng xuất người dùng";
    }
}