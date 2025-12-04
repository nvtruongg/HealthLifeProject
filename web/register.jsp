<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Đăng ký - HealthLife</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: "Segoe UI", sans-serif; }

        body {
            height: 100vh;
            background: linear-gradient(135deg, #00c6ff, #0072ff);
            display: flex; justify-content: center; align-items: center;
        }

        .register-container {
            background: #fff;
            width: 440px;
            padding: 40px 35px;
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.25);
            text-align: center;
            animation: fadeIn 1s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-40px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h2 { color: #0072ff; margin-bottom: 20px; letter-spacing: 1px; }

        .form-group { text-align: left; margin-bottom: 15px; }

        label { display: block; margin-bottom: 6px; color: #333; font-weight: 600; }

        input {
            width: 100%; padding: 10px 12px;
            border: 1px solid #ccc; border-radius: 8px;
            transition: all 0.3s;
        }

        input:focus {
            outline: none;
            border-color: #0072ff;
            box-shadow: 0 0 5px rgba(0,114,255,0.3);
        }
        
        /* Hiển thị gợi ý khi nhập sai pattern (tùy trình duyệt hỗ trợ) */
        input:invalid:not(:placeholder-shown) {
            border-color: #ff3333;
        }

        .btn {
            width: 100%;
            background: linear-gradient(135deg, #0072ff, #00c6ff);
            color: white; padding: 12px; border: none;
            border-radius: 8px; cursor: pointer;
            font-size: 16px; font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn:hover {
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(0,114,255,0.4);
        }

        .error, .success {
            margin-bottom: 15px;
            padding: 10px;
            border-radius: 8px;
            animation: slideIn 0.5s ease;
        }

        @keyframes slideIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .error {
            color: #d8000c;
            background-color: #ffbaba;
            border-left: 5px solid #d8000c;
        }

        .success {
            color: #4f8a10;
            background-color: #dff2bf;
            border-left: 5px solid #4f8a10;
        }

        .login-link { margin-top: 15px; font-size: 14px; }
        .login-link a { color: #0072ff; text-decoration: none; font-weight: bold; }
        .login-link a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div class="register-container">
        <h2>Đăng ký tài khoản</h2>

        <%
            String error = (String) request.getAttribute("error");
            String success = (String) request.getAttribute("success");
        %>

        <form action="register" method="post">
            <div class="form-group">
                <label>Họ và tên đầy đủ</label>
                <input type="text" name="fullname"
                       value="<%= request.getAttribute("fullname") != null ? request.getAttribute("fullname") : "" %>"
                       required>
            </div>

            <div class="form-group">
                <label>Email (Tên đăng nhập)</label>
                <input type="email" name="email"
                       value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>"
                       required>
            </div>

            <div class="form-group">
                <label>Số điện thoại</label>
                <!-- Pattern: Bắt đầu bằng 0 hoặc +84, sau đó là 9 số bất kỳ -->
                <input type="text" name="so_dien_thoai"
                       value="<%= request.getAttribute("so_dien_thoai") != null ? request.getAttribute("so_dien_thoai") : "" %>"
                       pattern="(0|\+84)\d{9}"
                       title="Số điện thoại phải bắt đầu bằng 0 hoặc +84 và theo sau là 9 chữ số (VD: 0912345678 hoặc +84912345678)" 
                       placeholder="VD: 0912345678"
                       required>
            </div>

            <div class="form-group">
                <label>Mật khẩu</label>
                <!-- Pattern: Ít nhất 8 ký tự, 1 chữ hoa, 1 chữ thường, 1 số -->
                <input type="password" name="password" 
                       pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
                       title="Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường và số"
                       required>
            </div>

            <div class="form-group">
                <label>Nhập lại mật khẩu</label>
                <input type="password" name="confirmPassword" required>
            </div>

            <button type="submit" class="btn">Đăng ký</button>

            <div class="login-link">
                Đã có tài khoản? <a href="login.jsp">Đăng nhập</a>
            </div>
        </form>
        
        <% if (error != null) { %>
            <div class="error"><%= error %></div>
        <% } else if (success != null) { %>
            <div class="success"><%= success %></div>
        <% } %>
    </div>
</body>
</html>