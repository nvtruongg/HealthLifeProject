<%-- 
    Document   : cart
    Created on : Nov 7, 2025, 10:20:21 AM
    Author     : Nguyen Viet Truong
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Giỏ hàng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <%-- Nhúng Header (nếu có) --%>
        <%@include file="header.jsp" %>
        <%@include file="navbar.jsp" %>
        <style>
            body {
                background-color: #f8f9fa; /* Màu nền xám nhạt */
                font-size: 15px;
            }
            .cart-card {
                background-color: #ffffff;
                border-radius: 12px;
                border: none;
                box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            }
            /* Tùy chỉnh input số lượng */
            .quantity-input {
                border-left: 0;
                border-right: 0;
                box-shadow: none !important;
            }
            .quantity-input:focus {
                border-color: #dee2e6;
            }
            .btn-quantity {
                border-color: #dee2e6;
                background-color: #fff;
                width: 38px;
            }
            .btn-quantity:hover {
                background-color: #f1f1f1;
            }
            .quantity-form .input-group {
                max-width: 140px; /* Giới hạn độ rộng của nhóm nút */
                margin: 0 auto;
            }
            /* Định dạng giá tiền */
            .product-price {
                color: #0072ff;
                font-weight: 700;
                font-size: 1rem;
            }
            .product-price-old {
                color: #777;
                text-decoration: line-through;
                font-size: 0.85rem;
                margin-left: 8px;
            }
            .product-name {
                font-weight: 500;
                color: #333;
                text-decoration: none;
                font-size: 0.95rem;
            }
            .product-name:hover {
                color: #003D9D;
            }
            .summary-card {
                background-color: #ffffff;
                border-radius: 12px;
                border: none;
                box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            }
            .btn-checkout {
                background-color: #28a745;
                border: none;
                font-weight: 600;
                padding: 10px;
            }
            .btn-checkout:hover {
                background-color: #002a6c;
            }
            .text-muted {
                font-size: 0.9rem; /* Giảm font */
            }
        </style>
    </head>
    <jsp:include page="cskh.jsp" />
    <body>

        <div class="container-lg my-4">
            <!-- 1. Link "Tiếp tục mua sắm" -->
            <a href="shop" class="text-decoration-none text-primary fw-500 mb-3 d-inline-block">
                <i class="bi bi-chevron-left"></i>
                Tiếp tục mua sắm
            </a>

            <!-- 2. KIỂM TRA GIỎ HÀNG RỖNG -->
            <c:if test="${empty sessionScope.cart || empty sessionScope.cart.getAllItems()}">
                <div class="row justify-content-center">
                    <div class="col-md-6 text-center">
                        <img src="https://placehold.co/300x300/EFEFEF/AAAAAA?text=Gio+hang+trong" alt="Giỏ hàng trống" class="img-fluid mb-4" style="max-width: 250px;">
                        <h3 class="mb-3">Giỏ hàng của bạn đang trống</h3>
                        <p class="text-muted mb-4">Hãy quay lại cửa hàng để chọn sản phẩm nhé!</p>
                        <a href="shop" class="btn btn-primary btn-lg btn-checkout">
                            Đến Cửa hàng
                        </a>
                    </div>
                </div>
            </c:if>

            <!-- 3. GIỎ HÀNG CÓ SẢN PHẨM -->
            <c:if test="${not empty sessionScope.cart.getAllItems()}">
                <div class="row g-4">

                    <!-- CỘT BÊN TRÁI (DANH SÁCH SẢN PHẨM) -->
                    <div class="col-lg-8">
                        <div class="cart-card p-3">
                            <!-- Banner miễn phí vận chuyển -->
                            <div class="alert alert-info" role="alert" style="text-align: center; background-color: #e6f7ff; border-color: #b3e7ff;">
                                <i class="bi bi-truck"></i>
                                <strong>Miễn phí vận chuyển</strong> với đơn hàng trên 300.000đ
                            </div>

                            <!-- Header giỏ hàng (Chọn tất cả) -->
                            <div class="d-flex justify-content-between align-items-center pb-2 mb-3">
                                <div>
                                    <form action="cart-handler" method="POST" id="form-toggle-all" class="d-inline">
                                        <input type="hidden" name="action" value="toggle-all">
                                        <input class="form-check-input" type="checkbox" id="checkAll" checked>
                                        <label class="form-check-label fw-500" for="checkAll" style="font-size: 1rem;">
                                            Chọn tất cả (${sessionScope.cart.tongSoLuongTatCaItems})
                                        </label>
                                    </form>
                                </div>
                            </div>
                            <!-- TIÊU ĐỀ LƯỚI (Chỉ hiển thị trên Desktop) -->
                            <div class="row d-none d-md-flex align-items-center fw-bold text-muted small py-2 border-bottom">
                                <div class="col-md-5">Sản phẩm</div>
                                <div class="col-md-2 text-center">Giá thành</div>
                                <div class="col-md-3 text-center">Số lượng</div>
                                <div class="col-md-1 text-center">Đơn vị</div>
                                <div class="col-md-1 text-end"></div>
                            </div>


                            <!-- Lặp qua từng sản phẩm -->
                            <c:forEach items="${sessionScope.cart.getAllItems()}" var="entry">
                                <c:set var="item" value="${entry.value}" />
                                <c:set var="product" value="${item.sanPham}" />

                                <!-- Đây là 1 dòng sản phẩm, dùng grid 12 cột -->
                                <div class="row g-3 align-items-center py-3 border-bottom">

                                    <!-- Cột 1: Sản phẩm (Checkbox, Img, Tên) (Chiếm 5/12 cột) -->
                                    <div class="col-12 col-md-5">
                                        <div class="d-flex align-items-center">
                                            <!-- Checkbox -->
                                            <form action="cart-handler" method="POST" class="form-toggle-item" style="display: contents;">
                                                <input type="hidden" name="action" value="toggle">
                                                <input type="hidden" name="id" value="${product.id}">
                                                <input class="form-check-input me-3" type="checkbox" ${item.selected ? 'checked' : ''} onchange="this.form.submit()">
                                            </form>
                                            <!-- Ảnh -->
                                            <img src="${product.hinhAnhDaiDien}" alt="${product.tenSanPham}" style="width: 70px; height: 70px; object-fit: contain; border: 1px solid #eee; border-radius: 8px;">
                                            <!-- Tên -->
                                            <div class="ms-3 flex-grow-1">
                                                <a href="detail?pid=${product.id}" class="product-name">${product.tenSanPham}</a>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Cột 2: Giá (Chiếm 2/12 cột) -->
                                    <div class="col-6 col-md-2 text-md-center">
                                        <div class="product-price">
                                            <fmt:formatNumber type="number" maxFractionDigits="0" value="${item.tongTien}" /> đ
                                        </div>
                                        <div class="product-price-old">
                                            <fmt:formatNumber type="number" maxFractionDigits="0" value="${product.giaGoc * item.soLuong}" /> đ
                                        </div>
                                    </div>

                                    <!-- Cột 3: Số lượng (Chiếm 3/12 cột) -->
                                    <div class="col-6 col-md-3 text-md-center">
                                        <form action="cart-handler" method="POST" class="d-inline-block quantity-form">
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" name="id" value="${product.id}">
                                            <div class="input-group input-group-sm">
                                                <button class="btn btn-outline-secondary btn-quantity" type="button" data-change="-1">-</button>
                                                <input type="tel" name="quantity" class="form-control quantity-input" 
                                                       value="${item.soLuong}" min="1">
                                                <button class="btn btn-outline-secondary btn-quantity" type="button" data-change="1">+</button>
                                            </div>
                                        </form>
                                    </div>

                                    <!-- Cột 4: Đơn vị (Chiếm 1/12 cột) -->
                                    <div class="col-6 col-md-1 text-md-center text-muted small">
                                        Hộp
                                    </div>

                                    <!-- Cột 5: Xóa (Chiếm 1/12 cột) -->
                                    <div class="col-6 col-md-1 text-md-end text-end">
                                        <button type="button" class="btn btn-link text-danger p-0 btn-delete-item"
                                                data-bs-toggle="modal" 
                                                data-bs-target="#deleteConfirmModal"
                                                data-delete-url="cart-handler?action=remove&id=${product.id}">
                                            <i class="bi bi-trash3-fill fs-6"></i>
                                        </button>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- CỘT BÊN PHẢI (TÓM TẮT ĐƠN HÀNG) -->
                    <div class="col-lg-4">
                        <div class="summary-card p-3">
                            <h5 class="mb-3 border-bottom pb-2">Tóm tắt đơn hàng</h5>

                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted">Tạm tính (${sessionScope.cart.tongSoLuongItemsDaChon} sản phẩm)</span>
                                <strong style="font-size: 1rem;">
                                    <fmt:formatNumber type="number" maxFractionDigits="0" value="${sessionScope.cart.tongTienHangDaChon}" /> đ
                                </strong>
                            </div>

                            <div class="d-flex justify-content-between mb-3">
                                <span class="text-muted">Phí vận chuyển</span>
                                <strong style="font-size: 1rem; color: #0072ff">
                                    <c:set var="phiVanChuyen" value="${sessionScope.cart.tongTienHangDaChon >= 300000 ? 0 : 15000}" />
                                    <c:if test="${phiVanChuyen == 0}">Miễn phí</c:if>
                                    <c:if test="${phiVanChuyen > 0}">
                                        <fmt:formatNumber type="number" maxFractionDigits="0" value="${phiVanChuyen}" /> đ
                                    </c:if>
                                </strong>
                            </div>

                            <hr>

                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <span class="fw-500">Thành tiền</span>
                                <span class="fs-5 fw-bold text-danger"> <!-- Giữ font-size này lớn -->
                                    <fmt:formatNumber type="number" maxFractionDigits="0" value="${sessionScope.cart.tongTienHangDaChon + phiVanChuyen}" /> đ
                                </span>
                            </div>

                            <c:if test="${sessionScope.cart.tongSoLuongItemsDaChon > 0}">
                                <a href="checkout" class="btn btn-primary w-100 btn-lg btn-checkout">
                                    Mua Hàng
                                </a>
                            </c:if>
                            <c:if test="${sessionScope.cart.tongSoLuongItemsDaChon == 0}">
                                <button class="btn btn-primary w-100 btn-lg btn-checkout" disabled>
                                    Vui lòng chọn sản phẩm
                                </button>
                            </c:if>

                            <p class="text-muted text-center small mt-3">
                                Bằng việc tiến hành đặt mua hàng, bạn đồng ý với
                                <a href="#" class="text-primary">Điều khoản dịch vụ</a> & 
                                <a href="#" class="text-primary">Chính sách xử lý dữ liệu</a>.
                            </p>
                        </div>
                    </div>

                </div>
            </c:if>
        </div>

        <!-- 4. MODAL XÁC NHẬN XÓA (Như ảnh 2) -->
        <div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" style="max-width: 400px;">
                <div class="modal-content border-0 rounded-3 shadow-lg">
                    <div class="modal-header border-0 pb-0">
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body text-center p-4">
                        <img src="https://placehold.co/100x100/003D9D/FFFFFF?text=🗑" 
                             alt="Thùng rác" class="mb-3" style="width: 80px; height: 80px; opacity: 0.7; border-radius: 50%;">

                        <h5 class="modal-title fw-bold mb-2" id="deleteModalLabel">Thông báo</h5>
                        <p class="text-muted">Bạn chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng?</p>
                    </div>
                    <div class="modal-footer border-0 p-3 pt-0 d-grid gap-2 d-sm-flex justify-content-center">
                        <button type="button" class="btn btn-light" data-bs-dismiss="modal" style="flex: 1;">Đóng</button>
                        <!-- Nút này sẽ nhận link xóa từ JavaScript -->
                        <a id="btn-confirm-delete" class="btn btn-danger" style="flex: 1;">Xóa</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- 5. JAVASCRIPT CHO MODAL VÀ SỐ LƯỢNG -->
        <script>
            document.addEventListener("DOMContentLoaded", function () {

                // --- Logic cho Modal Xác nhận Xóa ---
                const deleteModal = document.getElementById('deleteConfirmModal');
                if (deleteModal) {
                    deleteModal.addEventListener('show.bs.modal', function (event) {
                        // Lấy nút đã kích hoạt modal
                        const button = event.relatedTarget;
                        // Lấy URL xóa từ thuộc tính data-delete-url
                        const deleteUrl = button.getAttribute('data-delete-url');
                        // Tìm nút "Xóa" trong modal
                        const confirmButton = deleteModal.querySelector('#btn-confirm-delete');
                        // Gán URL cho nút "Xóa"
                        confirmButton.setAttribute('href', deleteUrl);
                    });
                }

                // --- Logic cho nút +/- Số lượng ---
                document.querySelectorAll('.quantity-form').forEach(form => {
                    const input = form.querySelector('.quantity-input');
                    let submitTimer;

                    // Hàm để submit form (với độ trễ)
                    function submitForm() {
                        clearTimeout(submitTimer);
                        submitTimer = setTimeout(() => {
                            form.submit();
                        }, 500); // Gửi sau 500ms
                    }

                    // Gán sự kiện cho nút
                    form.querySelectorAll('.btn-quantity').forEach(button => {
                        button.addEventListener('click', function () {
                            const change = parseInt(this.dataset.change);
                            let newValue = parseInt(input.value) + change;
                            if (newValue < 1) {
                                newValue = 1;
                            }
                            input.value = newValue;
                            submitForm(); // Kích hoạt submit
                        });
                    });

                    // Gán sự kiện khi tự nhập số
                    input.addEventListener('change', function () {
                        if (this.value < 1) {
                            this.value = 1;
                        }
                        submitForm(); // Kích hoạt submit
                    });
                });

                // --- Logic cho Checkbox "Chọn tất cả" ---
                const checkAllBox = document.getElementById('checkAll');
                if (checkAllBox) {
                    // Đặt trạng thái checkbox dựa trên dữ liệu server (cần thêm hàm isAllSelected vào Cart model để dùng ở đây nếu muốn chính xác 100%)
                    // Hoặc đơn giản là khi click thì submit form
                    checkAllBox.addEventListener('change', function () {
                        document.getElementById('form-toggle-all').submit();
                    });
                }
                
            });
        </script>
        <%@include file="footer.jsp" %>
    </body>
</html>
