package com.healthlife.controller;

import com.healthlife.service.NguoiDungService;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Properties;
import java.util.Random;
import javax.mail.*;
import javax.mail.internet.*;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {

    private final NguoiDungService nguoiDungService = new NguoiDungService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Chuyển hướng đến trang nhập email
        request.getRequestDispatcher("forgot_password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email").trim();

        // 1. Kiểm tra xem email có tồn tại trong hệ thống không
        if (!nguoiDungService.isEmailExist(email)) {
            request.setAttribute("message", "Email này chưa được đăng ký trong hệ thống!");
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("forgot_password.jsp").forward(request, response);
            return;
        }

        // 2. Tạo mật khẩu mới ngẫu nhiên (6 ký tự)
        String newPassword = generateStrongPassword();
        
        

        // 3. Cập nhật mật khẩu mới vào Database
        // Bạn cần viết hàm updatePassword trong NguoiDungService
        boolean isUpdated = nguoiDungService.updatePasswordByEmail(email, newPassword);

        if (isUpdated) {
            // 4. Gửi email chứa mật khẩu mới
            boolean emailSent = sendNewPasswordEmail(email, newPassword);
            
            if (emailSent) {
                request.setAttribute("message", "Mật khẩu mới đã được gửi vào email của bạn. Vui lòng kiểm tra (cả mục Spam)!");
                request.setAttribute("messageType", "success");
            } else {
                request.setAttribute("message", "Lỗi gửi email. Vui lòng thử lại sau.");
                request.setAttribute("messageType", "error");
            }
        } else {
            request.setAttribute("message", "Lỗi hệ thống không thể cập nhật mật khẩu.");
            request.setAttribute("messageType", "error");
        }

        request.getRequestDispatcher("forgot_password.jsp").forward(request, response);
    }

    // Hàm gửi mail (Copy cấu hình chuẩn từ RegisterServlet của bạn)
    private boolean sendNewPasswordEmail(String toEmail, String newPass) {
        // Cấu hình giống hệt RegisterServlet
        final String fromEmail = "tan40029010@gmail.com"; 
        // Thay mật khẩu ứng dụng mới nhất của bạn vào đây
        final String password = "jynskyeaxqpusvro"; 

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
            message.setSubject("Khôi phục mật khẩu - HealthLife","UTF-8");
            
            String content = "Xin chào,\n\n"
                    + "Chúng tôi đã nhận được yêu cầu khôi phục mật khẩu của bạn.\n"
                    + "Mật khẩu mới của bạn là: " + newPass + "\n\n"
                    + "Vui lòng đăng nhập và đổi lại mật khẩu ngay lập tức.\n"
                    + "Trân trọng,\nHealthLife Team";
            message.setText(content, "UTF-8");
            
            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Hàm tạo mật khẩu mạnh ngẫu nhiên
private String generateStrongPassword() {
    String upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    String lower = "abcdefghijklmnopqrstuvwxyz";
    String digits = "0123456789";
    String special = "!@#$%^&*()-_=+";
    String all = upper + lower + digits + special;

    // Sử dụng SecureRandom thay vì Random thường để bảo mật hơn
    java.security.SecureRandom random = new java.security.SecureRandom();
    StringBuilder sb = new StringBuilder();

    // Bước 1: Đảm bảo mỗi loại có ít nhất 1 ký tự (Tổng 4 ký tự)
    sb.append(upper.charAt(random.nextInt(upper.length())));
    sb.append(lower.charAt(random.nextInt(lower.length())));
    sb.append(digits.charAt(random.nextInt(digits.length())));
    sb.append(special.charAt(random.nextInt(special.length())));

    // Bước 2: Điền nốt 4 ký tự còn lại ngẫu nhiên từ tất cả các nguồn
    for (int i = 0; i < 4; i++) {
        sb.append(all.charAt(random.nextInt(all.length())));
    }

    // Bước 3: Trộn lộn xộn vị trí các ký tự (Shuffle) để không đoán được quy luật
    char[] charArray = sb.toString().toCharArray();
    for (int i = 0; i < charArray.length; i++) {
        int randomIndex = random.nextInt(charArray.length);
        char temp = charArray[i];
        charArray[i] = charArray[randomIndex];
        charArray[randomIndex] = temp;
    }

    return new String(charArray);
}
}