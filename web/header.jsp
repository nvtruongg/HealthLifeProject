<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">

<header>
    <div class="top-bar py-1 text-white">
        <div class="container d-flex justify-content-between align-items-center" style="font-size: 0.85rem;">
            <div>
                <i class="bi bi-heart-pulse-fill text-warning me-1"></i> Sức khỏe của bạn – Niềm vui của chúng tôi
            </div>
            <div>
                <i class="bi bi-telephone-fill text-warning me-1"></i> Hotline: <strong class="text-warning">037 999 6828</strong>
            </div>
        </div>
    </div>

    <nav class="navbar navbar-expand-lg header-main-bg py-3"> 
        <div class="container">
            <a class="navbar-brand d-flex align-items-center text-white me-4" href="index">
                <img src="assets/images/logoHL.png" alt="HealthLife" class="logo-img me-2 shadow-sm">
                <div class="d-flex flex-column">
                    <span class="fw-bold fs-4 text-uppercase ls-1">HealthLife</span>
                    <small class="text-white-50" style="font-size: 0.75rem;">Thương hiệu uy tín</small>
                </div>
            </a>

            <button class="navbar-toggler border-0 text-white" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMain">
                <i class="bi bi-list fs-1"></i>
            </button>

            <div class="collapse navbar-collapse" id="navbarMain">

                <form class="d-flex flex-grow-1 mx-lg-5 my-2 my-lg-0 search-form-container" action="search" method="get">
                    <div class="input-group">
                        <input class="form-control rounded-pill border-0 py-2 ps-4" type="search" name="keyword" 
                               placeholder="Tìm tên thuốc, thực phẩm chức năng..." aria-label="Search" style="box-shadow: none;">
                        <button class="btn btn-search rounded-pill position-absolute end-0 top-0 h-100 px-3" type="submit">
                            <i class="bi bi-search text-primary fw-bold"></i>
                        </button>
                    </div>
                </form>

                <ul class="navbar-nav align-items-center gap-3 ms-auto">

                    <c:if test="${empty sessionScope.user}">
                        <li class="nav-item">
                            <a href="login.jsp" class="user-action-btn">
                                <div class="icon-box"><i class="bi bi-person-fill"></i></div>
                                <span>Đăng nhập</span>
                            </a>
                        </li>
                    </c:if>

                    <c:if test="${not empty sessionScope.user}">
                        <c:if test="${sessionScope.user.role == 'admin'}">
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/admin" class="btn btn-warning btn-sm fw-bold rounded-pill px-3 shadow-sm">
                                    <i class="bi bi-shield-lock-fill"></i> Quản trị
                                </a>
                            </li>
                        </c:if>

                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle user-action-btn" href="#" id="navbarDropdownAccount" role="button" data-bs-toggle="dropdown">
                                <div class="icon-box"><i class="bi bi-person-circle"></i></div>
                                <span class="d-inline-block text-truncate" style="max-width: 100px;">
                                    ${sessionScope.user.fullname}
                                </span>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2">
                                <li><a class="dropdown-item py-2" href="profile.jsp"><i class="bi bi-info-circle me-2"></i>Thông tin tài khoản</a></li>
                                <li><a class="dropdown-item py-2" href="order-history"><i class="bi bi-clock-history me-2"></i>Lịch sử đơn hàng</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item py-2 text-danger" href="logout"><i class="bi bi-box-arrow-right me-2"></i>Đăng xuất</a></li>
                            </ul>
                        </li>
                    </c:if>

                    <li class="nav-item">
                        <c:set var="cartItemCount" value="${empty sessionScope.cart ? 0 : sessionScope.cart.tongSoLuongTatCaItems}" />
                        <a href="cart-view" class="cart-btn position-relative">
                            <i class="bi bi-cart3 fs-4 text-white"></i>
                            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-warning text-dark border border-light" 
                                  id="cart-count-badge">
                                ${cartItemCount}
                            </span>
                            <span class="d-none d-lg-block ms-2 text-white small fw-bold">Giỏ hàng</span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</header>

<style>
    /* --- FONTS & GENERAL --- */
    body {
        font-family: 'Roboto', sans-serif; /* Font hiện đại hơn */
    }

    /* --- 1. TOP BAR --- */
    .top-bar {
        background-color: #0d3aa9; /* Màu xanh rất đậm phía trên cùng */
    }

    /* --- 2. MAIN HEADER BACKGROUND (STYLE LONG CHÂU) --- */
    .header-main-bg {
        /* Sử dụng Gradient giả lập hiệu ứng 3D chuyên nghiệp */
        background: linear-gradient(135deg, #1250DC 0%, #2a75ff 100%);
        /* NẾU BẠN CÓ ẢNH NỀN THẬT, HÃY UNCOMMENT DÒNG DƯỚI VÀ THAY LINK ẢNH */
        /* background: url('assets/images/header-bg-pattern.png') center/cover no-repeat, linear-gradient(to right, #1250DC, #2a75ff); */
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }

    /* --- 3. LOGO --- */
    .logo-img {
        height: 60px; /* Điều chỉnh lại chút cho cân đối */
        width: 60px;
        object-fit: cover;
        border-radius: 12px; /* Bo góc vuông nhẹ thay vì tròn vo */
        padding: 2px;
    }
    .ls-1 {
        letter-spacing: 1px;
    }

    /* --- 4. SEARCH BAR (Điểm nhấn) --- */
    .search-form-container {
        position: relative;
    }
    /* Input tìm kiếm */
    .search-form-container .form-control {
        padding-right: 50px; /* Chừa chỗ cho nút search */
        font-size: 0.95rem;
    }
    .search-form-container .form-control:focus {
        box-shadow: 0 0 0 3px rgba(255, 255, 255, 0.3); /* Hiệu ứng glow trắng */
    }
    /* Nút search nằm trong input */
    .btn-search {
        background: transparent;
        border: none;
        transition: 0.3s;
        z-index: 5;
    }
    .btn-search:hover i {
        color: #003D9D !important; /* Đổi màu icon khi hover */
        transform: scale(1.1);
    }

    /* --- 5. USER ACTION BUTTONS --- */
    .user-action-btn {
        display: flex;
        align-items: center;
        color: white !important;
        text-decoration: none;
        font-weight: 500;
        padding: 5px 10px;
        border-radius: 50px;
        transition: 0.2s;
        background: rgba(255,255,255,0.1); /* Nền mờ nhẹ */
    }
    .user-action-btn:hover, .dropdown-toggle[aria-expanded="true"] {
        background: rgba(255,255,255,0.25);
    }
    .icon-box {
        width: 32px;
        height: 32px;
        background: white;
        color: #1250DC;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-right: 8px;
        font-size: 1.1rem;
    }

    /* --- 6. CART BUTTON --- */
    .cart-btn {
        display: flex;
        align-items: center;
        text-decoration: none;
        background: rgba(0,0,0,0.2); /* Nền tối hơn chút cho giỏ hàng */
        padding: 8px 15px;
        border-radius: 8px;
        transition: 0.3s;
    }
    .cart-btn:hover {
        background: rgba(0,0,0,0.3);
        transform: translateY(-2px);
    }

    /* --- 7. DROPDOWN MENU --- */
    .dropdown-menu {
        position: absolute;
        z-index: 1050;
        margin-top: 0;
    }
    .dropdown-item:hover {
        background-color: #eef4ff;
        color: #1250DC;
    }
    .nav-item.dropdown:hover .dropdown-menu {
        display: block;
        margin-top: 0; /* tránh bị nhảy vị trí */
    }

    @keyframes fadeIn {
        from {
            opacity: 0;
            transform: translateY(10px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
</style>