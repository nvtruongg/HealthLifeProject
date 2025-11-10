<%--
    Document : search.jsp
    Created on : Nov 07, 2025, 10:00:00 AM
    Author : Nguyen Viet Truong
--%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Kết Quả Tìm Kiếm - HealthLife</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Thêm CSS từ home.jsp -->
        <style>
            .product-card {
                transition: box-shadow 0.3s ease;
            }
            .product-card:hover {
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            }
            .product-card img {
                width: 100%;
                height: 250px; /* Cố định chiều cao ảnh */
                object-fit: contain; /* Hiển thị ảnh vừa vặn, không bị méo */
                padding: 10px;
            }
            .card-title {
                /* Giới hạn tên sản phẩm chỉ 2 dòng */
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
                text-overflow: ellipsis;
                height: 2.5em; /* Chiều cao tương đương 2 dòng */
                font-size: 1rem;
            }
            .card-price {
                font-size: 1.1rem;
                font-weight: bold;
                color: #d70018; /* Màu đỏ cho giá */
            }
        </style>
    </head>
    <body>
        <!-- Navbar giống home.jsp -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container-fluid">
                <a class="navbar-brand" href="home">HealthLife</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link active" href="home">Trang Chủ</a>
                        </li>
                        <c:forEach items="${listC}" var="cat">
                            <li class="nav-item">
                                <a class="nav-link" href="shop?cid=$$ {cat.id}"> $${cat.tenDanhMuc}</a>
                            </li>
                        </c:forEach>
                    </ul>
                    <!-- Form tìm kiếm (thêm ở đây để có trên trang kết quả) -->
                    <form class="d-flex ms-auto" action="search" method="get">
                        <input class="form-control me-2" type="search" name="keyword" placeholder="Tìm sản phẩm..." aria-label="Search" value="${keyword}">
                        <button class="btn btn-outline-success" type="submit">Tìm</button>
                    </form>
                </div>
            </div>
        </nav>
        <!-- Phần nội dung chính -->
        <div class="container mt-4">
            <div class="row">
                <!-- Tiêu đề trang -->
                <div class="col-12">
                    <h1 class="mb-3">Kết Quả Tìm Kiếm Cho: "${keyword}"</h1>
                </div>
                <!-- Hiển thị sản phẩm giống home.jsp -->
                <c:forEach items="${listP}" var="p">
                    <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                        <div class="card h-100 product-card">
                            <a href="detail?pid=${p.id}">
                                <img src="$$ {p.hinhAnhDaiDien}" class="card-img-top" alt=" $${p.tenSanPham}">
                            </a>
                            <div class="card-body d-flex flex-column">
                                <h5 class="card-title">
                                    <a href="detail?pid=$$ {p.id}" class="text-dark text-decoration-none"> $${p.tenSanPham}</a>
                                </h5>
                                <p class="card-text card-price mt-auto">
                                    <fmt:formatNumber type = "number" maxFractionDigits = "0" value = "${p.giaBan}" /> đ
                                </p>
                                <a href="#" class="btn btn-primary mt-2">Thêm vào giỏ</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                <c:if test="${empty listP}">
                    <div class="col-12">
                        <p class="text-center text-muted">Không tìm thấy sản phẩm nào phù hợp với "${keyword}".</p>
                    </div>
                </c:if>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>