<%--
    Document : shop
    Created on : Oct 25, 2025, 7:03:58 PM
    Author : Nguyen Viet Truong
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="header.jsp" %>
<%@include file="navbar.jsp" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${pageTile} - HealthLife</title>
        <style>
            .section-title {
                font-size: 2.2rem;
                font-weight: 700;
                color: #333;
                position: relative;
                padding-bottom: 10px;
                margin-bottom: 20px;
                text-align: center;
            }
            .section-title::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 50%;
                transform: translateX(-50%);
                width: 60px;
                height: 4px;
                background: linear-gradient(to right, #28a745, #007bff);
            }
            .product-card {
                border: 1px solid #eee;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
                transition: transform 0.3s, box-shadow 0.3s;
                overflow: hidden;
                background: #fff;
            }
            .product-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 6px 18px rgba(40,167,69,0.2);
            }
            .product-card img {
                width: 100%;
                height: 250px;
                object-fit: contain;
                padding: 10px;
                background: #f8f9fa;
            }
            .card-title {
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
                text-overflow: ellipsis;
                height: 2.5em;
                font-size: 1.1rem;
                color: #333;
                font-weight: 500;
            }
            .card-title a {
                color: #333;
                text-decoration: none;
                transition: color 0.3s;
            }
            .card-title a:hover {
                color: #28a745;
            }
            .card-price {
                font-size: 1.3rem;
                font-weight: bold;
                color: #dc3545;
                margin-top: 10px;
            }
            .btn-primary {
                background-color: #28a745;
                border-color: #28a745;
                transition: background-color 0.3s;
            }
            .btn-primary:hover {
                background-color: #218838;
                border-color: #218838;
            }
            @media (max-width: 768px) {
                .section-title { font-size: 1.8rem; }
                .product-card img { height: 200px; }
                .col-lg-3 { flex: 0 0 50%; max-width: 50%; margin-bottom: 20px; }
            }
            @media (max-width: 576px) {
                .col-lg-3 { flex: 0 0 100%; max-width: 100%; }
            }
            /* CSS CHO TOAST */
            .toast-container {
                position: fixed;
                top: 80px;
                right: 20px;
                z-index: 1055;
            }
        </style>
    </head>
    <body>

        <div class="container mt-4">
            <div class="row">
                <div class="col-12">
                    <h1 class="section-title">${pageTile}</h1>
                </div>   
                <!-- Lưới snr phẩm -->
                <c:forEach items="${listP}" var="p">
                    <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                        <div class="card h-100 product-card">
                            <a href="detail?pid=${p.id}">
                                <img src="${p.hinhAnhDaiDien}" class="card-img-top" alt="${p.tenSanPham}">
                            </a>
                            <div class="card-body d-flex flex-column">
                                <h5 class="card-title">
                                    <a href="detail?pid=${p.id}">${p.tenSanPham}</a>
                                </h5>
                                <p class="card-text card-price mt-auto">
                                    <fmt:formatNumber type="number" maxFractionDigits="0" value="${p.giaBan}" /> đ
                                </p>
                                <button type="button" class="btn btn-primary mt-2 btn-add-to-cart"
                                        data-product-id="${p.id}">
                                    <i class="bi bi-cart-plus"></i> Thêm vào giỏ
                                </button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                <c:if test="${empty listP}">
                    <div class="col-12">
                        <p class="text-center text-muted h4">Không có sản phẩm nào trong danh mục này.</p>
                    </div>
                </c:if>
            </div>
        </div>
                
        <%@include file="footer.jsp" %>
        
        <!-- KHUNG THÔNG BÁO TOAST -->
        <div class="toast-container">
            <div id="addToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true" data-bs-delay="3000">
                <div class="toast-header bg-success text-white">
                    <strong class="me-auto"><i class="bi bi-check-circle-fill"></i> Thành công!</strong>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body" id="toast-message-body">
                    Sản phẩm đã được thêm vào giỏ hàng.
                </div>
            </div>
        </div>
    </div>
</div>

        <!-- SCRIPT AJAX -->
        <script>
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
                                    // 1. Cập nhật số lượng trên Navbar (trong header.jsp)
                                    const cartBadge = document.getElementById('cart-count-badge');
                                    if(cartBadge) {
                                        cartBadge.innerText = data.cartItemCount;
                                    }
                                    
                                    // 2. Hiển thị thông báo Toast
                                    const toastEl = document.getElementById('addToast');
                                    const toastMessageBody = document.getElementById('toast-message-body');
                                    
                                    toastMessageBody.innerText = data.message;
                                    
                                    // Khởi tạo Toast MỚI mỗi lần click
                                    const addToast = new bootstrap.Toast(toastEl);
                                    addToast.show();
                                    
                                } else {
                                    // Xử lý lỗi
                                }
                            })
                            .catch(error => {
                                console.error('Error:', error);
                            });
                    });
                });
            });
        </script>
    </body>
</html>
