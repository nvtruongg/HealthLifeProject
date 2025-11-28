<%--
    FOOTER (CHÂN TRANG)
    Dùng Bootstrap 5
--%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<footer class="text-white pt-5 pb-4" style="background-color: #003D9D;">
    <div class="container text-center text-md-start">
        <div class="row text-center text-md-start">

            <!-- Cột 1: Giới thiệu -->
            <div class="col-md-4 col-lg-4 col-xl-4 mx-auto mt-3">
                <h5 class="text-uppercase mb-4 fw-bold text-warning">HealthLife</h5>
                <p>
                    Nhà thuốc trực tuyến uy tín, cung cấp các sản phẩm chính hãng,
                    chăm sóc sức khỏe toàn diện cho gia đình bạn với đội ngũ dược sĩ
                    tư vấn tận tâm.
                </p>
                <div class="mt-4">
                    <a href="#" class="btn btn-warning btn-floating m-1" role="button"><i class="bi bi-facebook"></i></a>
                    <a href="#" class="btn btn-warning btn-floating m-1" role="button"><i class="bi bi-instagram"></i></a>
                    <a href="#" class="btn btn-warning btn-floating m-1" role="button"><i class="bi bi-youtube"></i></a>
                </div>
            </div>
            
            <!-- Cột 2: Liên kết nhanh -->
            <div class="col-md-2 col-lg-2 col-xl-2 mx-auto mt-3">
                <h5 class="text-uppercase mb-4 fw-bold text-warning">Liên kết</h5>
                <p><a href="about.jsp" class="text-white">Về chúng tôi</a></p>
                <p><a href="shop" class="text-white">Cửa hàng</a></p>
                <p><a href="faq.jsp" class="text-white">Câu hỏi (FAQ)</a></p>
            </div>

            <!-- Cột 3: Chính sách -->
            <div class="col-md-3 col-lg-2 col-xl-2 mx-auto mt-3">
                <h5 class="text-uppercase mb-4 fw-bold text-warning">Chính sách</h5>
                <p><a href="#" class="text-white">Chính sách bảo mật</a></p>
                <p><a href="#" class="text-white">Chính sách đổi trả</a></p>
                <p><a href="#" class="text-white">Chính sách giao hàng</a></p>
                <p><a href="#" class="text-white">Điều khoản dịch vụ</a></p>
            </div>

            <!-- Cột 4: Liên hệ -->
            <div class="col-md-3 col-lg-3 col-xl-3 mx-auto mt-3">
                <h5 class="text-uppercase mb-4 fw-bold text-warning">Liên hệ</h5>
                <p><i class="bi bi-geo-alt-fill me-3"></i> 218 Lĩnh Nam, Hoàng Mai, Hà Nội</p>
                <p><i class="bi bi-envelope-fill me-3"></i> cskh@healthlife.com</p>
                <p><i class="bi bi-telephone-fill me-3"></i> 0969.333.298</p>
            </div>
        </div>

        <hr class="my-3">

        <div class="text-center py-2">
            <p>© 2025 HealthLife. Đã đăng ký Bản quyền.</p>
        </div>
    </div>
</footer>

<style>
    .footer a {
        text-decoration: none;
    }
    .footer a:hover {
        text-decoration: underline;
    }
</style>