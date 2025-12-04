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
                Sức khỏe của bạn – Niềm vui của chúng tôi
            </div>
            <div>
                📞 Hotline: <strong>037 999 6828</strong>
            </div>
        </div>
    </div>

    <!-- Thanh chính -->
    <nav class="navbar navbar-expand-lg" style="background-color: #1250DC;"> <!--003D9D-->
        <div class="container">
            <!-- Logo -->
            <a class="navbar-brand d-flex align-items-center text-white flex-shink-0" href="index">
                <img src="assets/images/logoHL.png" alt="HealthLife" height="70" class="me-2 p-0 logo-img">
                <div>
                    <strong>HEALTHLIFE</strong><br>
                    <small class="text-light">Thương hiệu uy tín</small>
                </div>
            </a>

            <!-- Nút toggle cho mobile -->
            <button class="navbar-toggler bg-light" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMain">
                <span class="navbar-toggler-icon"></span>
            </button>

            <!-- Thanh tìm kiếm ở giữa -->
            <div class="collapse navbar-collapse" id="navbarMain">
                <form class="d-flex mx-lg-4 my-2 my-lg-0 flex-grow-1" action="search" method="get">
                    <input class="form-control me-2" type="search" name="keyword" placeholder="Tìm thuốc, thực phẩm chức năng, thiết bị y tế..." aria-label="Search">
                    <button class="btn btn-warning rounded-start-0 px-3" type="submit">🔍</button>
                </form>

                <!-- Biểu tượng tài khoản và giỏ hàng -->
                <ul class="navbar-nav align-items-center flex-row justify-content-end gap-3">
                    
                    <!-- Logic Tài khoản (Tự động kiểm tra session "user") -->
                    <c:if test="${empty sessionScope.user}">
                        <li class="nav-item me-3">
                            <a href="login.jsp" class="nav-link text-white d-flex align-items-center fw-500 text-dark">
                                <i class="bi bi-person-fill me-1 fs-5" style="font-size: 1.2rem;"></i> <small>Tài khoản</small>
                            </a>
                        </li>
                    </c:if>
                    
                    <c:if test="${not empty sessionScope.user}">
                        
                        <!-- --- PHẦN THÊM MỚI: NÚT ADMIN --- -->
                        <!-- Chỉ hiện nếu role là 'admin' -->
                        <c:if test="${sessionScope.user.role == 'admin'}">
                            <li class="nav-item me-2">
                                <a href="${pageContext.request.contextPath}/admin" class="btn btn-warning btn-sm d-flex align-items-center fw-bold text-dark shadow-sm" style="border-radius: 20px;">
                                    <i class="bi bi-shield-lock-fill me-1"></i> Quản trị
                                </a>
                            </li>
                        </c:if>
                        <!-- --- KẾT THÚC PHẦN THÊM MỚI --- -->

                        <li class="nav-item dropdown me-3" style="z-index: 2000;">
                            <a class="nav-link dropdown-toggle d-flex align-items-center text-dark fw-500" href="#" id="navbarDropdownAccount" role="button" 
                               accesskey=""data-bs-toggle="dropdown" aria-expanded="false" style="white-space: nowrap;">
                                <i class="bi bi-person-circle me-2 fs-5" style="font-size: 1.2rem;"></i> 
                                <span class="d-inline-block text-truncate" style="max-width: 150px;">
                                    Chào, ${sessionScope.user.fullname}
                                </span>
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
                            <i class="bi bi-cart-fill"> Giỏ hàng</i>
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
        background-color: #00c6ff;
        border: none;
        color: #000;
        transition: 0.3s;
    }
    .navbar .btn-warning:hover {
        background-color: #FFD43B;
    }
    /* Style riêng cho nút Quản trị để nó khác biệt */
    a.btn-warning.btn-sm {
        background-color: #FFD43B !important; /* Màu vàng cam */
        color: #000 !important;
        border: 1px solid #e0a800;
    }
    a.btn-warning.btn-sm:hover {
        background-color: #e0a800 !important;
        color: #fff !important;
    }

    .nav-link:hover {
        color: #003D9D !important;
        background-color: #FFD43B !important;
        border-radius: 6px;
    }
    .dropdown-menu {
        border: none;
        border-radius: 0.5rem;
        margin-top: 0.5rem;
    }
    .dropdown-item {
        padding: 0.5rem 1rem;
    }
    .dropdown-item:active {
        background-color: #003D9D;
    }
    .badge {
        font-size: 0.65rem;
    }
    .logo-img {
        height: 80px;
        width: 80px; /* Đảm bảo ảnh là hình vuông */
        object-fit: cover; /* Cắt ảnh vừa khít khung */
        border-radius: 30%; /* Làm tròn */
        background-color: transparent;
    }
</style>
