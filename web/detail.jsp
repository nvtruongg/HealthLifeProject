<%--
    Document : detail.jsp
    Created on : Nov 07, 2025, 10:00:00 AM
    Author : Nguyen Viet Truong
--%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="header.jsp" %> <!-- Include header -->
<%@ include file="navbar.jsp" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi Tiết Sản Phẩm - ${product.tenSanPham} - HealthLife</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .product-card {
                border: 1px solid #eee;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
                transition: transform 0.3s, box-shadow 0.3s;
            }
            .product-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 6px 18px rgba(40,167,69,0.2);
            }
            .product-img-main {
                width: 100%;
                height: auto;
                max-height: 400px;
                object-fit: contain;
                border-radius: 10px 10px 0 0;
            }
            .product-thumbs img {
                width: 80px;
                height: 80px;
                object-fit: contain;
                cursor: pointer;
                margin: 5px;
                border: 2px solid #ddd;
                border-radius: 5px;
            }
            .product-thumbs img.active {
                border-color: #28a745;
                box-shadow: 0 0 5px #28a745;
            }
            .price-original {
                text-decoration: line-through;
                color: #999;
                font-size: 1.1rem;
            }
            .price-sale {
                color: #dc3545;
                font-weight: bold;
                font-size: 1.8rem;
                margin-right: 10px;
            }
            .add-to-cart {
                background-color: #28a745;
                color: white;
                font-weight: bold;
                border-radius: 5px;
                transition: background-color 0.3s;
            }
            .add-to-cart:hover {
                background-color: #218838;
            }
            .section-heading {
                font-size: 1.7rem;
                font-weight: 700;
                color: #333;
                margin-top: 30px;
                border-bottom: 3px solid #28a745;
                padding-bottom: 10px;
                position: relative;
            }
            .section-heading::after {
                content: '';
                position: absolute;
                bottom: -3px;
                left: 0;
                width: 50px;
                height: 3px;
                background: linear-gradient(to right, #28a745, #007bff);
            }
            .review-star {
                color: #ffc107;
                font-size: 1.2rem;
            }
            .quantity-input {
                max-width: 100px;
            }
            @media (max-width: 768px) {
                .product-card {
                    margin-bottom: 20px;
                }
                .col-md-5, .col-md-7 {
                    flex: 0 0 100%;
                    max-width: 100%;
                }
                .price-sale {
                    font-size: 1.5rem;
                }
                .section-heading {
                    font-size: 1.4rem;
                }
            }
        </style>
    </head>
    <jsp:include page="cskh.jsp" />
    <body>
        <div class="container mt-4">
            <c:if test="${not empty product}">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb bg-light p-2 rounded">
                        <li class="breadcrumb-item"><a href="shop" class="text-primary">Trang Chủ</a></li>
                        <li class="breadcrumb-item"><a href="shop?cid=${product.idDanhMuc}" class="text-primary">Danh Mục Sản Phẩm</a></li>
                        <li class="breadcrumb-item active" aria-current="page">${product.tenSanPham}</li>
                    </ol>
                </nav>

                <div class="card product-card mb-4">
                    <div class="row g-0">
                        <div class="col-md-5">
                            <img src="Images/${product.id}.jpg" class="product-img-main" onerror="this.src='${p.hinhAnhDaiDien}'">
                            <div class="product-thumbs d-flex justify-content-center mt-2">
                                <img src="${product.hinhAnhDaiDien}" class="active">
                            </div>
                        </div>
                        <div class="col-md-7">
                            <div class="card-body">
                                <h2 class="card-title">${product.tenSanPham}</h2>
                                <p class="card-text"><strong>Mã sản phẩm:</strong> ${product.maSanPham}</p>
                                <p class="card-text">
                                    <span class="price-original"><fmt:formatNumber type="number" maxFractionDigits="0" value="${product.giaGoc}" /> đ</span>
                                    <span class="price-sale"><fmt:formatNumber type="number" maxFractionDigits="0" value="${product.giaBan}" /> đ</span>
                                </p>
                                <p class="card-text"><strong>Số lượng tồn:</strong> ${product.soLuongTon} ${product.donViTinh}</p>
                                <div class="d-flex align-items-center mb-3">
                                    <label for="quantity" class="me-2">Số lượng:</label>
                                    <input type="number" id="quantity" value="1" min="1" max="${product.soLuongTon}" class="form-control quantity-input me-2">
                                    <button type="button" class="btn btn-primary mt-2 btn-add-to-cart"
                                            data-product-id="${p.id}">
                                        <i class="bi bi-cart-plus"></i> Thêm vào giỏ
                                    </button>
                                </div>
                                <p class="card-text text-muted">Sản phẩm đang được chú ý, có <strong>X</strong> người thêm vào giỏ & <strong>Y</strong> người đang xem.</p>
                                <p class="card-text">${product.moTaNgan}</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="mt-4">
                    <h3 class="section-heading">Mô tả sản phẩm</h3>
                    <p class="text-muted">${product.moTaChiTiet}</p>
                    <h3 class="section-heading">Công dụng</h3>
                    <p class="text-muted">${product.congDung}</p>
                    <h3 class="section-heading">Liều dùng và cách dùng</h3>
                    <p class="text-muted">${product.lieuDungCachDung}</p>
                    <h3 class="section-heading">Thành phần</h3>
                    <p class="text-muted">${product.thanhPhan}</p>
                    <h3 class="section-heading">Bảo quản</h3>
                    <p class="text-muted">${product.baoQuan}</p>
                    <h3 class="section-heading">Lưu ý</h3>
                    <p class="text-warning">Không dùng cho người mẫn cảm với thành phần. Tham khảo bác sĩ trước khi dùng.</p>
                </div>

                <div class="mt-5">
                    <h3 class="section-heading">Đánh giá sản phẩm <span class="badge bg-success text-white">(0)</span></h3>
                    <div class="review-star mb-2">
                        <span>★★★★★</span> <small>(5.0 / 5)</small>
                    </div>
                    <c:forEach items="${listReviews}" var="review">
                        <div class="border-bottom py-3">
                            <p class="mb-1"><strong>${review.idNguoiDung}</strong> - <span class="text-warning">${review.soSao} sao</span></p>
                            <p class="text-muted">${review.binhLuan}</p>
                        </div>
                    </c:forEach>
                    <c:if test="${empty listReviews}">
                        <p class="text-center text-muted">Chưa có đánh giá nào.</p>
                    </c:if>
                </div>

                <div class="mt-5">
                    <h3 class="section-heading">Hỏi đáp <span class="badge bg-info text-white">(0)</span></h3>
                    <p class="text-muted">Nếu bạn có câu hỏi, hãy để lại bình luận.</p>
                </div>

                <div class="mt-5">
                    <h3 class="section-heading">Sản phẩm liên quan</h3>
                    <div class="row">
                        <c:forEach items="${relatedProducts}" var="p" begin="0" end="3">
                            <div class="col-md-3 mb-4">
                                <div class="card h-100 shadow-sm">
                                    <a href="detail?pid=${p.id}">
                                        <img src="${p.hinhAnhDaiDien}" class="card-img-top" alt="${p.tenSanPham}" style="height: 200px; object-fit: contain;">
                                    </a>
                                    <div class="card-body">
                                        <h5 class="card-title">${p.tenSanPham}</h5>
                                        <p class="card-text price-sale"><fmt:formatNumber type="number" maxFractionDigits="0" value="${p.giaBan}" /> đ</p>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:if>
            <c:if test="${empty product}">
                <div class="alert alert-danger text-center mt-4" role="alert">
                    Sản phẩm không tồn tại hoặc đã ngừng kinh doanh.
                </div>
            </c:if>
        </div>
        
        <script>
            document.querySelectorAll('.product-thumbs img').forEach(thumb => {
                thumb.addEventListener('click', function () {
                    document.querySelector('.product-img-main').src = this.src;
                    document.querySelectorAll('.product-thumbs img').forEach(t => t.classList.remove('active'));
                    this.classList.add('active');
                });
            });
        </script>
    </body>
</html>