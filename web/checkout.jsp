<%-- 
    Document   : checkout
    Created on : Nov 8, 2025, 1:55:02 PM
    Author     : Nguyen Viet Truong
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thanh toán</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5 mb-5">
        <h1 class="mb-4 text-center">Hoàn tất Đơn hàng</h1>
        
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger" role="alert">
                ${errorMessage}
            </div>
        </c:if>

        <div class="row g-5">
            <div class="col-lg-7">
                <h4>Thông tin Giao hàng</h4>
                <form action="checkout" method="POST">
                    <div class="mb-3">
                        <label for="tenNguoiNhan" class="form-label">Họ và tên người nhận</label>
                        <input type="text" class="form-control" id="tenNguoiNhan" name="tenNguoiNhan" 
                               value="${sessionScope.account.hoTen}" required>
                    </div>
                    <div class="mb-3">
                        <label for="soDienThoai" class="form-label">Số điện thoại</label>
                        <input type="tel" class="form-control" id="soDienThoai" name="soDienThoai" 
                               value="${sessionScope.account.soDienThoai}" required>
                    </div>
                    <div class="mb-3">
                        <label for="diaChiGiaoHang" class="form-label">Địa chỉ giao hàng</label>
                        <input type="text" class="form-control" id="diaChiGiaoHang" name="diaChiGiaoHang" 
                               placeholder="Số nhà, Đường, Phường/Xã, Quận/Huyện, Tỉnh/Thành phố" required>
                        </div>
                    
                    <hr class="my-4">
                    
                    <h4>Phương thức thanh toán</h4>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="paymentMethod" id="cod" value="cod" checked>
                        <label class="form-check-label" for="cod">
                            Thanh toán khi nhận hàng (COD)
                        </label>
                    </div>
                    
                    <hr class="my-4">
                    
                    <button class="w-100 btn btn-primary btn-lg" type="submit">Xác nhận Đặt hàng</button>
                    <a href="cart.jsp" class="alert-link">Quay lại giỏ hàng</a>.
                </form>
            </div>
            
            <div class="col-lg-5">
                <h4>Tóm tắt Đơn hàng</h4>
                <div class="card">
                    <div class="card-body">
                        <ul class="list-group list-group-flush">
                            <c:forEach items="${sessionScope.cart.getSelectedItems()}" var="entry">
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <div>
                                        <span>${entry.value.sanPham.tenSanPham}</span><br>
                                        <small class="text-muted">SL: ${entry.value.soLuong}</small>
                                    </div>
                                    <span>
                                        <fmt:formatNumber type="number" maxFractionDigits="0" value="${entry.value.tongTien}" /> đ
                                    </span>
                                </li>
                            </c:forEach>
                            
                            <li class="list-group-item d-flex justify-content-between align-items-center fw-bold">
                                Tạm tính
                                <span>
                                    <fmt:formatNumber type="number" maxFractionDigits="0" value="${sessionScope.cart.tongTienHangDaChon}" /> đ
                                </span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center fw-bold">
                                Phí vận chuyển
                                <span>Miễn phí</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center fw-bolder fs-5">
                                Tổng cộng
                                <span>
                                    <fmt:formatNumber type="number" maxFractionDigits="0" value="${sessionScope.cart.tongTienHangDaChon}" /> đ
                                </span>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
