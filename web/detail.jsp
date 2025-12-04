<%--
    Document : detail.jsp
    Created on : Nov 07, 2025, 10:00:00 AM
    Author : Nguyen Viet Truong
--%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${product.tenSanPham} | HealthLife</title>

        <jsp:include page="header.jsp" />
        <jsp:include page="navbar.jsp" />

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

        <style>
            /* --- LONG CHÂU STYLE --- */
            :root {
                --lc-blue: #1d48ba;      /* Xanh thương hiệu */
                --lc-blue-hover: #003b85;
                --lc-bg: #f4f6f9;
                --lc-text: #333;
                --lc-border: #e0e0e0;
            }

            body {
                background-color: var(--lc-bg);
                font-family: 'Inter', sans-serif;
                color: var(--lc-text);
            }

            /* KHUNG SẢN PHẨM */
            .product-container {
                background: white;
                border-radius: 12px;
                padding: 24px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.02);
                margin-bottom: 20px;
            }

            /* 1. ẢNH SẢN PHẨM */
            .main-image-box {
                border: 1px solid var(--lc-border);
                border-radius: 8px;
                height: 400px;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-bottom: 12px;
                position: relative;
                overflow: hidden;
            }
            .main-image-box img {
                max-width: 100%;
                max-height: 100%;
                object-fit: contain;
                transition: transform 0.3s;
            }
            .main-image-box:hover img {
                transform: scale(1.05);
            }

            .thumb-list {
                display: flex;
                gap: 10px;
                overflow-x: auto;
                padding-bottom: 5px;
            }
            .thumb-item {
                width: 70px;
                height: 70px;
                border: 1px solid var(--lc-border);
                border-radius: 6px;
                cursor: pointer;
                padding: 2px;
                object-fit: contain;
            }
            .thumb-item.active {
                border: 2px solid var(--lc-blue);
            }

            /* 2. THÔNG TIN SẢN PHẨM */
            .brand-text {
                font-size: 14px;
                color: #666;
            }
            .brand-link {
                color: var(--lc-blue);
                font-weight: 700;
                text-decoration: none;
            }

            .product-title {
                font-size: 24px;
                font-weight: 700;
                color: #222;
                margin: 10px 0;
                line-height: 1.4;
            }

            .price-box {
                display: flex;
                align-items: baseline;
                gap: 10px;
                margin-bottom: 15px;
            }
            .current-price {
                font-size: 32px;
                font-weight: 700;
                color: var(--lc-blue);
            }
            .old-price {
                font-size: 16px;
                color: #999;
                text-decoration: line-through;
            }
            .unit-text {
                font-size: 16px;
                color: #555;
                font-weight: 400;
            }

            /* Box công dụng nổi bật */
            .highlight-box {
                background: #e8f2ff;
                border: 1px dashed #aecdf7;
                border-radius: 8px;
                padding: 12px;
                font-size: 14px;
                margin-bottom: 20px;
                color: #333;
            }

            /* 3. NÚT MUA HÀNG */
            .qty-control {
                display: flex;
                align-items: center;
                border: 1px solid var(--lc-border);
                border-radius: 8px;
                width: 120px;
                height: 40px;
                overflow: hidden;
            }
            .btn-qty {
                width: 35px;
                height: 100%;
                border: none;
                background: white;
                color: var(--lc-blue);
                font-size: 18px;
            }
            .input-qty {
                flex: 1;
                border: none;
                text-align: center;
                font-weight: 600;
                outline: none;
            }

            .action-group {
                display: flex;
                gap: 12px;
                margin-top: 20px;
            }

            /* Nút MUA NGAY (To, Xanh) */
            .btn-buy-now {
                flex: 1;
                background: var(--lc-blue);
                color: white;
                border: none;
                border-radius: 30px;
                padding: 10px;
                font-weight: 700;
                font-size: 16px;
                text-transform: uppercase;
                transition: 0.2s;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
            }
            .btn-buy-now small {
                font-size: 11px;
                text-transform: none;
                font-weight: normal;
                opacity: 0.9;
            }
            .btn-buy-now:hover {
                background: var(--lc-blue-hover);
                color: white;
            }

            /* Nút THÊM GIỎ (Tròn, Viền xanh) */
            .btn-add-cart {
                width: 54px;
                height: 54px;
                border-radius: 50%;
                border: 2px solid var(--lc-blue);
                color: var(--lc-blue);
                background: white;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 22px;
                transition: 0.2s;
            }
            .btn-add-cart:hover {
                background: #f2f6fe;
            }

            /* 4. CHI TIẾT & BẢNG */
            .detail-section {
                background: white;
                border-radius: 12px;
                padding: 24px;
                margin-top: 20px;
            }
            .section-header {
                font-size: 18px;
                font-weight: 700;
                border-bottom: 1px solid var(--lc-border);
                padding-bottom: 10px;
                margin-bottom: 16px;
            }
            .section-sub-title {
                color: var(--lc-blue);
                font-weight: 700;
                margin-top: 20px;
                margin-bottom: 8px;
            }

            .table-specs {
                width: 100%;
                border: 1px solid var(--lc-border);
                border-radius: 8px;
                overflow: hidden;
                font-size: 14px;
            }
            .table-specs th {
                background: #f2f6fe;
                padding: 10px 15px;
                text-align: left;
                width: 30%;
                border-bottom: 1px solid var(--lc-border);
            }
            .table-specs td {
                padding: 10px 15px;
                border-bottom: 1px solid var(--lc-border);
            }

            /* Chính sách */
            .policy-row {
                display: flex;
                justify-content: space-between;
                text-align: center;
                padding-top: 15px;
                margin-top: 20px;
                border-top: 1px solid var(--lc-border);
                font-size: 13px;
                color: #666;
            }
            .policy-item i {
                font-size: 20px;
                color: var(--lc-blue);
                margin-bottom: 5px;
                display: block;
            }

            /* TOAST */
            .toast-container {
                position: fixed;
                top: 90px;
                right: 20px;
                z-index: 9999;
            }
        </style>
    </head>
    <body>

        <c:if test="${empty product}">
            <div class="container text-center py-5">
                <h3>Không tìm thấy sản phẩm!</h3>
                <a href="home" class="btn btn-primary mt-3">Quay lại trang chủ</a>
            </div>
        </c:if>

        <c:if test="${not empty product}">
            <div class="container py-4">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-3 small">
                        <li class="breadcrumb-item"><a href="shop" class="text-decoration-none text-secondary">Trang chủ</a></li>
                        <li class="breadcrumb-item active text-primary fw-bold">${product.tenSanPham}</li>
                    </ol>
                </nav>

                <div class="product-container">
                    <div class="row">
                        <div class="col-lg-5">
                            <div class="main-image-box">
                                <img src="assets/images/${product.id}.jpg" class="card-img-top" onerror="this.src='${product.hinhAnhDaiDien}'">
                            </div>
                            <div class="thumb-list">
                                <img src="${product.hinhAnhDaiDien}" class="thumb-item active" onclick="changeImage(this)">
                                <c:forEach items="${listImages}" var="img">
                                    <img src="${img.urlHinhAnh}" class="thumb-item" onclick="changeImage(this)">
                                </c:forEach>
                            </div>
                        </div>

                        <div class="col-lg-7 ps-lg-4 mt-3 mt-lg-0">
                            <div class="brand-text">
                                Thương hiệu: <a href="#" class="brand-link">${product.tenThuongHieu}</a> 
                                <span class="mx-2">|</span> Mã SP: ${product.id}
                            </div>

                            <h1 class="product-title">${product.tenSanPham}</h1>

                            <div class="price-box">
                                <span class="current-price">
                                    <fmt:formatNumber value="${product.giaBan}" type="number" maxFractionDigits="0"/>đ
                                </span>
                                <span class="unit-text">/ ${product.donViTinh}</span>
                                <c:if test="${product.giaGoc > product.giaBan}">
                                    <span class="old-price">
                                        <fmt:formatNumber value="${product.giaGoc}" type="number" maxFractionDigits="0"/>đ
                                    </span>
                                </c:if>
                            </div>

                            <div class="highlight-box">
                                <strong><i class="bi bi-stars text-warning"></i> Công dụng chính: </strong> 
                                ${not empty product.moTaNgan ? product.moTaNgan : product.congDung}
                            </div>

                            <form action="buy-now" method="POST" id="buyForm">
                                <input type="hidden" name="productId" value="${product.id}">

                                <div class="d-flex align-items-center gap-3 mb-3">
                                    <span class="fw-bold">Chọn số lượng:</span>
                                    <div class="qty-control">
                                        <button type="button" class="btn-qty" onclick="updateQty(-1)">-</button>
                                        <input type="number" id="qtyInput" name="quantity" class="input-qty" value="1" min="1" max="${product.soLuongTon}">
                                        <button type="button" class="btn-qty" onclick="updateQty(1)">+</button>
                                    </div>
                                    <span class="text-success small fw-bold">
                                        <i class="bi bi-check-circle-fill"></i> Còn hàng
                                    </span>
                                </div>

                                <div class="action-group">
                                    <button type="button" class="btn-buy-now" id="btnAddCart" title="Thêm vào giỏ hàng">
                                        Mua Ngay
                                        <small>Giao hàng tận nơi hoặc nhận tại cửa hàng</small>
                                    </button>


                                </div>
                            </form>

                            <div class="policy-row">
                                <div class="policy-item"><i class="bi bi-shield-check"></i>100% Chính hãng</div>
                                <div class="policy-item"><i class="bi bi-truck"></i>Miễn phí vận chuyển</div>
                                <div class="policy-item"><i class="bi bi-arrow-repeat"></i>Đổi trả 30 ngày</div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-8">
                        <div class="detail-section">
                            <h4 class="section-header">Thông tin chi tiết</h4>

                            <h6 class="section-sub-title">Mô tả sản phẩm</h6>
                            <div class="text-secondary mb-3" style="line-height: 1.6;">
                                ${not empty product.moTaChiTiet ? product.moTaChiTiet : 'Đang cập nhật...'}
                            </div>

                            <h6 class="section-sub-title">Thành phần</h6>
                            <table class="table-specs">
                                <tbody>
                                    <tr><th>Thành phần</th><td>${product.thanhPhan}</td></tr>
                                </tbody>
                            </table>

                            <h6 class="section-sub-title">Công dụng</h6>
                            <p class="text-secondary">${product.congDung}</p>

                            <h6 class="section-sub-title">Liều dùng & Cách dùng</h6>
                            <div class="bg-light p-3 rounded border text-secondary small">
                                ${product.lieuDungCachDung}
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-4">
                        <div class="detail-section">
                            <h5 class="section-header" style="font-size: 16px;">Sản phẩm cùng danh mục</h5>
                            <c:forEach items="${relatedProducts}" var="p">
                                <div class="d-flex gap-3 mb-3 pb-3 border-bottom">
                                    <a href="detail?pid=${p.id}" class="flex-shrink-0">
                                        <img src="${p.hinhAnhDaiDien}" style="width: 60px; height: 60px; object-fit: contain; border: 1px solid #eee; border-radius: 6px;">
                                    </a>
                                    <div>
                                        <a href="detail?pid=${p.id}" class="text-decoration-none text-dark fw-bold small d-block mb-1">
                                            ${p.tenSanPham}
                                        </a>
                                        <span class="text-primary fw-bold small">
                                            <fmt:formatNumber value="${p.giaBan}" type="number" maxFractionDigits="0"/>đ
                                        </span>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>

        <jsp:include page="footer.jsp" />

        <div class="toast-container">
            <div id="liveToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="toast-header bg-success text-white">
                    <strong class="me-auto"><i class="bi bi-check-circle"></i> Thành công</strong>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast"></button>
                </div>
                <div class="toast-body bg-white" id="toastMsg">Đã thêm vào giỏ hàng!</div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                        // 1. Chuyển ảnh Gallery
                                        function changeImage(element) {
                                            document.getElementById('mainImage').src = element.src;
                                            document.querySelectorAll('.thumb-item').forEach(img => img.classList.remove('active'));
                                            element.classList.add('active');
                                        }

                                        // 2. Tăng giảm số lượng (Client Side)
                                        function updateQty(val) {
                                            const input = document.getElementById('qtyInput');
                                            let current = parseInt(input.value);
                                            let max = parseInt(input.getAttribute('max'));
                                            let newValue = current + val;
                                            if (newValue >= 1 && newValue <= max) {
                                                input.value = newValue;
                                            }
                                        }

                                        // 3. Xử lý Thêm giỏ hàng (AJAX Fetch)
                                        document.getElementById('btnAddCart').addEventListener('click', function () {
                                            const pid = '${product.id}';
                                            const qty = document.getElementById('qtyInput').value;

                                            // Gọi Servlet (Đảm bảo Servlet nhận tham số quantity)
                                            fetch('cart-handler?action=add&id=' + pid + '&quantity=' + qty)
                                                    .then(res => res.json())
                                                    .then(data => {
                                                        if (data.success) {
                                                            // Show Toast
                                                            document.getElementById('toastMsg').innerText = data.message;
                                                            const toast = new bootstrap.Toast(document.getElementById('liveToast'));
                                                            toast.show();

                                                            // Update header (nếu có)
                                                            if (document.getElementById('cartCount')) {
                                                                document.getElementById('cartCount').innerText = data.cartCount;
                                                            }
                                                        } else {
                                                            alert('Lỗi: ' + data.message);
                                                        }
                                                    })
                                                    .catch(err => console.error('Error:', err));
                                        });
        </script>

    </body>
</html>