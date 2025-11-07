<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Đăng nhập - HealthLife</title>
    <style>
        /* Reset CSS */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Segoe UI", sans-serif;
        }

        body {
            height: 100vh;
            background: linear-gradient(135deg, #00c6ff, #0072ff);
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-container {
            background-color: #fff;
            width: 380px;
            padding: 40px 30px;
            border-radius: 16px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            text-align: center;
            animation: fadeIn 0.8s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .login-container h2 {
            color: #0072ff;
            margin-bottom: 20px;
        }

        .form-group {
            text-align: left;
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin-bottom: 6px;
            color: #333;
            font-weight: 600;
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            transition: border-color 0.3s;
        }

        input[type="text"]:focus, input[type="password"]:focus {
            outline: none;
            border-color: #0072ff;
        }

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
            transition: all 0.3s;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 114, 255, 0.4);
        }

        .error {
            color: red;
            font-size: 14px;
            margin-bottom: 12px;
        }

        .register-link {
            margin-top: 15px;
            font-size: 14px;
        }

        .register-link a {
            color: #0072ff;
            text-decoration: none;
            font-weight: bold;
        }

        .register-link a:hover {
            text-decoration: underline;
        }
        .success {
    color: #4f8a10;
    background-color: #dff2bf;
    padding: 10px;
    border-left: 5px solid #4f8a10;
    border-radius: 8px;
    margin-bottom: 15px;
    animation: fadeIn 0.6s ease;
}

    </style>
</head>
<body>
<div class="login-container">
    <h2>Đăng nhập</h2>
    

    <%
    String success = (String) session.getAttribute("success");
    if (success != null) {
%>
    <div class="success"><%= success %></div>
<%
        session.removeAttribute("success"); // xóa sau khi hiển thị
    }
%>

    <% String error = (String) request.getAttribute("error"); %>
    <% if (error != null) { %>
        <p class="error"><%= error %></p>
    <% } %>

    <form action="login" method="post">
        <div class="form-group">
            <label>Tên đăng nhập</label>
            <input type="text" name="email"
                   value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>"
                   required>
        </div>

        <div class="form-group">
            <label>Mật khẩu</label>
            <input type="password" name="password" required>
        </div>

        <button type="submit" class="btn">Đăng nhập</button>

        <div class="register-link">
            Chưa có tài khoản? <a href="register.jsp">Đăng ký ngay</a>
        </div>
    </form>
</div>
</body>
</html>
