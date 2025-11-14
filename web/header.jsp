<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Thêm Bootstrap Icons (icon giỏ hàng và tài khoản) -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<header>
    <!-- Thanh trên cùng -->
    <div class="bg-primary text-white py-1 small">
        <div class="container d-flex justify-content-between">
            <div>
                💊 Sức khỏe của bạn – Niềm vui của chúng tôi
            </div>
            <div>
                📞 Hotline: <strong>037 999 6828</strong>
            </div>
        </div>
    </div>

    <!-- Thanh chính -->
    <nav class="navbar navbar-expand-lg" style="background-color: #003D9D;">
        <div class="container">
            <!-- Logo -->
            <a class="navbar-brand d-flex align-items-center text-white" href="index.jsp">
                <img src="Images/logo.png" alt="HealthLife" height="45" class="me-2">
                <div>
                    <strong>HEALTHLIFE</strong><br>
                    <small class="text-light">Nhà thuốc uy tín</small>
                </div>
            </a>

            <!-- Nút toggle cho mobile -->
            <button class="navbar-toggler bg-light" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMain">
                <span class="navbar-toggler-icon"></span>
            </button>

            <!-- Thanh tìm kiếm ở giữa -->
            <div class="collapse navbar-collapse" id="navbarMain">
                <form class="d-flex mx-auto w-75" action="search" method="get">
                    <input class="form-control me-2" type="search" name="keyword" placeholder="Tìm thuốc, thực phẩm chức năng, thiết bị y tế..." aria-label="Search">
                    <button class="btn btn-warning" type="submit">🔍</button>
                </form>

                <!-- Biểu tượng tài khoản và giỏ hàng -->
                <ul class="navbar-nav ms-auto align-items-center">
                    <!-- Logic Tài khoản (Tự động kiểm tra session "account") -->
                    <c:if test="${empty sessionScope.user}">
                        <li class="nav-item me-3">
                            <a href="login.jsp" class="nav-link text-white">
                                <i class="bi bi-person-fill" style="font-size: 1.2rem;"></i> <small>Tài khoản</small>
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${not empty sessionScope.user}">
                         <li class="nav-item dropdown me-3">
                            <a class="nav-link dropdown-toggle text-white" href="#" id="navbarDropdownAccount" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="bi bi-person-circle" style="font-size: 1.2rem;"></i> <small>Chào, ${sessionScope.user.fullname}</small>
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdownAccount">
                                <li><a class="dropdown-item" href="profile.jsp">Thông tin tài khoản</a></li>
                                <li><a class="dropdown-item" href="order-history">Lịch sử đơn hàng</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="logout">Đăng xuất</a></li>
                            </ul>
                        </li>
                    </c:if>
                    <li class="nav-item me-3">
                        <!-- 1. Tính toán số lượng -->
                        <c:set var="cartItemCount" value="${empty sessionScope.cart ? 0 : sessionScope.cart.tongSoLuongTatCaItems}" />
                        
                        <!-- 2. href trỏ đến CartViewServlet -->
                        <a href="cart-view" class="nav-link text-white position-relative">
                            <i class="bi bi-cart-fill" style="font-size: 1.2rem;"></i>
                            <!-- 3. Gán ID cho badge để AJAX cập nhật -->
                            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" 
                                  id="cart-count-badge">
                                ${cartItemCount}
                            </span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</header>

<style>
    .navbar {
        font-weight: 500;
    }
    .navbar .form-control:focus {
        border-color: #FFD43B;
        box-shadow: 0 0 4px rgba(255, 212, 59, 0.5);
    }
    .navbar .btn-warning {
        background-color: #FFD43B;
        border: none;
        color: #000;
        transition: 0.3s;
    }
    .navbar .btn-warning:hover {
        background-color: #ffca2c;
    }
    .nav-link:hover {
        color: #003D9D !important;
        background-color: #FFD43B !important;
        border-radius: 6px;
    }
    .badge {
        font-size: 0.65rem;
    }
</style>
