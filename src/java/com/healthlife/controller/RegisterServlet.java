package com.healthlife.controller;

import com.healthlife.model.NguoiDung;
import com.healthlife.service.NguoiDungService;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Properties;
import java.util.Random;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

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

        // Giữ lại thông tin nhập nếu lỗi
        request.setAttribute("fullname", fullname);
        request.setAttribute("email", email);
        request.setAttribute("so_dien_thoai", soDienThoai);

        // 1. Kiểm tra dữ liệu đầu vào cơ bản
        if (fullname.isEmpty() || email.isEmpty() || soDienThoai.isEmpty() || password.isEmpty() || confirmPassword.isEmpty()) {
            request.setAttribute("error", "⚠️ Vui lòng nhập đầy đủ thông tin!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // 2. VALIDATION MỚI: Kiểm tra độ mạnh mật khẩu
        // Regex: Ít nhất 8 ký tự, 1 chữ hoa, 1 chữ thường, 1 số
        String passwordRegex = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{8,}$";
        if (!password.matches(passwordRegex)) {
            request.setAttribute("error", "❌ Mật khẩu yếu! Phải có ít nhất 8 ký tự, gồm chữ hoa, chữ thường và số.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "❌ Mật khẩu nhập lại không khớp!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // 3. VALIDATION MỚI: Kiểm tra số điện thoại (0 hoặc +84 + 9 số)
        // Regex: Bắt đầu bằng 0 hoặc +84, sau đó là 9 chữ số
        String phoneRegex = "^(0|\\+84)\\d{9}$";
        if (!soDienThoai.matches(phoneRegex)) {
            request.setAttribute("error", "⚠️ Số điện thoại không hợp lệ. Phải bắt đầu bằng 0 hoặc +84 và gồm 10 số.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (nguoiDungService.isEmailExist(email)) {
            request.setAttribute("error", "⚠️ Email đã được sử dụng!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // 4. Tạo đối tượng User (nhưng CHƯA lưu vào DB)
        NguoiDung user = new NguoiDung(email, password, "khach_hang", fullname, soDienThoai, "hoat_dong");

        // 5. Tạo mã OTP ngẫu nhiên
        String otp = String.format("%06d", new Random().nextInt(999999));

        // 6. Gửi Email OTP
        boolean emailSent = sendEmail(email, otp, fullname);

        if (emailSent) {
            // Lưu User và OTP vào Session
            HttpSession session = request.getSession();
            session.setAttribute("authCode", otp);      
            session.setAttribute("pendingUser", user);  
            
            response.sendRedirect("verify_otp.jsp");
        } else {
            System.err.println("Gửi email thất bại tới: " + email);
            request.setAttribute("error", "❌ Lỗi gửi email. Vui lòng kiểm tra lại địa chỉ email.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    // --- Hàm gửi Email (Cấu hình Gmail cá nhân) ---
    private boolean sendEmail(String toEmail, String otp, String name) {
        
        final String fromEmail = "tan40029010@gmail.com"; 
        
        // Mật khẩu ứng dụng (Thay bằng mật khẩu mới của bạn)
        final String password = "jynskyeaxqpusvro".trim().replace(" ", ""); 

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {
             MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            
            // --- CẤU HÌNH UTF-8 CHO TIÊU ĐỀ ---
            message.setSubject("Mã xác thực đăng ký HealthLife", "UTF-8");
            
            String content = "Xin chào " + name + ",\n\n"
                    + "Cảm ơn bạn đã đăng ký tài khoản tại HealthLife.\n"
                    + "Mã xác thực (OTP) của bạn là: " + otp + "\n\n"
                    + "Mã này có hiệu lực trong vòng 5 phút.\n"
                    + "Tuyệt đối không chia sẻ mã này cho bất kỳ ai.";
            
            // --- CẤU HÌNH UTF-8 CHO NỘI DUNG ---
            message.setText(content, "UTF-8");
            
            Transport.send(message);
            System.out.println("✅ Email sent successfully to " + toEmail);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace(); 
            return false;
        }
    }
}