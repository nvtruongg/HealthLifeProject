package com.healthlife.controller;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

// Giả sử bạn có các import này
import com.healthlife.dao.NguoiDungDAO; // (Tôi giả định tên DAO)
import com.healthlife.model.NguoiDung;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    
    // Giả sử bạn khởi tạo DAO ở đây hoặc trong init()
    private NguoiDungDAO userDAO = new NguoiDungDAO();

    // Khi người dùng vào trực tiếp /login thì hiển thị form
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    // Khi nhấn nút Đăng nhập (POST)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // (Tôi giả định tên model NguoiDung và phương thức getRole() của bạn)
        NguoiDung user = userDAO.checkLogin(email, password);

        if (user != null) {
            HttpSession session = request.getSession();
            
            // --- SỬA LỖI 1: Đổi "user" thành "account" ---
            // Tên "user" này phải khớp với tên ${sessionScope.user} trong các tệp JSP
            session.setAttribute("user", user); 

            // Phân quyền: role = "admin" hoặc "khach_hang"
            if ("admin".equals(user.getRole())) {
                
                // --- SỬA LỖI 2: Chuyển hướng đến /admin (Servlet) thay vì file JSP ---
                // Điều này giúp URL trên trình duyệt sạch sẽ hơn (chỉ /admin)
                response.sendRedirect("admin");
                
            } else {
                response.sendRedirect("shop");
            }
        } else {
            request.setAttribute("error", "Sai tên đăng nhập hoặc mật khẩu!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}