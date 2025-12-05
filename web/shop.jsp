<%-- 
    Document : shop.jsp
    Description: Trang danh sách sản phẩm với Bộ lọc bên trái và Sắp xếp bên phải
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${pageTitle} - HealthLife</title>

        <!-- Include Header (Chứa CSS/JS Bootstrap) -->
        <%@ include file="header.jsp" %>
        <%@ include file="navbar.jsp" %>

        <style>
            body {
                background-color: #f4f6f9; /* Màu nền xám xanh nhẹ */
            }

            /* --- SIDEBAR BỘ LỌC --- */
            .filter-sidebar {
                background: white;
                border-radius: 8px;
                padding: 12px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            }
            .filter-header {
                font-weight: 700;
                font-size: 0.9rem;
                margin-bottom: 1rem;
                display: flex;
                align-items: center;
            }
            .filter-group-title {
                font-weight: 600;
                font-size: 0.95rem;
                margin-top: 1rem;
                margin-bottom: 0.5rem;
                display: flex;
                justify-content: space-between;
                cursor: pointer;
            }
            /* Nút chọn khoảng giá */
            .price-option {
                display: block;
                padding: 6px 10px;
                margin-bottom: 6px;
                border: 1px solid #dee2e6;
                border-radius: 6px;
                color: #333;
                text-decoration: none;
                font-size: 0.85rem;
                text-align: center;
                transition: all 0.2s;
                cursor: pointer;
            }
            .price-option:hover, .price-option.active {
                border-color: #003D9D;
                background-color: #f0f4ff;
                color: #003D9D;
                font-weight: 500;
            }
            /* Input radio ẩn để xử lý logic form */
            .filter-radio {
                display: none;
            }

            /* --- MAIN CONTENT HEADER --- */
            .shop-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 1rem;
                padding: 10px;
                background: white;
                border-radius: 8px;
                box-shadow: 0 1px 3px rgba(0,0,0,0.05);
            }
            .category-title {
                font-size: 1.3rem;
                font-weight: 700;
                color: #333;
                margin: 0;
            }
            .sort-options {
                display: flex;
                gap: 8px;
                align-items: center;
            }
            .sort-btn {
                border: 1px solid #dee2e6;
                background: white;
                color: #555;
                padding: 4px 12px;
                border-radius: 15px;
                font-size: 0.85rem;
                text-decoration: none;
                transition: all 0.2s;
            }
            .sort-btn:hover {
                background-color: #003D9D;
                color: white;
                border-color: #003D9D;
            }
            .sort-btn.active {
                background-color: #003D9D;
                color: white;
                border-color: #003D9D;
            }

            /* --- PRODUCT CARD (Điều chỉnh lại cho cột nhỏ hơn) --- */
            .product-card {
                background: white;
                border-radius: 8px;
                border: 1px solid #eee;
                transition: transform 0.2s, box-shadow 0.2s;
                height: 100%;
                overflow: hidden;
                position: relative;
            }
            .product-card:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(0, 61, 157, 0.15);
                border-color: #b3d7ff;
            }
            .card-img-wrapper {
                height: 160px; /* Thu nhỏ ảnh */
                padding: 10px;
                display: flex;
                align-items: center;
                justify-content: center;
                background: #fff;
            }
            .card-img-top {
                max-height: 100%;
                max-width: 100%;
                object-fit: contain;
            }
            .card-body {
                padding: 10px;
                display: flex;
                flex-direction: column;
            }
            .card-title {
                font-size: 0.9rem;
                font-weight: 600;
                line-height: 1.3;
                height: 2.6em; /* Giới hạn 2 dòng */
                overflow: hidden;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                margin-bottom: 6px;
            }
            .card-title a {
                color: #333;
                text-decoration: none;
            }
            .card-title a:hover {
                color: #003D9D;
            }
            .price-section {
                margin-top: auto; /* Đẩy giá xuống đáy */
            }
            .current-price {
                color: #d70018;
                font-weight: 700;
                font-size: 1rem;
            }
            .original-price {
                color: #999;
                font-size: 0.8rem;
                text-decoration: line-through;
                margin-left: 4px;
            }
            .btn-buy {
                background-color: #003D9D;
                color: white;
                border: none;
                width: 100%;
                padding: 6px;
                border-radius: 15px; /* Bo tròn hơn */
                font-size: 0.85rem;
                font-weight: 600;
                margin-top: 8px;
                transition: 0.2s;
            }
            .btn-buy:hover {
                background-color: #002a6c;
            }
            /* LOAD MORE BUTTON */
            #loadMoreBtn {
                display: block;
                margin: 20px auto;
                padding: 8px 30px;
                background: white;
                border: 1px solid #003D9D;
                color: #003D9D;
                border-radius: 20px;
                font-weight: 600;
                transition: 0.3s;
            }
            #loadMoreBtn:hover {
                background: #003D9D;
                color: white;
            }
            /* Class để ẩn sản phẩm */
            .product-item.hidden {
                display: none !important;
            }

            /* Accordion style cho bộ lọc */
            .accordion-button {
                padding: 0.7rem 1rem;
                font-size: 0.9rem;
                font-weight: 600;
            }
            .accordion-body {
                padding: 0.5rem 1rem;
                font-size: 0.85rem;
            }
        </style>
    </head>
    <body>

        <div class="container-fluid px-4 mt-3 mb-5">
            <!-- Breadcrumb (Đường dẫn) -->
            <nav aria-label="breadcrumb" class="mb-2" style="font-size: 0.85rem;">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="shop" class="text-decoration-none text-muted">Trang chủ</a></li>
                    <li class="breadcrumb-item active text-primary fw-bold" aria-current="page">${pageTitle}</li>
                </ol>
            </nav>

            <div class="row gx-3">
                <!-- === CỘT TRÁI: BỘ LỌC (SIDEBAR) === -->
                <div class="col-lg-2 d-none d-lg-block">
                    <div class="filter-sidebar">
                        <div class="filter-header">
                            <i class="bi bi-funnel-fill me-2"></i> Bộ lọc nâng cao
                        </div>

                        <form action="shop" method="GET" id="filterForm">
                            <!-- Giữ lại category ID nếu đang lọc theo danh mục -->
                            <c:if test="${not empty param.cid}">
                                <input type="hidden" name="cid" value="${param.cid}">
                            </c:if>
                            <!-- Input ẩn cho sort -->
                            <input type="hidden" name="sort" id="sortInput" value="${param.sort}">

                            <!-- 1. Lọc theo Giá -->
                            <div class="mb-3">
                                <div class="filter-group-title">Giá bán <i class="bi bi-chevron-up"></i></div>
                                <div>
                                    <label class="price-option ${param.price == '0-100000' ? 'active' : ''}">
                                        <input type="radio" name="price" value="0-100000" class="filter-radio" onchange="this.form.submit()">
                                        Dưới 100.000đ
                                    </label>
                                    <label class="price-option ${param.price == '100000-300000' ? 'active' : ''}">
                                        <input type="radio" name="price" value="100000-300000" class="filter-radio" onchange="this.form.submit()">
                                        100.000đ đến 300.000đ
                                    </label>
                                    <label class="price-option ${param.price == '300000-500000' ? 'active' : ''}">
                                        <input type="radio" name="price" value="300000-500000" class="filter-radio" onchange="this.form.submit()">
                                        300.000đ đến 500.000đ
                                    </label>
                                    <label class="price-option ${param.price == '500000-max' ? 'active' : ''}">
                                        <input type="radio" name="price" value="500000-max" class="filter-radio" onchange="this.form.submit()">
                                        Trên 500.000đ
                                    </label>
                                </div>
                            </div>

                            <!-- 2. Các bộ lọc khác (Accordion) -->
                            <div class="accordion" id="filterAccordion">                               
                                <!-- Thương hiệu -->
                                <div class="accordion-item">
                                    <h2 class="accordion-header" id="headingTwo">
                                        <button class="accordion-button collapsed fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo">
                                            Thương hiệu
                                        </button>
                                    </h2>
                                    <!-- Thêm class logic: Nếu đang lọc brand nào thì mở accordion này ra -->
                                    <div id="collapseTwo" class="accordion-collapse collapse ${not empty param.bid ? 'show' : ''}" data-bs-parent="#filterAccordion">
                                        <div class="accordion-body" style="max-height: 200px; overflow-y: auto;"> <!-- Thêm scroll nếu danh sách dài -->

                                            <!-- Tùy chọn 'Tất cả' để người dùng có thể bỏ chọn -->
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="bid" value="" id="brand_all" 
                                                       ${empty param.bid ? 'checked' : ''} onchange="this.form.submit()">
                                                <label class="form-check-label" for="brand_all">
                                                    Tất cả
                                                </label>
                                            </div>

                                            <!-- Dùng vòng lặp c:forEach để lấy dữ liệu từ listTH -->
                                            <c:forEach items="${listTH}" var="th">
                                                <div class="form-check">
                                                    <!-- 
                                                        1. name="bid": Tên tham số gửi lên URL
                                                        2. value="${th.id}": Giá trị là ID của thương hiệu
                                                        3. checked: Giữ trạng thái đã chọn nếu ID trên URL khớp với ID này
                                                        4. onchange: Tự động submit form khi chọn
                                                    -->
                                                    <input class="form-check-input" type="radio" name="bid" value="${th.id}" id="brand_${th.id}"
                                                           ${param.bid == th.id ? 'checked' : ''} onchange="this.form.submit()">
                                                    <label class="form-check-label" for="brand_${th.id}">
                                                        ${th.tenThuongHieu}
                                                    </label>
                                                </div>
                                            </c:forEach>

                                            <!-- Thông báo nếu chưa có dữ liệu -->
                                            <c:if test="${empty listTH}">
                                                <p class="text-muted small fst-italic">Đang cập nhật...</p>
                                            </c:if>

                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Nút reset bộ lọc -->
                            <a href="shop${not empty param.cid ? '?cid='.concat(param.cid) : ''}" class="btn btn-outline-secondary w-100 mt-3 btn-sm">
                                Xóa bộ lọc
                            </a>
                        </form>
                    </div>
                </div>

                <!-- === CỘT PHẢI: DANH SÁCH SẢN PHẨM === -->
                <div class="col-lg-10">
                    <!-- Header: Tên danh mục & Sắp xếp -->
                    <div class="shop-header py-2 px-3" >
                        <!-- Tiêu đề danh mục -->
                        <h1 class="category-title">${pageTitle}</h1>

                        <!-- Sắp xếp -->
                        <div class="sort-options">
                            <span class="text-muted me-2 small">Sắp xếp theo:</span>

                            <!-- Logic JS sẽ set value vào input ẩn và submit form -->
                            <a href="javascript:void(0)" onclick="submitSort('best')" 
                               class="sort-btn ${empty param.sort || param.sort == 'best' ? 'active' : ''}">
                                Bán chạy
                            </a>
                            <a href="javascript:void(0)" onclick="submitSort('asc')" 
                               class="sort-btn ${param.sort == 'asc' ? 'active' : ''}">
                                Giá thấp
                            </a>
                            <a href="javascript:void(0)" onclick="submitSort('desc')" 
                               class="sort-btn ${param.sort == 'desc' ? 'active' : ''}">
                                Giá cao
                            </a>
                        </div>
                    </div>

                    <!-- Lưới sản phẩm -->
                    <div class="row g-2">
                        <c:forEach items="${listP}" var="p" varStatus="status">
                            <div class="col-6 col-md-4 col-lg-3 product-item">
                                <div class="product-card h-100">
                                    <a href="detail?pid=${p.id}" class="card-img-wrapper">
                                        <img src="assets/images/${p.id}.jpg" class="card-img-top" onerror="this.src='${p.hinhAnhDaiDien}'">
                                    </a>
                                    <div class="card-body">
                                        <h5 class="card-title">
                                            <a href="detail?pid=${p.id}" title="${p.tenSanPham}">${p.tenSanPham}</a>
                                        </h5>

                                        <!-- Đơn vị tính -->
                                        <div class="product-unit">${p.donViTinh}</div>

                                        <div class="price-section">
                                            <div class="d-flex align-items-baseline flex-wrap">
                                                <span class="current-price">
                                                    <fmt:formatNumber type="number" maxFractionDigits="0" value="${p.giaBan}" /> đ
                                                </span>
                                                <c:if test="${p.giaGoc > p.giaBan}">
                                                    <span class="original-price">
                                                        <fmt:formatNumber type="number" maxFractionDigits="0" value="${p.giaGoc}" /> đ
                                                    </span>
                                                </c:if>
                                            </div>
                                        </div>

                                        <!-- Nút Mua hàng (AJAX) -->
                                        <button type="button" class="btn-buy btn-add-to-cart" data-product-id="${p.id}">
                                            Chọn mua
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>

                        <!-- Thông báo nếu không có sản phẩm -->
                        <c:if test="${empty listP}">
                            <div class="col-12">
                                <div class="text-center py-5">
                                    <img src="https://placehold.co/200x200/F0F2F5/AAAAAA?text=Khong+tim+thay" alt="Empty" class="mb-3 rounded-circle">
                                    <h4>Không tìm thấy sản phẩm nào</h4>
                                    <p class="text-muted">Vui lòng thử thay đổi bộ lọc hoặc từ khóa tìm kiếm.</p>
                                </div>
                            </div>
                        </c:if>
                    </div>
                    <!-- Nút Load More -->
                    <div class="text-center">
                        <button id="loadMoreBtn" style="display: none;">Xem thêm <i class="bi bi-chevron-down ms-1"></i></button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer & Toast -->
        <%@ include file="footer.jsp" %>

        <!-- TOAST THÔNG BÁO (AJAX) -->
        <div class="toast-container" style="position: fixed; top: 80px; right: 20px; z-index: 1055;">
            <div id="addToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true" data-bs-delay="3000">
                <div class="toast-header bg-success text-white">
                    <strong class="me-auto"><i class="bi bi-check-circle-fill"></i> Thành công!</strong>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body bg-white" id="toast-message-body">
                    Sản phẩm đã được thêm vào giỏ hàng.
                </div>
            </div>
        </div>

        <!-- SCRIPT -->
        <script>
            // Hàm xử lý Sắp xếp
            function submitSort(sortType) {
                // Gán giá trị vào input ẩn
                document.getElementById('sortInput').value = sortType;
                // Submit form bộ lọc để giữ nguyên các điều kiện lọc khác (giá, danh mục...)
                document.getElementById('filterForm').submit();
            }

            document.addEventListener("DOMContentLoaded", function () {
                // --- LOGIC LOAD MORE (CLIENT-SIDE) ---
                const items = document.querySelectorAll('.product-item');
                const loadMoreBtn = document.getElementById('loadMoreBtn');
                let itemsToShow = 12; // Số lượng hiển thị ban đầu và mỗi lần load thêm

                // Hàm hiển thị sản phẩm
                function showItems(count) {
                    let visibleCount = 0;
                    items.forEach((item, index) => {
                        if (index < count) {
                            item.classList.remove('hidden');
                            visibleCount++;
                        } else {
                            item.classList.add('hidden');
                        }
                    });

                    // Ẩn nút nếu đã hiển thị hết
                    if (visibleCount >= items.length) {
                        loadMoreBtn.style.display = 'none';
                    } else {
                        loadMoreBtn.style.display = 'block';
                    }
                }

                // Khởi chạy lần đầu
                showItems(itemsToShow);

                // Sự kiện bấm nút Load More
                loadMoreBtn.addEventListener('click', function () {
                    itemsToShow += 12; // Tăng thêm 12
                    showItems(itemsToShow);
                });

                // --- LOGIC ADD TO CART
                const addToCartButtons = document.querySelectorAll('.btn-add-to-cart');
                addToCartButtons.forEach(button => {
                    button.addEventListener('click', function (event) {
                        event.preventDefault();
                        const productId = this.dataset.productId;
                        fetch('cart-handler?action=add&id=' + productId)
                                .then(response => response.json())
                                .then(data => {
                                    if (data.success) {
                                        const cartBadge = document.getElementById('cart-count-badge');
                                        if (cartBadge)
                                            cartBadge.innerText = data.cartItemCount;
                                        const toastEl = document.getElementById('addToast');
                                        const toastBody = document.getElementById('toast-message-body');
                                        toastBody.innerText = data.message;
                                        const addToast = new bootstrap.Toast(toastEl);
                                        addToast.show();
                                    }
                                })
                                .catch(error => console.error('Error:', error));
                    });
                });
            });
        </script>

    </body>
</html>
