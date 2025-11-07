<%--
    Document : detail.jsp
    Created on : Nov 01, 2025, 10:00:00 AM
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
        <title>Chi Tiết Sản Phẩm - ${product.tenSanPham} - HealthLife</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- CSS tùy chỉnh lấy cảm hứng từ Long Châu -->
        <style>
            .product-img-main { width: 100%; height: auto; max-height: 400px; object-fit: contain; }
            .product-thumbs img { width: 80px; height: 80px; object-fit: contain; cursor: pointer; margin: 5px; border: 1px solid #ddd; }
            .product-thumbs img.active { border-color: #007bff; }
            .price-original { text-decoration: line-through; color: #999; font-size: 1.2rem; }
            .price-sale { color: #d70018; font-weight: bold; font-size: 1.5rem; }
            .add-to-cart { background-color: #007bff; color: white; font-weight: bold; }
            .section-heading { font-size: 1.5rem; font-weight: bold; margin-top: 30px; border-bottom: 2px solid #ddd; padding-bottom: 10px; }
            .review-star { color: #ffc107; } /* Màu sao vàng */
        </style>
    </head>
    <body>
        <!-- Navbar (copy từ home.jsp để giữ nhất quán) -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container-fluid">
                <a class="navbar-brand" href="home">HealthLife</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav">
                  <!-- Menu hiện có -->
                  </ul>
                 <!-- Thêm form tìm kiếm -->
               <form class="d-flex ms-auto" action="search" method="get">
               <input class="form-control me-2" type="search" name="keyword" placeholder="Tìm sản phẩm..." aria-label="Search">
                <button class="btn btn-outline-success" type="submit">Tìm</button>
                </form>
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link active" href="home">Trang Chủ</a>
                        </li>
                            <c:forEach items="${listC}" var="cat">
                                <li class="nav-item">
                                    <a class="nav-link" href="shop?cid=${cat.id}">${cat.tenDanhMuc}</a>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
            </div>
        </nav>

        <!-- Nội dung chi tiết sản phẩm (cập nhật giống Long Châu hơn) -->
        <div class="container mt-4">
            <c:if test="${not empty product}">
                <!-- Breadcrumb (thêm mới, giống Long Châu) -->
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="home">Trang Chủ</a></li>
                        <li class="breadcrumb-item"><a href="shop?cid=${product.idDanhMuc}">Danh Mục Sản Phẩm</a></li> <!-- Giả sử tên danh mục từ DAO -->
                        <li class="breadcrumb-item active" aria-current="page">${product.tenSanPham}</li>
                    </ol>
                </nav>

                <!-- Row chính: Ảnh trái, Info phải -->
                <div class="row">
                    <!-- Ảnh sản phẩm -->
                    <div class="col-md-5">
                        <img src="${product.hinhAnhDaiDien}" class="product-img-main" alt="${product.tenSanPham}">
                        <!-- Thumbnails (nếu có, thêm từ listImages) -->
                        <div class="product-thumbs d-flex mt-2">
                            <img src="${product.hinhAnhDaiDien}" class="active">
                            <!-- <c:forEach items="${listImages}" var="img"><img src="${img.urlHinhAnh}"></c:forEach> -->
                        </div>
                    </div>

                    <!-- Thông tin sản phẩm (cập nhật giá gạch ngang, số lượng) -->
                    <div class="col-md-7">
                        <h2>${product.tenSanPham}</h2>
                        <p><strong>Mã sản phẩm:</strong> ${product.maSanPham}</p>
                        <p>
                            <span class="price-original"><fmt:formatNumber type="number" maxFractionDigits="0" value="${product.giaGoc}" /> đ</span>
                            <span class="price-sale ms-2"><fmt:formatNumber type="number" maxFractionDigits="0" value="${product.giaBan}" /> đ</span>
                        </p>
                        <p><strong>Số lượng tồn:</strong> ${product.soLuongTon} ${product.donViTinh}</p>
                        <div class="d-flex align-items-center mb-3">
                            <label for="quantity" class="me-2">Số lượng:</label>
                            <input type="number" id="quantity" value="1" min="1" max="${product.soLuongTon}" class="form-control w-25 me-2">
                            <a href="#" class="btn add-to-cart">Thêm vào giỏ</a>
                        </div>
                        <p class="text-muted">Sản phẩm đang được chú ý, có X người thêm vào giỏ hàng & Y người đang xem. (Placeholder)</p>
                        <p>${product.moTaNgan}</p>
                    </div>
                </div>

                <!-- Sections chi tiết (thay tabs bằng headings, giống Long Châu) -->
                <div class="mt-4">
                    <h3 class="section-heading">Mô tả sản phẩm</h3>
                    <p>${product.moTaChiTiet}</p>

                    <h3 class="section-heading">Công dụng</h3>
                    <p>${product.congDung}</p>

                    <h3 class="section-heading">Liều dùng và cách dùng</h3>
                    <p>${product.lieuDungCachDung}</p>

                    <h3 class="section-heading">Thành phần</h3>
                    <p>${product.thanhPhan}</p> <!-- Có thể dùng table nếu dữ liệu là list -->

                    <h3 class="section-heading">Bảo quản</h3>
                    <p>${product.baoQuan}</p>

                    <h3 class="section-heading">Lưu ý</h3>
                    <p>Không dùng cho người mẫn cảm với thành phần. Tham khảo bác sĩ trước khi dùng. (Placeholder)</p>
                </div>

                <!-- Phần đánh giá (cập nhật với sao) -->
                <div class="mt-5">
                    <h3 class="section-heading">Đánh giá sản phẩm (0 đánh giá)</h3>
                    <div class="review-star">
                        <span>★★★★★</span> (5.0 / 5) <!-- Placeholder, tính trung bình từ listReviews -->
                    </div>
                    <c:forEach items="${listReviews}" var="review">
                        <div class="border-bottom py-2">
                            <p><strong>${review.idNguoiDung}</strong> - ${review.soSao} sao</p>
                            <p>${review.binhLuan}</p>
                        </div>
                    </c:forEach>
                    <c:if test="${empty listReviews}">
                        <p>Chưa có đánh giá nào.</p>
                    </c:if>
                </div>

                <!-- Phần Hỏi đáp (thêm mới, giống Long Châu) -->
                <div class="mt-5">
                    <h3 class="section-heading">Hỏi đáp (0 bình luận)</h3>
                    <!-- Placeholder, lặp từ listQA nếu có -->
                    <div class="border-bottom py-2">
                        <p><strong>Người dùng:</strong> Có thể dùng khi mang thai không?</p>
                        <p><strong>Dược sĩ:</strong> Nên tham khảo bác sĩ. (Placeholder)</p>
                    </div>
                    <p>Nếu bạn có câu hỏi, hãy để lại bình luận.</p>
                </div>

                <!-- Sản phẩm liên quan (giới hạn 4 sản phẩm) -->
                <div class="mt-5">
                    <h3 class="section-heading">Sản phẩm liên quan</h3>
                    <div class="row">
                        <c:forEach items="${relatedProducts}" var="p" begin="0" end="3">
                            <div class="col-md-3 mb-3">
                                <div class="card">
                                    <a href="detail?pid=${p.id}">
                                        <img src="${p.hinhAnhDaiDien}" class="card-img-top" alt="${p.tenSanPham}">
                                    </a>
                                    <div class="card-body">
                                        <h5>${p.tenSanPham}</h5>
                                        <p class="price-sale"><fmt:formatNumber type="number" maxFractionDigits="0" value="${p.giaBan}" /> đ</p>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:if>
            <c:if test="${empty product}">
                <p class="text-center text-danger">Sản phẩm không tồn tại hoặc đã ngừng kinh doanh.</p>
            </c:if>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- JS cho thumbnails (nếu có) -->
        <script>
            document.querySelectorAll('.product-thumbs img').forEach(thumb => {
                thumb.addEventListener('click', function() {
                    document.querySelector('.product-img-main').src = this.src;
                    document.querySelectorAll('.product-thumbs img').forEach(t => t.classList.remove('active'));
                    this.classList.add('active');
                });
            });
        </script>
    </body>
</html>