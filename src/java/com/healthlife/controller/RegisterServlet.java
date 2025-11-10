package com.healthlife.controller;

import com.healthlife.model.NguoiDung;
import com.healthlife.service.NguoiDungService;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private final NguoiDungService nguoiDungService = new NguoiDungService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String fullname = request.getParameter("fullname").trim();
        String email = request.getParameter("email").trim();
        String soDienThoai = request.getParameter("so_dien_thoai").trim();
        String password = request.getParameter("password").trim();
        String confirmPassword = request.getParameter("confirmPassword").trim();

        request.setAttribute("fullname", fullname);
        request.setAttribute("email", email);
        request.setAttribute("so_dien_thoai", soDienThoai);

        // Kiểm tra dữ liệu đầu vào
        if (fullname.isEmpty() || email.isEmpty() || soDienThoai.isEmpty() || password.isEmpty() || confirmPassword.isEmpty()) {
            request.setAttribute("error", "⚠️ Vui lòng nhập đầy đủ thông tin!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "❌ Mật khẩu không khớp!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (!soDienThoai.matches("\\d{10,11}")) {
            request.setAttribute("error", "⚠️ Số điện thoại không hợp lệ (10–11 chữ số).");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (nguoiDungService.isEmailExist(email)) {
            request.setAttribute("error", "⚠️ Email đã được sử dụng!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        NguoiDung user = new NguoiDung(email, password, "khach_hang", fullname, soDienThoai);
        if (nguoiDungService.registerUser(user)) {
            HttpSession session = request.getSession();
            session.setAttribute("success", "✅ Đăng ký thành công! Hãy đăng nhập.");
            response.sendRedirect("login.jsp");
        } else {
            request.setAttribute("error", "❌ Lỗi khi đăng ký. Vui lòng thử lại sau.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
