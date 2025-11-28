<%-- 
    Document   : order-history
    Description: Trang lịch sử mua hàng (Thiết kế lại full-width, font nhỏ hơn)
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Lịch sử đơn hàng - HealthLife</title>

        <%@ include file="header.jsp" %>
        <%@ include file="navbar.jsp" %>

        <style>
            body {
                background-color: #f8f9fa;
                font-size: 0.9rem; /* Giảm cỡ chữ tổng thể */
            }
            .page-header {
                background: white;
                padding: 15px 0;
                border-bottom: 1px solid #eee;
                margin-bottom: 25px;
            }
            .order-card {
                background: white;
                border-radius: 8px; /* Bo góc nhẹ hơn */
                box-shadow: 0 2px 10px rgba(0,0,0,0.03);
                overflow: hidden;
                border: none;
            }
            .table thead th {
                background-color: #f1f3f5;
                color: #495057;
                font-weight: 600;
                text-transform: uppercase;
                font-size: 0.8rem; /* Font header nhỏ hơn */
                letter-spacing: 0.5px;
                border-bottom: 2px solid #dee2e6;
                padding: 12px 15px;
                white-space: nowrap; /* Không xuống dòng tiêu đề */
            }
            .table td {
                vertical-align: middle;
                padding: 12px 15px;
                border-bottom: 1px solid #f1f1f1;
                font-size: 0.9rem;
            }
            .table tbody tr:hover {
                background-color: #fcfcfc;
            }

            /* Badge trạng thái */
            .status-badge {
                padding: 6px 12px;
                border-radius: 20px;
                font-size: 0.8rem;
                font-weight: 600;
                display: inline-block;
            }
            .status-cho_xac_nhan {
                background-color: #fff3cd;
                color: #856404;
            }
            .status-dang_giao {
                background-color: #cce5ff;
                color: #004085;
            }
            .status-hoan_thanh {
                background-color: #d4edda;
                color: #155724;
            }
            .status-da_huy {
                background-color: #f8d7da;
                color: #721c24;
            }

            .empty-order {
                text-align: center;
                padding: 80px 0;
                background: white;
                border-radius: 12px;
            }
            .empty-order i {
                font-size: 4rem;
                color: #e9ecef;
                margin-bottom: 20px;
                display: block;
            }
            .btn-detail {
                border-radius: 20px;
                padding: 4px 15px;
                font-weight: 600;
                font-size: 0.85rem;
                transition: all 0.3s;
            }
            .btn-detail:hover {
                background-color: #003D9D;
                color: white;
                border-color: #003D9D;
            }
            .btn:hover{
                transform: translateX(4px);
            }
            /* Căn giữa nội dung cột ngày và trạng thái */
            .col-center {
                text-align: center;
            }
        </style>
    </head>
    <body>

        <!-- Header của trang -->
        <div class="page-header">
            <div class="container-fluid px-4">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h4 class="fw-bold mb-1" style="color: #003D9D;">Lịch sử đơn hàng</h4>
                        <p class="text-muted mb-0 small">Theo dõi quá trình mua sắm của bạn</p>
                    </div>
                    <div>
                        <a href="profile.jsp" class="btn btn-outline-secondary rounded-pill px-3 btn-sm">
                            <i class="bi bi-person-gear me-1"></i> Tài khoản
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Nội dung chính (Full Width) -->
        <div class="container-fluid px-4 mb-5">
            <div class="row">
                <div class="col-12">

                    <c:if test="${empty listOrders}">
                        <div class="empty-order shadow-sm">
                            <i class="bi bi-receipt-cutoff"></i>
                            <h5 class="fw-bold">Bạn chưa có đơn hàng nào</h5>
                            <p class="text-muted mb-4 small">Hãy khám phá các sản phẩm chất lượng và đặt hàng ngay nhé!</p>
                            <a href="shop" class="btn fw-bold d-inline-flex align-items-center justify-content-center"
                               style="background-color: #003D9D; color: #fff; padding: 4px 12px; font-size: 1rem; border-radius: 25px; min-width: auto; border: none;">
                                <span style="color: #FFD700;">Mua sắm ngay</span>                                
                            </a>
                        </div>
                    </c:if>

                    <c:if test="${not empty listOrders}">
                        <div class="order-card">
                            <div class="table-responsive">
                                <table class="table mb-0">
                                    <thead>
                                        <tr>
                                            <th class="ps-4">Mã đơn hàng</th>
                                            <th class="text-center">Ngày đặt</th>
                                            <th style="width: 40%;">Địa chỉ giao hàng</th>
                                            <th>Tổng tiền</th>
                                            <th class="text-center">Trạng thái</th>
                                            <th class="text-end pe-4">Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${listOrders}" var="o">
                                            <tr>
                                                <td class="ps-4">
                                                    <span class="fw-bold text-primary">#${o.maDonHang}</span>
                                                </td>
                                                <td class="text-center text-muted">
                                                    <fmt:formatDate value="${o.ngayDat}" pattern="dd/MM/yyyy"/>
                                                </td>
                                                <td>
                                                    <div class="text-truncate small" style="max-width: 450px;" title="${o.diaChiGiaoHang}">
                                                        <i class="bi bi-geo-alt-fill text-danger me-1"></i> ${o.diaChiGiaoHang}
                                                    </div>
                                                </td>
                                                <td class="fw-bold text-dark">
                                                    <fmt:formatNumber value="${o.tongThanhToan}" type="number"/> đ
                                                </td>
                                                <td class="text-center">
                                                    <span class="status-badge status-${o.trangThaiDonHang}">
                                                        <c:choose>
                                                            <c:when test="${o.trangThaiDonHang == 'cho_xac_nhan'}">Chờ xác nhận</c:when>
                                                            <c:when test="${o.trangThaiDonHang == 'dang_giao'}">Đang giao</c:when>
                                                            <c:when test="${o.trangThaiDonHang == 'hoan_thanh'}">Hoàn thành</c:when>
                                                            <c:when test="${o.trangThaiDonHang == 'da_huy'}">Đã hủy</c:when>
                                                            <c:otherwise>${o.trangThaiDonHang}</c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </td>
                                                <td class="text-end pe-4">
                                                    <a href="order-detail?id=${o.id}" class="btn btn-outline-primary btn-detail btn-sm">
                                                        Chi tiết
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </c:if>

                </div>
            </div>
        </div>

        <%@ include file="footer.jsp" %>

    </body>
</html>