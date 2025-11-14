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
    <jsp:include page="header.jsp" />
    <%@include file="navbar.jsp" %>
</head>
<body>
    
    <div class="container mt-5">
        <h1 class="mb-4">Giỏ hàng của bạn</h1>

        <c:if test="${empty sessionScope.cart || empty sessionScope.cart.getAllItems()}">
            <div class="alert alert-info" role="alert">
                Giỏ hàng của bạn đang trống. <a href="shop" class="alert-link">Tiếp tục mua sắm</a>.
            </div>
        </c:if>

        <c:if test="${not empty sessionScope.cart.getAllItems()}">
            <div class="row">
                <div class="col-lg-8">
                    <table class="table align-middle">
                        <thead>
                            <tr>
                                <th scope="col" class="text-center">Chọn</th>
                                <th scope="col">Sản phẩm</th>
                                <th scope="col">Đơn giá</th>
                                <th scope="col">Số lượng</th>
                                <th scope="col">Thành tiền</th>
                                <th scope="col">Xóa</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%-- Lặp qua TẤT CẢ items --%>
                            <c:forEach items="${sessionScope.cart.getAllItems()}" var="entry">
                                <c:set var="item" value="${entry.value}" />
                                <c:set var="product" value="${item.sanPham}" />
                                <tr>
                                    <td class="text-center">
                                        <!-- Form Checkbox (gọi action 'toggle') -->
                                        <!-- Chúng ta dùng onchange="this.form.submit()" để tự động gửi form khi click -->
                                        <form action="cart-handler" method="POST" id="form-toggle-${product.id}">
                                            <input type="hidden" name="action" value="toggle">
                                            <input type="hidden" name="id" value="${product.id}">
                                            <input class="form-check-input" type="checkbox" 
                                                   ${item.selected ? 'checked' : ''}
                                                   onchange="this.form.submit()">
                                        </form>
                                    </td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <img src="${product.hinhAnhDaiDien}" alt="${product.tenSanPham}" style="width: 60px; height: 60px; object-fit: contain; margin-right: 15px;">
                                            <a href="detail?pid=${product.id}" class="text-dark text-decoration-none">${product.tenSanPham}</a>
                                        </div>
                                    </td>
                                    <td>
                                        <fmt:formatNumber type="number" maxFractionDigits="0" value="${product.giaBan}" /> đ
                                    </td>
                                    <td>
                                        <!-- Form cập nhật số lượng -->
                                        <form action="cart-handler" method="POST" class="d-flex">
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" name="id" value="${product.id}">
                                            <input type="number" name="quantity" value="${item.soLuong}" class="form-control" style="width: 70px;" min="1">
                                            <button type="submit" class="btn btn-sm btn-outline-secondary ms-1">Cập nhật</button>
                                        </form>
                                    </td>
                                    <td>
                                        <strong>
                                            <fmt:formatNumber type="number" maxFractionDigits="0" value="${item.tongTien}" /> đ
                                        </strong>
                                    </td>
                                    <td>
                                        <a href="cart-handler?action=remove&id=${product.id}" class="btn btn-sm btn-outline-danger">
                                            <i class"bi bi-trash></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- Cột tổng tiền (chỉ tính SP đã chọn) -->
                <div class="col-lg-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Tổng cộng</h5>
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    Tạm tính (${sessionScope.cart.tongSoLuongItemsDaChon} sản phẩm)
                                    <span>
                                        <fmt:formatNumber type="number" maxFractionDigits="0" value="${sessionScope.cart.tongTienHangDaChon}" /> đ
                                    </span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    Phí vận chuyển
                                    <span>Miễn phí</span> <%-- Tạm tính --%>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <strong>Tổng tiền</strong>
                                    <strong>
                                        <fmt:formatNumber type="number" maxFractionDigits="0" value="${sessionScope.cart.tongTienHangDaChon}" /> đ
                                    </strong>
                                </li>
                            </ul>
                            
                            <c:if test="${sessionScope.cart.tongSoLuongItemsDaChon > 0}">
                                <a href="checkout" class="btn btn-primary w-100 mt-3">Tiến hành Thanh toán</a>
                            </c:if>
                             <c:if test="${sessionScope.cart.tongSoLuongItemsDaChon == 0}">
                                <button class="btn btn-primary w-100 mt-3" disabled>Vui lòng chọn sản phẩm</button>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>

    </div>
    <%@include file="footer.jsp" %>
</body>
</html>
