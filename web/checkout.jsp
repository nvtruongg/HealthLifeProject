<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thanh toán - HealthLife</title>

        <!-- Include Header (CSS/JS Bootstrap) -->
        <%@ include file="header.jsp" %>
        <%@ include file="navbar.jsp" %>
        <style>
            body {
                background-color: #f0f2f5; /* Nền xám nhạt hiện đại */
                font-family: 'Inter', sans-serif;
            }
            .checkout-container {
                max-width: 1200px;
                margin: 0 auto;
            }
            /* Card Styles */
            .section-card {
                background: white;
                border-radius: 12px;
                padding: 24px;
                box-shadow: 0 2px 12px rgba(0,0,0,0.04);
                margin-bottom: 20px;
            }
            .section-title {
                font-size: 1.1rem;
                font-weight: 700;
                color: #333;
                margin-bottom: 20px;
                border-left: 4px solid #003D9D; /* Viền xanh đặc trưng */
                padding-left: 10px;
            }

            /* Form Controls */
            .form-label {
                font-weight: 500;
                font-size: 0.9rem;
                color: #555;
            }
            .form-control, .form-select {
                border-radius: 8px;
                padding: 10px 12px;
                border: 1px solid #dee2e6;
            }
            .form-control:focus, .form-select:focus {
                border-color: #003D9D;
                box-shadow: 0 0 0 0.2rem rgba(0, 61, 157, 0.15);
            }

            /* Order Summary Items */
            .order-item-img {
                width: 60px;
                height: 60px;
                object-fit: contain;
                border: 1px solid #f0f0f0;
                border-radius: 8px;
                padding: 2px;
            }
            .order-item-name {
                font-size: 0.9rem;
                font-weight: 500;
                color: #333;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
            }

            /* Payment Method */
            .payment-option {
                border: 1px solid #e0e0e0;
                border-radius: 8px;
                padding: 15px;
                transition: all 0.2s;
                cursor: pointer;
            }
            .payment-option:hover {
                border-color: #003D9D;
                background-color: #f8fbff;
            }
            .form-check-input:checked + label .payment-option {
                border-color: #003D9D;
                background-color: #f8fbff;
            }

            /* Buttons */
            .btn-confirm {
                background-color: #d70018; /* Màu đỏ cam nổi bật cho nút mua */
                border: none;
                color: white;
                font-weight: 700;
                padding: 14px;
                border-radius: 8px;
                width: 100%;
                font-size: 1.1rem;
                transition: background 0.3s;
            }
            .btn-confirm:hover {
                background-color: #c20015;
            }
            .back-link {
                text-decoration: none;
                color: #003D9D;
                font-weight: 500;
                display: inline-block;
                margin-top: 15px;
            }
        </style>
    </head>
    <body>

        <div class="container checkout-container mt-4 mb-5">

            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger shadow-sm border-0" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i> ${errorMessage}
                </div>
            </c:if>

            <form action="checkout" method="POST" id="checkoutForm">
                <div class="row g-4">

                    <!-- CỘT TRÁI: THÔNG TIN GIAO HÀNG & THANH TOÁN -->
                    <div class="col-lg-7">
                        <!-- 1. Thông tin người nhận -->
                        <div class="section-card">
                            <h4 class="section-title">Thông tin giao hàng</h4>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label">Họ tên người nhận</label>
                                    <input type="text" class="form-control" name="tenNguoiNhan" 
                                           value="${sessionScope.user.getFullname()}" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Số điện thoại</label>
                                    <input type="tel" class="form-control" name="soDienThoai" 
                                           value="${sessionScope.user.getSdt()}" required>
                                </div>

                                <!-- Dropdown Địa chỉ (Tỉnh/Huyện/Xã) -->
                                <div class="col-md-4">
                                    <label class="form-label">Tỉnh / Thành phố</label>
                                    <select class="form-select" id="province" required>
                                        <option value="">Chọn Tỉnh/Thành</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Quận / Huyện</label>
                                    <select class="form-select" id="district" required disabled>
                                        <option value="">Chọn Quận/Huyện</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Phường / Xã</label>
                                    <select class="form-select" id="ward" required disabled>
                                        <option value="">Chọn Phường/Xã</option>
                                    </select>
                                </div>

                                <div class="col-12">
                                    <label class="form-label">Địa chỉ cụ thể</label>
                                    <input type="text" class="form-control" id="houseNumber"
                                           placeholder="Số nhà, tên đường, tòa nhà..." required>
                                </div>

                                <!-- Input ẩn để lưu địa chỉ đầy đủ gửi về Server -->
                                <input type="hidden" name="diaChiGiaoHang" id="fullAddress">
                                <input type="hidden" name="email" value="${sessionScope.user.email}">
                            </div>
                        </div>

                        <!-- 2. Phương thức thanh toán -->
                        <div class="section-card">
                            <h4 class="section-title">Phương thức thanh toán</h4>
                            <div class="d-flex flex-col gap-3">
                                <!-- COD -->
                                <div class="form-check p-0">
                                    <input class="form-check-input d-none" type="radio" name="paymentMethod" id="cod" value="cod" checked>
                                    <label class="form-check-label w-100" for="cod">
                                        <div class="payment-option d-flex align-items-center">
                                            <i class="bi bi-cash-coin fs-3 text-primary me-3"></i>
                                            <div>
                                                <div class="fw-bold text-dark">Thanh toán khi nhận hàng (COD)</div>
                                                <small class="text-muted">Bạn chỉ phải thanh toán khi nhận được hàng</small>
                                            </div>
                                        </div>
                                    </label>
                                </div>

                                <!-- Chuyển khoản (Ví dụ) -->
                                <div class="form-check p-0 mt-3">
                                    <input class="form-check-input d-none" type="radio" name="paymentMethod" id="banking" value="banking">
                                    <label class="form-check-label w-100" for="banking">
                                        <div class="payment-option d-flex align-items-center">
                                            <i class="bi bi-qr-code-scan fs-3 text-primary me-3"></i>
                                            <div>
                                                <div class="fw-bold text-dark">Chuyển khoản ngân hàng / QR Code</div>
                                                <small class="text-muted">Quét mã QR để thanh toán nhanh chóng</small>
                                            </div>
                                        </div>
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- CỘT PHẢI: TÓM TẮT ĐƠN HÀNG -->
                    <div class="col-lg-5">
                        <div class="section-card position-sticky" style="top: 20px;">
                            <h4 class="section-title">Đơn hàng của bạn</h4>

                            <!-- Danh sách sản phẩm (Có cuộn nếu quá dài) -->
                            <div style="max-height: 400px; overflow-y: auto; padding-right: 5px;">
                                <c:forEach items="${sessionScope.cart.getSelectedItems()}" var="entry">
                                    <c:set var="item" value="${entry.value}" />
                                    <c:set var="product" value="${item.sanPham}" />

                                    <div class="d-flex align-items-center mb-3 pb-3 border-bottom">
                                        <img src="${product.hinhAnhDaiDien}" alt="${product.tenSanPham}" class="order-item-img flex-shrink-0">
                                        <div class="ms-3 flex-grow-1">
                                            <div class="order-item-name">${product.tenSanPham}</div>
                                            <div class="d-flex justify-content-between mt-1">
                                                <small class="text-muted">SL: ${item.soLuong}</small>
                                                <span class="fw-bold text-primary" style="font-size: 0.95rem;">
                                                    <fmt:formatNumber type="number" maxFractionDigits="0" value="${item.tongTien}" /> đ
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                            <!-- Tính tiền -->
                            <div class="mt-3">
                                <div class="d-flex justify-content-between mb-2 text-muted">
                                    <span>Tạm tính</span>
                                    <span>
                                        <fmt:formatNumber type="number" maxFractionDigits="0" value="${sessionScope.cart.tongTienHangDaChon}" /> đ
                                    </span>
                                </div>
                                <div class="d-flex justify-content-between mb-2 text-muted">
                                    <span>Phí vận chuyển</span>
                                    <span>
                                        <c:if test="${sessionScope.cart.tongTienHangDaChon >= 300000}">Miễn phí</c:if>
                                        <c:if test="${sessionScope.cart.tongTienHangDaChon < 300000}">15.000 đ</c:if>
                                        </span>
                                    </div>
                                    <hr>
                                    <div class="d-flex justify-content-between align-items-center mb-4">
                                        <span class="fw-bold fs-5 text-dark">Tổng cộng</span>
                                        <span class="fw-bold fs-4 text-danger">
                                        <c:set var="ship" value="${sessionScope.cart.tongTienHangDaChon >= 300000 ? 0 : 15000}" />
                                        <fmt:formatNumber type="number" maxFractionDigits="0" value="${sessionScope.cart.tongTienHangDaChon + ship}" /> đ
                                    </span>
                                </div>

                                <button type="submit" class="btn-confirm">
                                    Đặt Hàng
                                </button>

                                <div class="text-center">
                                    <a href="cart-view" class="back-link">
                                        <i class="bi bi-arrow-left me-1"></i> Quay lại giỏ hàng
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </form>
        </div>

        <!-- SCRIPT XỬ LÝ ĐỊA CHỈ (API HÀNH CHÍNH VIỆT NAM) -->
        <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const provinceSelect = document.getElementById('province');
                const districtSelect = document.getElementById('district');
                const wardSelect = document.getElementById('ward');
                const houseInput = document.getElementById('houseNumber');
                const fullAddressInput = document.getElementById('fullAddress');
                const form = document.getElementById('checkoutForm');

                // 1. Load Tỉnh/Thành phố
                // Sử dụng API public miễn phí: https://provinces.open-api.vn/
                // Hoặc https://esgoo.net/api-tinhthanh/ (Khuyên dùng cái này vì nó nhẹ và trả về JSON chuẩn)
                axios.get('https://esgoo.net/api-tinhthanh/1/0.htm')
                        .then(response => {
                            if (response.data.error === 0) {
                                renderOptions(provinceSelect, response.data.data, 'Chọn Tỉnh/Thành');
                            }
                        })
                        .catch(error => console.error('Lỗi load tỉnh:', error));

                // 2. Sự kiện chọn Tỉnh -> Load Huyện
                provinceSelect.addEventListener('change', function () {
                    districtSelect.innerHTML = '<option value="">Đang tải...</option>';
                    wardSelect.innerHTML = '<option value="">Chọn Phường/Xã</option>';
                    wardSelect.disabled = true;

                    if (this.value) {
                        axios.get(`https://esgoo.net/api-tinhthanh/2/` + this.value + `.htm`)
                                .then(response => {
                                    if (response.data.error === 0) {
                                        renderOptions(districtSelect, response.data.data, 'Chọn Quận/Huyện');
                                        districtSelect.disabled = false;
                                    }
                                });
                    } else {
                        districtSelect.innerHTML = '<option value="">Chọn Quận/Huyện</option>';
                        districtSelect.disabled = true;
                    }
                });

                // 3. Sự kiện chọn Huyện -> Load Xã
                districtSelect.addEventListener('change', function () {
                    wardSelect.innerHTML = '<option value="">Đang tải...</option>';

                    if (this.value) {
                        axios.get(`https://esgoo.net/api-tinhthanh/3/` + this.value + `.htm`)
                                .then(response => {
                                    if (response.data.error === 0) {
                                        renderOptions(wardSelect, response.data.data, 'Chọn Phường/Xã');
                                        wardSelect.disabled = false;
                                    }
                                });
                    } else {
                        wardSelect.innerHTML = '<option value="">Chọn Phường/Xã</option>';
                        wardSelect.disabled = true;
                    }
                });

                // Hàm Render Option
                function renderOptions(selectElement, data, defaultLabel) {
                    let html = '<option value="">' + defaultLabel + '</option>';
                    data.forEach(item => {
                        // value là ID (để load con), text hiển thị là tên (full_name)
                        html += '<option value="' + item.id + '" data-name="' + item.full_name + '">' + item.full_name + '</option>';
                    });
                    selectElement.innerHTML = html;
                }

                // 4. Trước khi Submit Form -> Ghép chuỗi địa chỉ
                form.addEventListener('submit', function (e) {
                    const provinceName = provinceSelect.options[provinceSelect.selectedIndex]?.getAttribute('data-name');
                    const districtName = districtSelect.options[districtSelect.selectedIndex]?.getAttribute('data-name');
                    const wardName = wardSelect.options[wardSelect.selectedIndex]?.getAttribute('data-name');
                    const houseVal = houseInput.value.trim();

                    if (!provinceName || !districtName || !wardName || !houseVal) {
                        e.preventDefault();
                        alert("Vui lòng chọn đầy đủ thông tin địa chỉ!");
                        return;
                    }

                    // Tạo chuỗi địa chỉ đầy đủ: "Số 10, Phường X, Quận Y, Tỉnh Z"
                    const finalAddress = houseVal + ", " + wardName + ", " + districtName + ", " + provinceName;

                    // Gán vào input hidden
                    fullAddressInput.value = finalAddress;
                });
            });
        </script>

    </body>
</html>