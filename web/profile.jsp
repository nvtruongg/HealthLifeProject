<%-- Document : profile.jsp --%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông Tin Tài Khoản - HealthLife</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: #f1f5f2;
            font-family: "Segoe UI", sans-serif;
        }

        .profile-card {
            background: #fff;
            border-radius: 18px;
            padding: 25px;
            max-width: 680px;
            margin: 40px auto;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
            transition: 0.3s;
        }

        .profile-card:hover {
            box-shadow: 0 12px 28px rgba(0,0,0,0.15);
        }

        .profile-title {
            font-size: 2rem;
            font-weight: 700;
            color: #28a745;
            text-align: center;
        }

        .avatar-box {
            text-align: center;
            margin-bottom: 25px;
        }

        .avatar-box img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            border: 4px solid #28a745;
            object-fit: cover;
            box-shadow: 0 5px 12px rgba(0,0,0,0.15);
        }

        .profile-label {
            font-weight: 600;
            color: #28a745;
        }

        .info-row {
            padding: 12px 16px;
            border-radius: 10px;
            background: #f8fdf9;
            margin-bottom: 12px;
            border-left: 4px solid #28a745;
        }

        .btn-back {
            padding: 10px 22px;
            font-size: 1.05rem;
            border-radius: 10px;
        }
    </style>
</head>

<body>

<div class="container">
    <div class="profile-card">

        <h2 class="profile-title">Thông Tin Tài Khoản</h2>

        <div class="avatar-box">
            <img src="https://cdn-icons-png.flaticon.com/512/149/149071.png" 
                 alt="avatar">
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger text-center">${error}</div>
        </c:if>

        <c:if test="${not empty user}">
            <!-- Hàng thông tin -->
            <div class="info-row">
                <span class="profile-label">ID: </span>
                <span>${user.id}</span>
            </div>

            <div class="info-row">
                <span class="profile-label">Họ Tên: </span>
                <span>${user.fullname}</span>
            </div>

            <div class="info-row">
                <span class="profile-label">Email: </span>
                <span>${user.email}</span>
            </div>

            <div class="info-row">
                <span class="profile-label">Số Điện Thoại: </span>
                <span>${user.sdt}</span>
            </div>

            <div class="info-row">
                <span class="profile-label">Vai Trò: </span>
                <span>${user.role}</span>
            </div>

            <div class="info-row">
                <span class="profile-label">Trạng Thái: </span>
                <span>${user.status}</span>
            </div>

            <div class="info-row">
                <span class="profile-label">Ngày Tạo: </span>
                <span><fmt:formatDate value="${user.createdAt}" pattern="dd/MM/yyyy HH:mm:ss"/></span>
            </div>

            <div class="text-center mt-4">
                <a href="shop" class="btn btn-success btn-back">← Quay Lại</a>
            </div>
        </c:if>

        <c:if test="${empty user and empty error}">
            <p class="text-center text-danger">Không tìm thấy thông tin tài khoản.</p>
        </c:if>

    </div>
</div>

</body>
</html>
