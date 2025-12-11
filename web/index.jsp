<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>HealthLife - Thực Phẩm Chức Năng Chính Hãng</title>

        <!-- Link CSS Chung -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
        <!-- Link CSS Riêng cho trang Index -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/index.css">

        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    </head>
    <body>

        <!-- 1. Header -->
        <jsp:include page="header.jsp" />

        <!-- 2. Hero Section (Slider - Chiều cao 320px) -->
        <section class="hero-section">
            <!-- Slide 1: Thực phẩm chức năng (Ảnh chai lọ vitamin tươi sáng) -->
            <div class="hero-slide active" style="background-image: url('https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?ixlib=rb-4.0.3&auto=format&fit=crop&w=2030&q=80');">
                <div class="hero-overlay"></div>
                <div class="container h-100">
                    <div class="row h-100 align-items-center">
                        <div class="col-lg-6 hero-content">
                            <span class="text-uppercase ls-1 fw-bold text-warning mb-1 d-block" style="font-size: 0.85rem;">HealthLife Official Store</span>
                            <h1 class="hero-title">Thực Phẩm Chức Năng <br> <span style="color: var(--secondary-color);">Chính Hãng 100%</span></h1>
                            <p class="hero-subtitle">Bổ sung Vitamin, Khoáng chất thiết yếu. Nâng cao sức đề kháng và bảo vệ sức khỏe toàn diện cho cả gia đình.</p>
                            <a href="shop" class="btn btn-hero btn-hero-glow">
                                Khám Phá Ngay <i class="fas fa-arrow-right ms-2"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Slide 2: Sống khỏe / Thể thao (Ảnh lifestyle năng động) -->
            <div class="hero-slide" style="background-image: url('https://images.unsplash.com/photo-1517836357463-d25dfeac3438?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80');">
                <div class="hero-overlay" style="background: linear-gradient(to right, rgba(0, 61, 157, 0.8), rgba(0, 61, 157, 0.3));"></div>
                <div class="container h-100">
                    <div class="row h-100 align-items-center">
                        <div class="col-lg-6 hero-content">
                            <span class="text-uppercase ls-1 fw-bold text-white mb-1 d-block" style="font-size: 0.85rem;">Sống Khỏe Mỗi Ngày</span>
                            <h1 class="hero-title">Năng Lượng Bứt Phá <br> <span style="color: #fff;">Vóc Dáng Cân Đối</span></h1>
                            <p class="hero-subtitle">Các sản phẩm hỗ trợ tập luyện, Whey Protein, và hỗ trợ giảm cân an toàn, hiệu quả.</p>
                            <a href="shop?cid=5" class="btn btn-hero btn-light text-primary fw-bold shadow">Xem Sản Phẩm</a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Slide 3: Làm đẹp (Ảnh Collagen/Skin care) -->
            <div class="hero-slide" style="background-image: url('https://images.unsplash.com/photo-1596462502278-27bfdd403348?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80');">
                <div class="hero-overlay" style="background: linear-gradient(to right, rgba(216, 27, 96, 0.85), rgba(216, 27, 96, 0.3));"></div>
                <div class="container h-100">
                    <div class="row h-100 align-items-center">
                        <div class="col-lg-6 hero-content">
                            <span class="text-uppercase ls-1 fw-bold text-white mb-1 d-block" style="font-size: 0.85rem;">Bí quyết sắc đẹp</span>
                            <h1 class="hero-title">Trẻ Hóa Làn Da <br> <span style="color: #FFD43B;">Rạng Ngời Sức Sống</span></h1>
                            <p class="hero-subtitle">Collagen, Vitamin E và các tinh chất làm đẹp từ thiên nhiên giúp bạn tự tin tỏa sáng.</p>
                            <a href="shop?cid=6" class="btn btn-hero btn-light text-danger fw-bold shadow">Chăm Sóc Da</a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Slider Controls -->
            <button class="slider-control prev" onclick="changeSlide(-1)"><i class="fas fa-chevron-left"></i></button>
            <button class="slider-control next" onclick="changeSlide(1)"><i class="fas fa-chevron-right"></i></button>
        </section>

        <!-- 3. Trust Badges (Nổi lên trên) -->
        <div class="container">
            <div class="trust-section">
                <div class="row m-0 align-items-center">
                    <div class="col-md-3 trust-item">
                        <i class="fas fa-shield-alt trust-icon"></i>
                        <h5 class="fw-bold mb-1" style="font-size: 1.1rem;">Chính Hãng 100%</h5>
                        <p class="text-muted mb-0 small">Bồi thường nếu phát hiện giả</p>
                    </div>
                    <div class="col-md-3 trust-item">
                        <i class="fas fa-truck-fast trust-icon"></i>
                        <h5 class="fw-bold mb-1" style="font-size: 1.1rem;">Giao Nhanh 2H</h5>
                        <p class="text-muted mb-0 small">Miễn phí đơn từ 300k</p>
                    </div>
                    <div class="col-md-3 trust-item">
                        <i class="fas fa-user-doctor trust-icon"></i>
                        <h5 class="fw-bold mb-1" style="font-size: 1.1rem;">Dược Sĩ Tư Vấn</h5>
                        <p class="text-muted mb-0 small">Tận tâm, chính xác</p>
                    </div>
                    <div class="col-md-3 trust-item">
                        <i class="fas fa-rotate-left trust-icon"></i>
                        <h5 class="fw-bold mb-1" style="font-size: 1.1rem;">Đổi Trả 30 Ngày</h5>
                        <p class="text-muted mb-0 small">Kể cả đã khui hộp</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- 4. Category Section -->
        <section class="py-5">
            <div class="container pt-3">
                <div class="text-center mb-4">
                    <h2 class="fw-bold" style="color: var(--primary-color); font-size: 2rem;">Danh Mục Nổi Bật</h2>
                    <div style="width: 60px; height: 3px; background: var(--secondary-color); margin: 10px auto;"></div>
                </div>

                <div class="row g-3">
                    <div class="col-6 col-md-4 col-lg-2">
                        <a href="shop?cid=1" class="category-card">
                            <div class="category-icon">
                                <img src="https://cdn-icons-png.flaticon.com/512/2964/2964514.png" alt="Vitamin">
                            </div>
                            <h6 class="fw-bold mb-0" style="font-size: 0.95rem;">Vitamin & Khoáng chất</h6>
                        </a>
                    </div>
                    <div class="col-6 col-md-4 col-lg-2">
                        <a href="shop?cid=2" class="category-card">
                            <div class="category-icon">
                                <img src="https://cdn-icons-png.flaticon.com/512/3004/3004458.png" alt="Tim mạch">
                            </div>
                            <h6 class="fw-bold mb-0" style="font-size: 0.95rem;">Hỗ trợ Tim mạch</h6>
                        </a>
                    </div>
                    <div class="col-6 col-md-4 col-lg-2">
                        <a href="shop?cid=3" class="category-card">
                            <div class="category-icon">
                                <img src="https://cdn-icons-png.flaticon.com/512/2854/2854190.png" alt="Xương khớp">
                            </div>
                            <h6 class="fw-bold mb-0" style="font-size: 0.95rem;">Hệ Xương Khớp</h6>
                        </a>
                    </div>
                    <div class="col-6 col-md-4 col-lg-2">
                        <a href="shop?cid=4" class="category-card">
                            <div class="category-icon">
                                <img src="https://cdn-icons-png.flaticon.com/512/2854/2854228.png" alt="Tiêu hóa">
                            </div>
                            <h6 class="fw-bold mb-0" style="font-size: 0.95rem;">Hệ Tiêu Hóa</h6>
                        </a>
                    </div>
                    <div class="col-6 col-md-4 col-lg-2">
                        <a href="shop?cid=5" class="category-card">
                            <div class="category-icon">
                                <img src="https://cdn-icons-png.flaticon.com/512/3050/3050253.png" alt="Làm đẹp">
                            </div>
                            <h6 class="fw-bold mb-0" style="font-size: 0.95rem;">Sắc Đẹp & Da</h6>
                        </a>
                    </div>
                    <div class="col-6 col-md-4 col-lg-2">
                        <a href="shop?cid=6" class="category-card">
                            <div class="category-icon">
                                <img src="https://cdn-icons-png.flaticon.com/512/883/883407.png" alt="Mẹ bé">
                            </div>
                            <h6 class="fw-bold mb-0" style="font-size: 0.95rem;">Mẹ & Bé</h6>
                        </a>
                    </div>
                </div>
            </div>
        </section>

        <!-- 5. Featured Products -->
        <section class="py-5 bg-light">
            <div class="container">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="fw-bold mb-0" style="color: var(--primary-color); font-size: 1.8rem;">Sản Phẩm Bán Chạy</h2>
                    <a href="shop" class="btn btn-outline-primary rounded-pill px-4 btn-sm fw-bold">Xem tất cả <i class="fas fa-arrow-right ms-1"></i></a>
                </div>

                <div class="row g-3">
                    <c:forEach items="${featuredProducts}" var="p">
                        <div class="col-6 col-md-3">
                            <div class="card h-100 border-0 shadow-sm rounded-3 overflow-hidden position-relative product-card">
                                <span class="position-absolute top-0 start-0 bg-danger text-white px-2 py-1 rounded-end mt-2 shadow-sm" style="font-size: 0.75rem; font-weight: 700; z-index: 5;">HOT</span>
                                <a href="detail?pid=${p.id}" class="d-block p-3 text-center bg-white">
                                    <img src="${p.hinhAnhDaiDien}" class="img-fluid" style="height: 160px; object-fit: contain;" alt="${p.tenSanPham}">
                                </a>
                                <div class="card-body bg-white d-flex flex-column pt-0 px-3 pb-3">
                                    <h6 class="card-title fw-bold mb-1" style="font-size: 0.95rem; min-height: 2.4em;">
                                        <a href="detail?pid=${p.id}" class="text-dark text-decoration-none text-truncate-2">${p.tenSanPham}</a>
                                    </h6>
                                    <div class="mb-2">
                                        <i class="fas fa-star text-warning" style="font-size: 0.7rem;"></i>
                                        <i class="fas fa-star text-warning" style="font-size: 0.7rem;"></i>
                                        <i class="fas fa-star text-warning" style="font-size: 0.7rem;"></i>
                                        <i class="fas fa-star text-warning" style="font-size: 0.7rem;"></i>
                                        <i class="fas fa-star-half-alt text-warning" style="font-size: 0.7rem;"></i>
                                        <span class="text-muted ms-1" style="font-size: 0.75rem;">(45)</span>
                                    </div>
                                    <div class="mt-auto d-flex justify-content-between align-items-center">
                                        <div>
                                            <span class="text-danger fw-bold" style="font-size: 1.1rem;"><fmt:formatNumber value="${p.giaBan}" type="number"/>đ</span>
                                            <div class="text-muted text-decoration-line-through" style="font-size: 0.8rem;"><fmt:formatNumber value="${p.giaGoc}" type="number"/>đ</div>
                                        </div>
                                        <button class="btn btn-primary rounded-circle btn-add-to-cart shadow-sm" data-product-id="${p.id}" style="width: 36px; height: 36px; padding: 0; display: flex; align-items: center; justify-content: center;">
                                            <i class="fas fa-cart-plus" style="font-size: 0.9rem;"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>

        <section class="brand-section">
            <div class="container">
                <div class="d-flex align-items-center mb-4"> <i class="fas fa-check-circle text-primary me-2 fs-5"></i>
                    <h4 class="fw-bold m-0" style="color: #333;">Thương hiệu yêu thích</h4>
                </div>
                <div class="row g-3">
                    <div class="col-6 col-md-4 col-lg-2">
                        <a href="shop?bid=1" class="brand-card text-decoration-none">
                            <img src="assets/images/brands/blackmores.jpg" alt="Blackmores" loading="lazy">
                            <span class="brand-name">Blackmores</span>
                        </a>
                    </div>
                    <div class="col-6 col-md-4 col-lg-2">
                        <a href="shop?bid=2" class="brand-card text-decoration-none">
                            <img src="assets/images/brands/dhc.jpg" alt="DHC" loading="lazy">
                            <span class="brand-name">DHC</span>
                        </a>
                    </div>
                    <div class="col-6 col-md-4 col-lg-2">
                        <a href="shop?bid=3" class="brand-card text-decoration-none">
                            <img src="assets/images/brands/lapoche.jpg" alt="La Roche-Posay" loading="lazy">
                            <span class="brand-name">La Roche-Posay</span>
                        </a>
                    </div>
                    <div class="col-6 col-md-4 col-lg-2">
                        <a href="shop?bid=4" class="brand-card text-decoration-none">
                            <img src="assets/images/brands/naturemade.jpg" alt="Nature Made" loading="lazy">
                            <span class="brand-name">Nature Made</span>
                        </a>
                    </div>
                    <div class="col-6 col-md-4 col-lg-2">
                        <a href="shop?bid=5" class="brand-card text-decoration-none">
                            <img src="assets/images/brands/healthcare.jpg" alt="Healthy Care" loading="lazy">
                            <span class="brand-name">Healthy Care</span>
                        </a>
                    </div>
                    <div class="col-6 col-md-4 col-lg-2">
                        <a href="shop?bid=6" class="brand-card text-decoration-none">
                            <img src="assets/images/brands/swisse.jpg" alt="Swisse" loading="lazy">
                            <span class="brand-name">Swisse</span>
                        </a>
                    </div>
                </div>
            </div>
        </section>
        <!-- 7. NEW: GÓC SỨC KHỎE (BLOG) -->
        <section class="blog-section bg-light">
            <div class="container">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="fw-bold mb-0" style="color: var(--primary-color);">Góc Sức Khỏe</h2>
                    <a href="blog.jsp" class="btn btn-outline-primary rounded-pill px-4 btn-sm fw-bold">Xem thêm <i class="fas fa-arrow-right ms-1"></i></a>
                </div>

                <div class="row g-4">
                    <!-- Blog 1 -->
                    <div class="col-md-4">
                        <div class="card h-100 blog-card shadow-sm">
                            <div class="blog-img-wrapper">
                                <a href="https://greenoly.vn/blogs/chia-se/nhung-vitamin-ma-dan-van-phong-nen-bo-sung-moi-ngay">
                                    <img src="https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80" class="blog-img" alt="Blog 1">
                                </a>
                            </div>
                            <div class="card-body">
                                <div class="blog-meta"><i class="far fa-calendar-alt me-1"></i> 20/11/2025 - Sống khỏe</div>
                                <h5 class="blog-title"><a href="https://greenoly.vn/blogs/chia-se/nhung-vitamin-ma-dan-van-phong-nen-bo-sung-moi-ngay">Top 5 loại Vitamin cần thiết cho dân văn phòng</a></h5>
                                <p class="blog-desc">Làm việc văn phòng thường xuyên tiếp xúc máy tính và ít vận động, hãy bổ sung ngay các loại Vitamin này...</p>
                            </div>
                        </div>
                    </div>
                    <!-- Blog 2 -->
                    <div class="col-md-4">
                        <div class="card h-100 blog-card shadow-sm">
                            <div class="blog-img-wrapper">
                                <a href="https://www.vinmec.com/vie/bai-viet/huong-dan-uong-collagen-dung-cach-vi">
                                    <img src="https://www.vinmec.com/static/uploads/small_20200514_162708_650592_screenshot_15894736_max_1800x1800_png_d0b777c560.png" 
                                         class="blog-img" alt="Blog 2">
                                </a>
                            </div>
                            <div class="card-body">
                                <div class="blog-meta"><i class="far fa-calendar-alt me-1"></i> 18/11/2025 - Làm đẹp</div>
                                <h5 class="blog-title"><a href="https://www.vinmec.com/vie/bai-viet/huong-dan-uong-collagen-dung-cach-vi">Cách uống Collagen đúng cách để đạt hiệu quả cao nhất</a></h5>
                                <p class="blog-desc">Collagen là thần dược cho làn da, nhưng uống vào thời điểm nào và liều lượng bao nhiêu là tốt nhất?</p>
                            </div>
                        </div>
                    </div>
                    <!-- Blog 3 -->
                    <div class="col-md-4">
                        <div class="card h-100 blog-card shadow-sm">
                            <div class="blog-img-wrapper">
                                <a href="#">
                                    <img src="https://images.unsplash.com/photo-1584362917165-526a968579e8?ixlib=rb-4.0.3&auto=format&fit=crop&w=2038&q=80" class="blog-img" alt="Blog 3">
                                </a>
                            </div>
                            <div class="card-body">
                                <div class="blog-meta"><i class="far fa-calendar-alt me-1"></i> 15/11/2025 - Dinh dưỡng</div>
                                <h5 class="blog-title"><a href="#">Omega-3: Lợi ích vàng cho tim mạch và trí não</a></h5>
                                <p class="blog-desc">Dầu cá Omega-3 không chỉ tốt cho mắt mà còn giúp giảm nguy cơ mắc các bệnh tim mạch. Tìm hiểu ngay...</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- 8. Statistics (Parallax Background) -->
        <section class="stats-section">
            <div class="stats-overlay"></div>
            <div class="container">
                <div class="row">
                    <div class="col-md-3 col-6 stat-item mb-4 mb-md-0">
                        <div class="stat-number counter" data-target="50000">0</div>
                        <div class="fw-bold text-uppercase ls-1" style="font-size: 0.9rem;">Khách Hàng</div>
                    </div>
                    <div class="col-md-3 col-6 stat-item mb-4 mb-md-0">
                        <div class="stat-number counter" data-target="1500">0</div>
                        <div class="fw-bold text-uppercase ls-1" style="font-size: 0.9rem;">Sản Phẩm</div>
                    </div>
                    <div class="col-md-3 col-6 stat-item">
                        <div class="stat-number counter" data-target="50">0</div>
                        <div class="fw-bold text-uppercase ls-1" style="font-size: 0.9rem;">Đối Tác Uy Tín</div>
                    </div>
                    <div class="col-md-3 col-6 stat-item">
                        <div class="stat-number counter" data-target="10">0</div>
                        <div class="fw-bold text-uppercase ls-1" style="font-size: 0.9rem;">Năm Kinh Nghiệm</div>
                    </div>
                </div>
            </div>
        </section>

        <!-- 9. Newsletter -->
        <section class="newsletter-section">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-8">
                        <h2 class="fw-bold mb-3"><i class="fas fa-envelope-open-text me-2"></i>Đăng Ký Nhận Tin</h2>
                        <p class="mb-4 opacity-75">Đừng bỏ lỡ các chương trình khuyến mãi hấp dẫn và bí quyết chăm sóc sức khỏe hữu ích từ HealthLife.</p>
                        <form class="d-flex justify-content-center">
                            <input type="email" class="newsletter-input shadow" placeholder="Nhập địa chỉ email của bạn..." required>
                            <button type="submit" class="btn-subscribe shadow">ĐĂNG KÝ</button>
                        </form>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <jsp:include page="footer.jsp" />

        <!-- Script Riêng cho Index (Slider, Counter) -->
        <script src="${pageContext.request.contextPath}/assets/js/index.js"></script>

    </body>
</html>