<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Shop - HealthLife</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .product-card {
            transition: box-shadow 0.3s ease;
        }
        .product-card:hover {
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
        .product-card img {
            width: 100%;
            height: 250px;
            object-fit: contain;
            padding: 10px;
        }
        .card-title {
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
            height: 2.5em;
            font-size: 1rem;
        }
        .card-price {
            font-size: 1.1rem;
            font-weight: bold;
            color: #d70018;
        }
        .pagination a {
            color: #000;
            padding: 8px 14px;
            text-decoration: none;
            border: 1px solid #ddd;
            margin: 0 3px;
            border-radius: 5px;
        }
        .pagination a.active {
            background-color: #007bff;
            color: white;
            border: 1px solid #007bff;
        }
        .pagination a:hover {
            background-color: #ddd;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="home">HealthLife</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="home">Trang chủ</a>
                </li>
                <c:forEach items="${listC}" var="cat">
                    <li class="nav-item">
                        <a class="nav-link ${cat.id == currentCategory ? 'active' : ''}"
                           href="shop?cid=${cat.id}">
                            ${cat.tenDanhMuc}
                        </a>
                    </li>
                </c:forEach>
            </ul>

            <ul class="navbar-nav">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <li class="nav-item">
                            <span class="nav-link text-light">Xin chào, ${sessionScope.user.fullname}</span>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-warning" href="logout">Đăng xuất</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item"><a class="nav-link" href="login.jsp">Đăng nhập</a></li>
                        <li class="nav-item"><a class="nav-link" href="register.jsp">Đăng ký</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<!-- Nội dung chính -->
<div class="container mt-4">
    <div class="row">
        <h2 class="mb-4 text-center">Danh sách sản phẩm</h2>

        <!-- Nếu không có sản phẩm -->
        <c:if test="${empty listP}">
            <div class="col-12 text-center text-muted">
                <p>Không có sản phẩm nào trong danh mục này.</p>
            </div>
        </c:if>

        <!-- Hiển thị sản phẩm -->
        <c:forEach items="${listP}" var="p">
            <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                <div class="card h-100 product-card">
                    <a href="#">
                        <img src="${p.hinhAnhDaiDien}" class="card-img-top" alt="${p.tenSanPham}">
                    </a>
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title">
                            <a href="#" class="text-dark text-decoration-none">${p.tenSanPham}</a>
                        </h5>
                        <p class="card-text card-price mt-auto">
                            <fmt:formatNumber value="${p.giaBan}" type="number" maxFractionDigits="0" /> đ
                        </p>
                        <a href="#" class="btn btn-primary mt-2">Thêm vào giỏ</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- PHÂN TRANG -->
    <div class="d-flex justify-content-center mt-4">
        <div class="pagination">
            <c:forEach begin="1" end="${totalPages}" var="i">
                <c:url var="pageUrl" value="shop">
                    <c:param name="page" value="${i}" />
                    <c:if test="${currentCategory != null}">
                        <c:param name="cid" value="${currentCategory}" />
                    </c:if>
                </c:url>

                <a href="${pageUrl}" class="${i == currentPage ? 'active' : ''}">
                    ${i}
                </a>
            </c:forEach>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
