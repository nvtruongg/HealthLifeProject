<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Quên mật khẩu - HealthLife</title>
    <style>
        /* Sử dụng lại style giống login.jsp để đồng bộ */
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: "Segoe UI", sans-serif; }
        body { height: 100vh; background: linear-gradient(135deg, #00c6ff, #0072ff); display: flex; justify-content: center; align-items: center; }
        
        .forgot-container {
            background-color: #fff;
            width: 400px;
            padding: 40px 30px;
            border-radius: 16px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            text-align: center;
            animation: fadeIn 0.8s ease;
        }
        
        @keyframes fadeIn { from { opacity: 0; transform: translateY(-20px); } to { opacity: 1; transform: translateY(0); } }
        
        h2 { color: #0072ff; margin-bottom: 15px; }
        p.instruction { color: #666; font-size: 14px; margin-bottom: 25px; line-height: 1.5; }
        
        .form-group { text-align: left; margin-bottom: 20px; }
        label { display: block; margin-bottom: 6px; color: #333; font-weight: 600; }
        input[type="email"] { width: 100%; padding: 10px 12px; border: 1px solid #ccc; border-radius: 8px; transition: 0.3s; }
        input[type="email"]:focus { outline: none; border-color: #0072ff; }
        
        .btn {
            width: 100%;
            background: linear-gradient(135deg, #0072ff, #00c6ff);
            color: white;
            padding: 12px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: 0.3s;
        }
        .btn:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(0, 114, 255, 0.4); }
        
        .back-link { margin-top: 20px; font-size: 14px; }
        .back-link a { color: #666; text-decoration: none; display: inline-flex; align-items: center; transition: 0.3s; }
        .back-link a:hover { color: #0072ff; }
        
        .message { margin-bottom: 15px; padding: 10px; border-radius: 8px; font-size: 14px; }
        .error { color: #721c24; background-color: #f8d7da; border: 1px solid #f5c6cb; }
        .success { color: #155724; background-color: #d4edda; border: 1px solid #c3e6cb; }
    </style>
    <!-- Font Awesome cho icon mũi tên -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

<div class="forgot-container">
    <h2>Khôi phục mật khẩu</h2>
    <p class="instruction">
        Nhập địa chỉ email đã đăng ký của bạn. Chúng tôi sẽ gửi một liên kết để đặt lại mật khẩu mới.
    </p>

    <!-- Hiển thị thông báo lỗi hoặc thành công -->
    <% String msg = (String) request.getAttribute("message"); %>
    <% String msgType = (String) request.getAttribute("messageType"); // "error" hoặc "success" %>
    
    <% if (msg != null) { %>
        <div class="message <%= "success".equals(msgType) ? "success" : "error" %>">
            <%= msg %>
        </div>
    <% } %>

    <!-- Form gửi đến Servlet xử lý quên mật khẩu (bạn cần tạo servlet này) -->
    <form action="forgot-password" method="post">
        <div class="form-group">
            <label>Email đăng ký</label>
            <input type="email" name="email" placeholder="vidu@gmail.com" required>
        </div>

        <button type="submit" class="btn">Gửi yêu cầu</button>

        <div class="back-link">
            <a href="login.jsp"><i class="fas fa-arrow-left" style="margin-right: 5px;"></i> Quay lại đăng nhập</a>
        </div>
    </form>
</div>

</body>
</html>