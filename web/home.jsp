<%--
    Document : home.jsp
    Created on : Oct 25, 2025, 6:20:41 PM
    Author : Nguyen Viet Truong
--%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="header.jsp" %> <!-- Include header -->

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Trang chủ - HealthLife</title>
        <style>
            .section-title {
                font-size: 2.2rem;
                font-weight: 700;
                color: #333;
                position: relative;
                padding-bottom: 10px;
                margin-bottom: 20px;
                text-align: center;
            }
            .section-title::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 50%;
                transform: translateX(-50%);
                width: 60px;
                height: 4px;
                background: linear-gradient(to right, #28a745, #007bff);
            }
            .product-card {
                border: 1px solid #eee;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
                transition: transform 0.3s, box-shadow 0.3s;
                overflow: hidden;
                background: #fff;
            }
            .product-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 6px 18px rgba(40,167,69,0.2);
            }
            .product-card img {
                width: 100%;
                height: 250px;
                object-fit: contain;
                padding: 10px;
                background: #f8f9fa;
            }
            .card-title {
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
                text-overflow: ellipsis;
                height: 2.5em;
                font-size: 1.1rem;
                color: #333;
                font-weight: 500;
            }
            .card-title a {
                color: #333;
                text-decoration: none;
                transition: color 0.3s;
            }
            .card-title a:hover {
                color: #28a745;
            }
            .card-price {
                font-size: 1.3rem;
                font-weight: bold;
                color: #dc3545;
                margin-top: 10px;
            }
            .btn-primary {
                background-color: #28a745;
                border-color: #28a745;
                transition: background-color 0.3s;
            }
            .btn-primary:hover {
                background-color: #218838;
                border-color: #218838;
            }
            @media (max-width: 768px) {
                .section-title { font-size: 1.8rem; }
                .product-card img { height: 200px; }
                .col-lg-3 { flex: 0 0 50%; max-width: 50%; margin-bottom: 20px; }
            }
            @media (max-width: 576px) {
                .col-lg-3 { flex: 0 0 100%; max-width: 100%; }
            }
        </style>
    </head>
    <body>
        <div class="container mt-4">
            <div class="row">
                <div class="col-12">
                    <h1 class="section-title">Sản phẩm Nổi Bật</h1>
                </div>
                <c:forEach items="${listP}" var="p">
                    <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                        <div class="card h-100 product-card">
                            <a href="detail?pid=${p.id}">
                                <img src="${p.hinhAnhDaiDien}" class="card-img-top" alt="${p.tenSanPham}">
                            </a>
                            <div class="card-body d-flex flex-column">
                                <h5 class="card-title">
                                    <a href="detail?pid=${p.id}">${p.tenSanPham}</a>
                                </h5>
                                <p class="card-text card-price mt-auto">
                                    <fmt:formatNumber type="number" maxFractionDigits="0" value="${p.giaBan}" /> đ
                                </p>
                                <a href="#" class="btn btn-primary mt-2">Thêm vào giỏ</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                <c:if test="${empty listP}">
                    <div class="col-12">
                        <p class="text-center text-muted h4">Không có sản phẩm nào để hiển thị.</p>
                    </div>
                </c:if>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>