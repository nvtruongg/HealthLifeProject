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
            border-radius: 12px;
            padding: 16px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }
        .filter-header {
            font-weight: 700;
            font-size: 1.1rem;
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
            padding: 8px 12px;
            margin-bottom: 8px;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            color: #333;
            text-decoration: none;
            font-size: 0.9rem;
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
            margin-bottom: 1.5rem;
            flex-wrap: wrap;
            gap: 10px;
        }
        .category-title {
            font-size: 1.5rem;
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
            color: #333;
            padding: 6px 16px;
            border-radius: 20px; /* Hình viên thuốc */
            font-size: 0.9rem;
            text-decoration: none;
            transition: all 0.2s;
        }
        .sort-btn:hover {
            background-color: #f8f9fa;
        }
        .sort-btn.active {
            background-color: #003D9D;
            color: white;
            border-color: #003D9D;
        }

        /* --- PRODUCT CARD (Điều chỉnh lại cho cột nhỏ hơn) --- */
        .product-card {
            background: white;
            border-radius: 12px;
            border: 1px solid #eee;
            transition: transform 0.3s, box-shadow 0.3s;
            height: 100%;
            overflow: hidden;
        }
        .product-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 18px rgba(0, 61, 157, 0.15);
            border-color: #b3d7ff;
        }
        .card-img-top {
            height: 180px;
            object-fit: contain;
            padding: 15px;
        }
        .card-body {
            padding: 12px;
            display: flex;
            flex-direction: column;
        }
        .card-title {
            font-size: 0.95rem;
            font-weight: 600;
            line-height: 1.4;
            height: 2.8em; /* Giới hạn 2 dòng */
            overflow: hidden;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            margin-bottom: 8px;
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
            font-size: 1.1rem;
        }
        .original-price {
            color: #999;
            font-size: 0.85rem;
            text-decoration: line-through;
            margin-left: 5px;
        }
        .btn-buy {
            background-color: #28a745;
            color: white;
            border: none;
            width: 100%;
            padding: 8px;
            border-radius: 20px;
            font-weight: 600;
            margin-top: 10px;
            transition: 0.3s;
        }
        .btn-buy:hover {
            background-color: #002a6c;
        }
        
        /* Accordion style cho bộ lọc (Loại thuốc, Thương hiệu...) */
        .accordion-button:not(.collapsed) {
            color: #003D9D;
            background-color: #f0f4ff;
            box-shadow: none;
        }
        .accordion-button:focus {
            box-shadow: none;
            border-color: rgba(0,0,0,.125);
        }
        .accordion-item {
            border: none;
            border-bottom: 1px solid #eee;
        }
    </style>
</head>
<body>

    <div class="container mt-4 mb-5">
        <!-- Breadcrumb (Đường dẫn) -->
        <nav aria-label="breadcrumb" class="mb-3">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="index" class="text-decoration-none text-muted">Trang chủ</a></li>
                <li class="breadcrumb-item active text-primary fw-bold" aria-current="page">${pageTitle}</li>
            </ol>
        </nav>

        <div class="row">
            <!-- === CỘT TRÁI: BỘ LỌC (SIDEBAR) === -->
            <div class="col-lg-3 mb-4">
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
                        <div class="mb-4">
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
                            <!-- Loại thuốc -->
                            <div class="accordion-item">
                                <h2 class="accordion-header" id="headingOne">
                                    <button class="accordion-button collapsed fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne">
                                        Loại thuốc / Sản phẩm
                                    </button>
                                </h2>
                                <div id="collapseOne" class="accordion-collapse collapse" data-bs-parent="#filterAccordion">
                                    <div class="accordion-body">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" value="" id="type1">
                                            <label class="form-check-label" for="type1">Dạng viên</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" value="" id="type2">
                                            <label class="form-check-label" for="type2">Dạng lỏng</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Thương hiệu -->
                            <div class="accordion-item">
                                <h2 class="accordion-header" id="headingTwo">
                                    <button class="accordion-button collapsed fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo">
                                        Thương hiệu
                                    </button>
                                </h2>
                                <div id="collapseTwo" class="accordion-collapse collapse" data-bs-parent="#filterAccordion">
                                    <div class="accordion-body">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" value="" id="brand1">
                                            <label class="form-check-label" for="brand1">Blackmores</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" value="" id="brand2">
                                            <label class="form-check-label" for="brand2">DHC</label>
                                        </div>
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
            <div class="col-lg-9">
                <!-- Header: Tên danh mục & Sắp xếp -->
                <div class="shop-header">
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
                <div class="row g-3">
                    <c:forEach items="${listP}" var="p">
                        <div class="col-6 col-md-4 col-xl-3"> <!-- Responsive: 2 cột mobile, 3 cột tablet, 4 cột desktop -->
                            <div class="product-card h-100">
                                <a href="detail?pid=${p.id}">
                                    <img src="${p.hinhAnhDaiDien}" class="card-img-top" alt="${p.tenSanPham}">
                                </a>
                                <div class="card-body">
                                    <h5 class="card-title">
                                        <a href="detail?pid=${p.id}">${p.tenSanPham}</a>
                                    </h5>
                                    
                                    <!-- Đơn vị tính -->
                                    <div class="text-muted small mb-2">${p.donViTinh}</div>
                                    
                                    <div class="price-section">
                                        <div class="d-flex align-items-baseline">
                                            <span class="current-price">
                                                <fmt:formatNumber type="number" maxFractionDigits="0" value="${p.giaBan}" /> đ
                                            </span>
                                            <span class="original-price">
                                                <fmt:formatNumber type="number" maxFractionDigits="0" value="${p.giaGoc}" />
                                            </span>
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
                                <img src="https://placehold.co/200x200/F0F2F5/AAAAAA?text=Khong+tim+thay" alt="Empty" class="mb-3" style="width: 150px; border-radius: 50%;">
                                <h4>Không tìm thấy sản phẩm nào</h4>
                                <p class="text-muted">Vui lòng thử thay đổi bộ lọc hoặc từ khóa tìm kiếm.</p>
                            </div>
                        </div>
                    </c:if>
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

        // Logic AJAX Thêm vào giỏ (Giữ nguyên code cũ của bạn)
        document.addEventListener("DOMContentLoaded", function () {
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
                                if(cartBadge) cartBadge.innerText = data.cartItemCount;
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