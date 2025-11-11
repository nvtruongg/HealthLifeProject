<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<header>
    <!-- Thanh trên cùng -->
    <div class="bg-primary text-white py-1 small">
        <div class="container d-flex justify-content-between">
            <div>
                💊 Sức khỏe của bạn – Niềm vui của chúng tôi
            </div>
            <div>
                📞 Hotline: <strong>0969.333.298</strong>
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
                    <li class="nav-item me-3">
                        <a href="dang_nhap.jsp" class="nav-link text-white">
                            👤 <small>Tài khoản</small>
                        </a>
                    </li>
                    <li class="nav-item me-3">
                        <a href="gio_hang.jsp" class="nav-link text-white position-relative">
                            🛒
                            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">0</span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Thanh menu danh mục -->
    <div class="bg-light border-bottom">
        <div class="container">
            <ul class="nav nav-pills nav-fill py-2">
                <li class="nav-item">
                    <a class="nav-link text-dark fw-bold" href="home">Trang chủ</a>
                </li>
                <c:forEach items="${listC}" var="cat">
                    <li class="nav-item">
                        <a class="nav-link text-dark" href="shop?cid=${cat.id}">${cat.tenDanhMuc}</a>
                    </li>
                </c:forEach>
                <li class="nav-item">
                    <a class="nav-link text-dark" href="lien_he.jsp">Liên hệ</a>
                </li>
            </ul>
        </div>
    </div>
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
