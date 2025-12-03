<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Xác thực Email - HealthLife</title>
    <style>
        /* Giữ nguyên style giống các trang login/register */
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: "Segoe UI", sans-serif; }
        body { height: 100vh; background: linear-gradient(135deg, #00c6ff, #0072ff); display: flex; justify-content: center; align-items: center; }
        .otp-container { background: #fff; width: 400px; padding: 40px 35px; border-radius: 16px; box-shadow: 0 10px 25px rgba(0,0,0,0.25); text-align: center; }
        h2 { color: #0072ff; margin-bottom: 15px; }
        p { color: #666; font-size: 14px; margin-bottom: 20px; }
        .form-group { text-align: left; margin-bottom: 15px; }
        label { display: block; margin-bottom: 6px; color: #333; font-weight: 600; }
        input { width: 100%; padding: 10px 12px; border: 1px solid #ccc; border-radius: 8px; transition: 0.3s; font-size: 18px; letter-spacing: 5px; text-align: center; }
        input:focus { outline: none; border-color: #0072ff; }
        .btn { width: 100%; background: linear-gradient(135deg, #0072ff, #00c6ff); color: white; padding: 12px; border: none; border-radius: 8px; cursor: pointer; font-size: 16px; font-weight: 600; margin-top: 10px; }
        .btn:hover { transform: scale(1.02); }
        .error { color: red; background-color: #ffe6e6; padding: 10px; border-radius: 5px; margin-bottom: 15px; font-size: 14px; }
    </style>
</head>
<body>
    <div class="otp-container">
        <h2>Xác thực Email</h2>
        <p>Mã xác thực (OTP) đã được gửi đến email: <strong>${sessionScope.pendingUser.email}</strong></p>

        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
            <div class="error"><%= error %></div>
        <% } %>

        <form action="verify-otp" method="post">
            <div class="form-group">
                <label>Nhập mã OTP (6 số)</label>
                <input type="text" name="otp" maxlength="6" required placeholder="------">
            </div>
            <button type="submit" class="btn">Xác nhận</button>
        </form>
        
        <div style="margin-top: 15px; font-size: 13px;">
            <a href="register.jsp" style="color: #666; text-decoration: none;">Quay lại đăng ký</a>
        </div>
    </div>
</body>
</html>