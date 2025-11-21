<%-- 
    Document   : order-success
    Created on : Nov 21, 2025
    Author     : HealthLife Team
    Description: Trang thông báo đặt hàng thành công
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đặt hàng thành công - HealthLife</title>

        <!-- 1. BAO GỒM CÁC THÀNH PHẦN CHUNG -->
        <%@ include file="header.jsp" %>
        <%@ include file="navbar.jsp" %>

        <!-- 2. CSS TÙY CHỈNH -->
        <style>
            body {
                background-color: #f8f9fa;
            }
            .success-card {
                background: white;
                border-radius: 16px;
                box-shadow: 0 10px 30px rgba(0, 61, 157, 0.08);
                padding: 3rem 2rem;
                text-align: center;
                margin-top: 2rem;
                margin-bottom: 4rem;
            }

            /* Hiệu ứng icon thành công */
            .success-icon-container {
                margin-bottom: 1.5rem;
            }
            .success-icon {
                font-size: 5rem;
                color: #28a745; /* Màu xanh lá thành công */
                animation: scaleUp 0.5s ease-in-out;
            }

            @keyframes scaleUp {
                0% {
                    transform: scale(0);
                    opacity: 0;
                }
                60% {
                    transform: scale(1.2);
                }
                100% {
                    transform: scale(1);
                    opacity: 1;
                }
            }

            .order-title {
                color: #003D9D; /* Xanh Long Châu */
                font-weight: 700;
                margin-bottom: 1rem;
            }

            .order-message {
                color: #555;
                font-size: 1.1rem;
                margin-bottom: 2rem;
                line-height: 1.6;
            }

            /* Style cho các nút bấm */
            .btn-action {
                padding: 12px 30px;
                border-radius: 8px;
                font-weight: 600;
                transition: all 0.3s;
                min-width: 200px;
            }

            .btn-primary-lc {
                background-color: #003D9D;
                border: 2px solid #003D9D;
                color: white;
            }
            .btn-primary-lc:hover {
                background-color: #002a6c;
                border-color: #002a6c;
                color: white;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(0, 61, 157, 0.2);
            }

            .btn-outline-lc {
                background-color: transparent;
                border: 2px solid #003D9D;
                color: #003D9D;
            }
            .btn-outline-lc:hover {
                background-color: #f0f4ff;
                color: #003D9D;
                transform: translateY(-2px);
            }

            .support-text {
                margin-top: 2rem;
                font-size: 0.9rem;
                color: #888;
            }
        </style>
    </head>
    <body>

        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8 col-md-10">

                    <div class="success-card">
                        <!-- Icon Success -->
                        <div class="success-icon-container">
                            <i class="bi bi-check-circle-fill success-icon"></i>
                        </div>

                        <!-- Tiêu đề -->
                        <h2 class="order-title">ĐẶT HÀNG THÀNH CÔNG!</h2>

                        <!-- Nội dung thông báo -->
                        <p class="order-message">
                            Cảm ơn <strong>${sessionScope.user.fullname}</strong> đã tin tưởng HealthLife.<br>
                            Đơn hàng của bạn đang được hệ thống xử lý và sẽ sớm được giao đến bạn.
                        </p>

                        <!-- Thông tin hỗ trợ nhanh -->
                        <div class="alert alert-light border d-inline-block text-start mb-4" style="max-width: 500px;">
                            <div class="d-flex align-items-center">
                                <i class="bi bi-info-circle-fill text-primary fs-4 me-3"></i>
                                <div>
                                    <small class="text-muted d-block">Phương thức thanh toán:</small>
                                    <span class="fw-bold text-dark">Thanh toán khi nhận hàng (COD)</span>
                                </div>
                            </div>
                        </div>

                        <!-- Khu vực nút bấm (Actions) -->
                        <div class="d-flex flex-column flex-md-row justify-content-center gap-3">
                            <!-- Nút về trang chủ -->
                            <a href="shop" class="btn btn-outline-lc btn-action">
                                <i class="bi bi-house-door-fill me-2"></i>Về Trang chủ
                            </a>

                            <!-- Nút xem lịch sử đơn hàng -->
                            <a href="order-history" class="btn btn-primary-lc btn-action">
                                <i class="bi bi-receipt me-2"></i>Xem Đơn hàng
                            </a>
                        </div>

                        <!-- Footer nhỏ của card -->
                        <div class="support-text">
                            Mọi thắc mắc xin liên hệ Hotline: <strong class="text-dark">037 999 6828</strong> (Miễn phí)
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <!-- 3. FOOTER -->
        <%@ include file="footer.jsp" %>

    </body>
</html>