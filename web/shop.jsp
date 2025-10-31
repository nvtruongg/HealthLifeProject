<%-- 
    Document   : shop
    Created on : Oct 25, 2025, 7:03:58 PM
    Author     : Nguyen Viet Truong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sản phẩm - HealthLife</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Sử dụng lại CSS từ home.jsp -->
        <style>
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
        </style>
    </head>
    <body>
        <!-- Thanh Navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container-fluid">
                <a class="navbar-brand" href="home">HealthLife</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" href="home">Trang Chủ</a>
                        </li>

                        <!-- Lặp qua danh mục -->
                        <c:forEach items="${listC}" var="cat">
                            <%-- Kiểm tra xem danh mục này có phải là danh mục đang active không --%>
                            <li class="nav-item">
                                <a class="nav-link ${cat.id == activeCid ? 'active' : ''}" 
                                   href="shop?cid=${cat.id}">
                                    ${cat.tenDanhMuc}
                                </a>
                            </li>
                        </c:forEach>

                    </ul>
                </div>
            </div>
        </nav>

        <!-- Phần nội dung chính -->
        <div class="container mt-4">
            <div class="row">
                <p> Tiêu đề trang (Có thể thay đổi động) </p>
                <div class="col-12">
                    <%-- TODO: Thêm logic để hiển thị tên danh mục --%>
                    <h1 class="mb-3">Danh mục Sản phẩm</h1>
                </div>

                <!-- Hiển thị sản phẩm đã lọc -->
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
                                    <fmt:formatNumber type = "number" maxFractionDigits = "0" value = "${p.giaBan}" /> đ
                                </p>
                                <a href="#" class="btn btn-primary mt-2">Thêm vào giỏ</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>

                <!-- Hiển thị khi không có sản phẩm nào -->
                <c:if test="${empty listP}">
                    <div class="col-12">
                        <p class="text-center text-muted">Không có sản phẩm nào trong danh mục này.</p>
                    </div>
                </c:if>

            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
