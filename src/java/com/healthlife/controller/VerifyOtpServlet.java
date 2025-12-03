package com.healthlife.controller;

import com.healthlife.model.NguoiDung;
import com.healthlife.service.NguoiDungService;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/verify-otp")
public class VerifyOtpServlet extends HttpServlet {

    private final NguoiDungService nguoiDungService = new NguoiDungService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String inputOtp = request.getParameter("otp");
        
        // Lấy mã OTP và thông tin người dùng đã lưu trong session từ RegisterServlet
        String sessionOtp = (String) session.getAttribute("authCode");
        NguoiDung pendingUser = (NguoiDung) session.getAttribute("pendingUser");

        // Kiểm tra xem session có còn hiệu lực không
        if (sessionOtp == null || pendingUser == null) {
            request.setAttribute("error", "Phiên giao dịch hết hạn. Vui lòng đăng ký lại.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // So sánh mã OTP
        if (inputOtp.equals(sessionOtp)) {
            // --- OTP ĐÚNG -> LƯU VÀO CSDL ---
            if (nguoiDungService.registerUser(pendingUser)) {
                // Xóa thông tin tạm trong session
                session.removeAttribute("authCode");
                session.removeAttribute("pendingUser");
                
                session.setAttribute("success", "✅ Xác thực thành công! Bạn có thể đăng nhập ngay.");
                response.sendRedirect("login.jsp");
            } else {
                request.setAttribute("error", "Lỗi hệ thống khi lưu tài khoản.");
                request.getRequestDispatcher("verify_otp.jsp").forward(request, response);
            }
        } else {
            // --- OTP SAI ---
            request.setAttribute("error", "❌ Mã OTP không chính xác. Vui lòng thử lại.");
            request.getRequestDispatcher("verify_otp.jsp").forward(request, response);
        }
    }
}