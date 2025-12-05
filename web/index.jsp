<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HealthLife - Thực phẩm chức năng chất lượng cao</title>
    <meta name="description" content="HealthLife - Nền tảng cung cấp thực phẩm chức năng uy tín, chính hãng với đa dạng sản phẩm chăm sóc sức khỏe">
    
    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/index.css">
    
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&family=Playfair+Display:wght@600;700&display=swap" rel="stylesheet">
</head>
<body>
    <!-- Header Navigation -->
    <jsp:include page="header.jsp" />

    <!-- Hero Section - Banner chính với hiệu ứng -->
    <section class="hero-section">
        <div class="hero-slider">
            <!-- Slide 1 -->
            <div class="hero-slide active" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
                <div class="container">
                    <div class="hero-content">
                        <h1 class="hero-title animate-fade-in">
                            Chăm sóc sức khỏe<br>
                            <span class="highlight">Bắt đầu từ hôm nay</span>
                        </h1>
                        <p class="hero-subtitle animate-fade-in-delay">
                            Thực phẩm chức năng chính hãng - Uy tín hàng đầu Việt Nam
                        </p>                       
                        <div class="hero-buttons animate-fade-in-delay-2">
                            <a href="${pageContext.request.contextPath}/shop" class="btn btn-primary">
                                <i class="fas fa-shopping-bag"></i> Khám phá ngay
                            </a>
                            <a href="#about" class="btn btn-outline">
                                <i class="fas fa-info-circle"></i> Tìm hiểu thêm
                            </a>
                        </div>
                        <!-- Trust badges -->
                        <div class="trust-badges animate-fade-in-delay-3">
                            <div class="badge-item">
                                <i class="fas fa-shield-alt"></i>
                                <span>100% chính hãng</span>
                            </div>
                            <div class="badge-item">
                                <i class="fas fa-truck"></i>
                                <span>Miễn phí ship</span>
                            </div>
                            <div class="badge-item">
                                <i class="fas fa-undo"></i>
                                <span>Đổi trả 30 ngày</span>
                            </div>
                        </div>
                    </div>
                    
                </div>
            </div>

            <!-- Slide 2 -->
            <div class="hero-slide" style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);">
                <div class="container">
                    <div class="hero-content">
                        <h1 class="hero-title">
                            Ưu đãi đặc biệt<br>
                            <span class="highlight">Giảm đến 50%</span>
                        </h1>
                        <p class="hero-subtitle">
                            Săn sale hấp dẫn - Giá tốt nhất thị trường
                        </p>
                        <div class="hero-buttons">
                            <a href="${pageContext.request.contextPath}/products?filter=discount" class="btn btn-primary">
                                <i class="fas fa-tags"></i> Xem ưu đãi
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Slide 3 -->
            <div class="hero-slide" style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);">
                <div class="container">
                    <div class="hero-content">
                        <h1 class="hero-title">
                            Tư vấn miễn phí<br>
                            <span class="highlight">Từ chuyên gia</span>
                        </h1>
                        <p class="hero-subtitle">
                            Đội ngũ dược sĩ tận tâm - Hỗ trợ 24/7
                        </p>
                        <div class="hero-buttons">
                            <a href="#contact" class="btn btn-primary">
                                <i class="fas fa-headset"></i> Liên hệ ngay
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Slider Controls -->
        <div class="slider-controls">
            <button class="slider-btn prev" onclick="changeSlide(-1)">
                <i class="fas fa-chevron-left"></i>
            </button>
            <button class="slider-btn next" onclick="changeSlide(1)">
                <i class="fas fa-chevron-right"></i>
            </button>
        </div>

        <!-- Slider Dots -->
        <div class="slider-dots">
            <span class="dot active" onclick="goToSlide(0)"></span>
            <span class="dot" onclick="goToSlide(1)"></span>
            <span class="dot" onclick="goToSlide(2)"></span>
        </div>
    </section>

    <!-- Category Section - Danh mục nổi bật -->
    <section class="category-section">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title">Danh mục sản phẩm</h2>
                <p class="section-subtitle">Khám phá các sản phẩm phù hợp với nhu cầu của bạn</p>
            </div>

            <div class="category-grid">
                <c:forEach var="category" items="${categories}">
                    <a href="${pageContext.request.contextPath}/products?category=${category.categoryId}" 
                       class="category-card">
                        <div class="category-icon">
                            <img src="${category.imageUrl}" alt="${category.categoryName}">
                        </div>
                        <h3>${category.categoryName}</h3>
                        <p>${category.description}</p>
                        <span class="category-link">Xem thêm <i class="fas fa-arrow-right"></i></span>
                    </a>
                </c:forEach>
                
                <!-- Default categories if no data -->
                <c:if test="${empty categories}">
                    <a href="${pageContext.request.contextPath}/shop?cid=1" class="category-card">
                        <div class="category-icon">
                            <i class="fas fa-pills"></i>
                        </div>
                        <h3>Vitamin & Khoáng chất</h3>
                        <p>Bổ sung dinh dưỡng thiết yếu</p>
                        <span class="category-link">Xem thêm <i class="fas fa-arrow-right"></i></span>
                    </a>

                    <a href="${pageContext.request.contextPath}/shop?cid=2" class="category-card">
                        <div class="category-icon">
                            <i class="fas fa-heartbeat"></i>
                        </div>
                        <h3>Hỗ trợ tim mạch</h3>
                        <p>Chăm sóc sức khỏe tim mạch</p>
                        <span class="category-link">Xem thêm <i class="fas fa-arrow-right"></i></span>
                    </a>

                    <a href="${pageContext.request.contextPath}/shop?cid=3" class="category-card">
                        <div class="category-icon">
                            <i class="fas fa-shield-virus"></i>
                        </div>
                        <h3>Tăng cường miễn dịch</h3>
                        <p>Bảo vệ cơ thể khỏe mạnh</p>
                        <span class="category-link">Xem thêm <i class="fas fa-arrow-right"></i></span>
                    </a>

                    <a href="${pageContext.request.contextPath}/shop?cid=4" class="category-card">
                        <div class="category-icon">
                            <i class="fas fa-spa"></i>
                        </div>
                        <h3>Làm đẹp da</h3>
                        <p>Chăm sóc da từ bên trong</p>
                        <span class="category-link">Xem thêm <i class="fas fa-arrow-right"></i></span>
                    </a>

                    <a href="${pageContext.request.contextPath}/shop?cid=5" class="category-card">
                        <div class="category-icon">
                            <i class="fas fa-brain"></i>
                        </div>
                        <h3>Hỗ trợ não bộ</h3>
                        <p>Tăng cường trí nhớ, tập trung</p>
                        <span class="category-link">Xem thêm <i class="fas fa-arrow-right"></i></span>
                    </a>

                    <a href="${pageContext.request.contextPath}/shop?cid=6" class="category-card">
                        <div class="category-icon">
                            <i class="fas fa-bone"></i>
                        </div>
                        <h3>Xương khớp</h3>
                        <p>Hỗ trợ sức khỏe xương khớp</p>
                        <span class="category-link">Xem thêm <i class="fas fa-arrow-right"></i></span>
                    </a>
                </c:if>
            </div>
        </div>
    </section>

    

    <!-- Why Choose Us Section -->
    <section class="why-choose-section" id="about">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title">Tại sao chọn HealthLife?</h2>
                <p class="section-subtitle">Cam kết mang đến trải nghiệm tốt nhất cho khách hàng</p>
            </div>

            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-certificate"></i>
                    </div>
                    <h3>100% Chính hãng</h3>
                    <p>Sản phẩm nhập khẩu trực tiếp từ nhà sản xuất, có đầy đủ giấy tờ chứng nhận</p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-user-md"></i>
                    </div>
                    <h3>Tư vấn chuyên nghiệp</h3>
                    <p>Đội ngũ dược sĩ giàu kinh nghiệm sẵn sàng hỗ trợ 24/7</p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-shipping-fast"></i>
                    </div>
                    <h3>Giao hàng nhanh chóng</h3>
                    <p>Miễn phí vận chuyển toàn quốc cho đơn hàng từ 500.000đ</p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                    <h3>Thanh toán an toàn</h3>
                    <p>Hỗ trợ đa dạng phương thức thanh toán, bảo mật tuyệt đối</p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-sync-alt"></i>
                    </div>
                    <h3>Đổi trả dễ dàng</h3>
                    <p>Chính sách đổi trả trong vòng 30 ngày nếu có vấn đề</p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-gift"></i>
                    </div>
                    <h3>Ưu đãi hấp dẫn</h3>
                    <p>Chương trình khuyến mãi và tích điểm thường xuyên</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Statistics Section -->
    <section class="stats-section">
        <div class="container">
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="stat-number" data-target="50000">0</div>
                    <div class="stat-label">Khách hàng tin tưởng</div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-box"></i>
                    </div>
                    <div class="stat-number" data-target="1000">0</div>
                    <div class="stat-label">Sản phẩm chất lượng</div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-star"></i>
                    </div>
                    <div class="stat-number" data-target="4.9">0</div>
                    <div class="stat-label">Đánh giá trung bình</div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-award"></i>
                    </div>
                    <div class="stat-number" data-target="10">0</div>
                    <div class="stat-label">Năm kinh nghiệm</div>
                </div>
            </div>
        </div>
    </section>

    <!-- Testimonials Section -->
    <section class="testimonials-section">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title">Khách hàng nói gì về chúng tôi</h2>
                <p class="section-subtitle">Những phản hồi chân thực từ người dùng</p>
            </div>

            <div class="testimonials-slider">
                <div class="testimonial-card">
                    <div class="testimonial-rating">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </div>
                    <p class="testimonial-text">
                        "Sản phẩm chất lượng, giao hàng nhanh. Tôi đã dùng vitamin từ HealthLife được 3 tháng và cảm thấy sức khỏe được cải thiện rõ rệt."
                    </p>
                    <div class="testimonial-author">
                        <img src="${pageContext.request.contextPath}/assets/images/avatar1.jpg" alt="Nguyễn Thị Mai">
                        <div>
                            <h4>Nguyễn Thị Mai</h4>
                            <span>Hà Nội</span>
                        </div>
                    </div>
                </div>

                <div class="testimonial-card">
                    <div class="testimonial-rating">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </div>
                    <p class="testimonial-text">
                        "Nhân viên tư vấn rất nhiệt tình và chuyên nghiệp. Giúp tôi chọn được sản phẩm phù hợp nhất với tình trạng sức khỏe."
                    </p>
                    <div class="testimonial-author">
                        <img src="${pageContext.request.contextPath}/assets/images/avatar2.jpg" alt="Trần Văn Nam">
                        <div>
                            <h4>Trần Văn Nam</h4>
                            <span>TP. Hồ Chí Minh</span>
                        </div>
                    </div>
                </div>

                <div class="testimonial-card">
                    <div class="testimonial-rating">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </div>
                    <p class="testimonial-text">
                        "Website dễ sử dụng, giá cả hợp lý. Đặc biệt là chương trình khuyến mãi rất hấp dẫn. Sẽ tiếp tục ủng hộ!"
                    </p>
                    <div class="testimonial-author">
                        <img src="${pageContext.request.contextPath}/assets/images/avatar3.jpg" alt="Lê Thị Hương">
                        <div>
                            <h4>Lê Thị Hương</h4>
                            <span>Đà Nẵng</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Newsletter Section -->
    <section class="newsletter-section">
        <div class="container">
            <div class="newsletter-content">
                <div class="newsletter-text">
                    <h2><i class="fas fa-envelope"></i> Đăng ký nhận tin</h2>
                    <p>Nhận thông tin về sản phẩm mới và ưu đãi đặc biệt</p>
                </div>
                <form class="newsletter-form" onsubmit="subscribeNewsletter(event)">
                    <input type="email" placeholder="Nhập email của bạn" required>
                    <button type="submit" class="btn btn-primary">
                        Đăng ký <i class="fas fa-paper-plane"></i>
                    </button>
                </form>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <jsp:include page="footer.jsp" />

    <!-- Scripts -->
    <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/index.js"></script>
</body>
</html>