package com.healthlife.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet này hoạt động như một bộ điều hướng (dispatcher) cho trang admin.
 * Nó lắng nghe trên URL "/admin" và chuyển tiếp (forward) yêu cầu
 * đến trang "admin_home.jsp".
 */
@WebServlet(name = "AdminHomeServlet", urlPatterns = {"/admin"})
public class AdminServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        // Chuyển tiếp yêu cầu đến trang JSP
        // Người dùng thấy /admin trên URL, nhưng nội dung là của admin_home.jsp
        request.getRequestDispatcher("/admin_home.jsp").forward(request, response);
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
        return "Servlet điều hướng trang chủ admin";
    }
}